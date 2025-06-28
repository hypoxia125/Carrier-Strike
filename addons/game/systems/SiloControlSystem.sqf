/*
    Silo Control System
    Locality: Server

    Manages every silo's countdowns as well as capture progress and ownership for each team
*/

#include "script_component.hpp"

if (!isServer) exitWith {};
if (!isNil QGVAR(SiloControlSystem)) exitWith {};

GVAR(SiloControlSystem) = createHashMapObject [[
    ["#type", "SiloControlSystem"],
    ["#create", {
        _self call ["SystemStart", []];
    }],

    ["m_updateRate", 1],
    ["m_frameSystemHandle", -1],
    ["m_entities", []],

    ["m_countdownTime", [QGVAR(Settings_SiloLaunchCooldown)] call CBA_settings_fnc_get],
    ["m_captureTime", [QGVAR(Settings_SiloCaptureTime)] call CBA_settings_fnc_get],
    ["m_captureRadius", [QGVAR(Settings_SiloCaptureRadius)] call CBA_settings_fnc_get],
    ["m_seedingMode", [QGVAR(Settings_SeedingMode)] call CBA_settings_fnc_get],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _silos = _self get "m_entities";
        {
            private _silo = _x;
            if (!alive _silo) then {
                _self call ["Unregister", [_silo]];
                continue;
            };

            if (_self get "m_seedingMode") then {
                _self call ["UpdateSiloEnabled", [_silo]];
                if !(_silo getVariable [QGVAR(Enabled), false]) then { continue };
            } else {
                _self call ["UpdateSiloEnabled", [_silo, true]];
            };

            _self call ["UpdateSilo", [_silo]];
            _self call ["UpdateCapture", [_silo]];
        } forEach _silos;
    }],

    //------------------------------------------------------------------------------------------------
    ["SortSilos", {
        private _entities = _self get "m_entities";

        private _arr = _entities;
        for "_i" from 1 to (count _arr - 1) do {
            private _keyObj = _arr select _i;
            private _keyValue = _keyObj getVariable QGVAR(silo_number);
            private _j = _i - 1;
            
            while {_j >= 0 && ((_arr#_j) getVariable QGVAR(silo_number) > _keyValue)} do {
                _arr set [_j + 1, _arr select _j];
                _j = _j - 1;
            };
            
            _arr set [_j + 1, _keyObj];
        };

        _self set ["m_entities", _entities];
    }],

    //------------------------------------------------------------------------------------------------
    ["Register", {
        params ["_entity"];
        if (isNil "_entity") exitWith {};

        private _entities = _self get "m_entities";
        private _idx = _entities find _entity;
        if (_idx != -1) exitWith {
            LOG_1("%1::Register | Entity already registered.",(_self get "#type")#0);
        };

        _entities insert [-1, [_entity], true];
        _self set ["m_entities", _entities];

        // Broadcast
        _self call ["SortSilos"];
        missionNamespace setVariable [QGVAR(silos), _entities, true];

        LOG_2("%1::Register | Entity registered: %2",(_self get "#type")#0,_entity);
    }],

    //------------------------------------------------------------------------------------------------
    ["Unregister", {
        params ["_entity"];
        if (isNil "_entity") exitWith {};

        private _entities = _self get "m_entities";
        private _idx = _entities find _entity;
        if (_idx == -1) exitWith {
            LOG_1("%1::Unregister | Entity not managed by system.",(_self get "#type")#0);
        };

        _entities deleteAt _idx;
        _self set ["m_entities", _entities];

        // Broadcast
        missionNamespace setVariable [QGVAR(silos), _self get "m_entities", true];

        LOG_2("%1::Unregister | Entity unregistered: %2",(_self get "#type")#0,_entity);
    }],

    //------------------------------------------------------------------------------------------------
    ["SystemStart", {
        private _handle = [{
            params ["_args", "_handle"];
            _args params ["_self"];

            if (!isMultiplayer && isGamePaused) exitWith {};

            _self call ["Update", []];
        }, _self get "m_updateRate", [_self]] call CBA_fnc_addPerFrameHandler;

        LOG_1("%1::SystemStart | System started.",(_self get "#type")#0);

        _self set ["m_frameSystemHandle", _handle];
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateSiloEnabled", {
        params ["_silo", ["_forced", false]];

        private _siloNumber = _silo getVariable QGVAR(silo_number);
        if (_forced) exitWith { _silo setVariable [QGVAR(Enabled), true, true] };
        private _enabled = _silo getVariable [QGVAR(Enabled), false];
        if (_enabled) exitWith {};

        private _activeUnits = allUnits select {
            private _veh = objectParent _x;

            _x isKindOf "CAManBase" &&
            getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "isUAV") != 1
        };

        private _playerCountUnlock = _silo getVariable [QGVAR(player_count_unlock), 0];

        if (count _activeUnits >= _playerCountUnlock) then { _silo setVariable [QGVAR(Enabled), true, true] };
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateSilo", {
        params ["_silo"];

        if (missionNamespace getVariable QGVAR(game_state) >= GAME_STATE_ENDING) exitWith {
            [QEGVAR(ui,UpdateSiloCountdown), [_silo, ""]] call CBA_fnc_globalEvent;
        };

        private _countdown = _silo getVariable QGVAR(countdown);
        private _isFiring = _silo getVariable QGVAR(is_firing);
        private _side = _silo getVariable QGVAR(side);

        // Launch missile sequence start
        if (_countdown <= 0 && _side isEqualTo sideUnknown) exitWith {
            _countdown = 0;
            _silo setVariable [QGVAR(countdown), 0, true];
            [QEGVAR(ui,UpdateSiloCountdown), [_silo, "Ready"]] call CBA_fnc_globalEvent;
        };
        if (_countdown <= 0) exitWith {
            if (!_isFiring) then {
                _silo setVariable [QGVAR(is_firing), true];
                _silo setVariable [QGVAR(countdown), 0, true];
                [_silo] call FUNC(SiloLaunchMissile);
                [QEGVAR(ui,UpdateSiloCountdown), [_silo, "Launch"]] call CBA_fnc_globalEvent;

                // Wait some time and reset silo
                [{
                    params ["_silo", "_self"];
                    private _countdown = _silo getVariable QGVAR(countdown);
                    private _countdownTime = _self get "m_countdownTime";

                    _silo setVariable [QGVAR(countdown), _countdownTime, true];
                    _silo setVariable [QGVAR(is_firing), false];
                }, [_silo, _self], 3] call CBA_fnc_waitAndExecute;
            };
        };

        [QEGVAR(ui,UpdateSiloCountdown), [_silo, _countdown]] call CBA_fnc_globalEvent;
        
        private _alerts = missionNamespace getVariable QGVAR(alerts);
        private _silotimeremainingalerts = _alerts get "silotimeremaining";
        private _alert = _silotimeremainingalerts get _countdown;
        private _siloSpeakers = _silo getVariable [QGVAR(speaker_positions), []];
        if (!isNil "_alert") then {
            [_silo, _alert] call FUNC(SiloNotification);
            { [_silo, _alert, _x] call FUNC(SiloNotification) } forEach _siloSpeakers;
        };

        // Increment countdown
        _countdown = _countdown - 1;
        _silo setVariable [QGVAR(countdown), _countdown, true];
    }],

    //------------------------------------------------------------------------------------------------
    ["GetCaptureRateMultiplier", {
        params ["_side", "_captureUnits"];

        private _oppositeSide = [west, east] select (_side == west);
        private _friendlyUnits = _captureUnits get _side;
        private _enemyUnits = _captureUnits get _oppositeSide;

        if (_enemyUnits <= 0) exitWith { 1 + (_friendlyUnits * 0.1) }; // full bonus

        private _unitAdvantage = (_friendlyUnits - _enemyUnits) max 0;
        1 + (_unitAdvantage * 0.1);
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateCapture", {
        params ["_silo"];

        private _captureRadius = _self get "m_captureRadius";
        private _updateRate = _self get "m_updateRate";
        private _captureTime = _self get "m_captureTime";
        private _progressPerTick = _updateRate / _captureTime * 2;

        private _captureProg = _silo getVariable QGVAR(capture_progress);
        private _owner = _silo getVariable [QGVAR(side), sideUnknown];

        // Get present units
        private _fnc_getPresentUnits = {
            params ["_side"];
            import ["_silo", "_captureRadius"];
            { alive _x && {_x distance _silo <= _captureRadius} } count units _side;
        };
        private _captureUnits = createHashMapFromArray [
            [west, west call _fnc_getPresentUnits],
            [east, east call _fnc_getPresentUnits],
            [independent, independent call _fnc_getPresentUnits]
        ];
        
        switch true do {
            /*  Owner Exists */
            case (_owner != sideUnknown): {
                private _ownerUnitCount = _captureUnits get _owner;
                private _enemyUnitCount = _captureUnits get ([west, east] select (_owner == west));
                private _independentUnitCount = _captureUnits get independent;
                
                private _hasAdvantage = [_enemyUnitCount] findIf { _x > _ownerUnitCount } == -1;

                switch true do {
                    // Independent present - decay if no defender
                    case (_independentUnitCount > 0 && {_ownerUnitCount == 0}): {
                        {
                            private _value = 0 max (_y - _progressPerTick);
                            _captureProg set [_x, _value];
                        } forEach _captureProg;
                    };

                    // Defender lost advantage
                    case ([_enemyUnitCount] findIf { _x > _ownerUnitCount } != -1): {
                        private _value = 0 max ((_captureProg get _owner) - _progressPerTick);
                        _captureProg set [_owner, _value];
                    };

                    // Defender has advantage
                    default {
                        private _multi = _self call ["GetCaptureRateMultiplier", [_owner, _captureUnits]];
                        private _value = 1 min ((_captureProg get _owner) + (_progressPerTick * _multi));
                        _captureProg set [_owner, _value];
                    };
                };
            };

            /* No Owner */
            case (_owner == sideUnknown): {
                private _westUnitCount = _captureUnits get west;
                private _eastUnitCount = _captureUnits get east;
                private _independentUnitCount = _captureUnits get independent;
                private _totalUnits = _westUnitCount + _eastUnitCount;

                // If no units present, decay everything
                if (_totalUnits == 0) then {
                    {
                        private _value = 0 max (_y - _progressPerTick);
                        _captureProg set [_x, _value];
                    } forEach _captureProg;
                } else {
                    // Normal capture logic
                    switch true do {
                        // Independent present - decay if no defender
                        case (_independentUnitCount > 0 && {[_westUnitCount, _eastUnitCount] findIf {_x > 0} == -1}): {
                            {
                                private _value = 0 max (_y - _progressPerTick);
                                _captureProg set [_x, _value];
                            } forEach _captureProg;
                        };

                        // Increment side that has advantage
                        case (_westUnitCount != _eastUnitCount): {
                            private _dominantSide = [west, east] select (_westUnitCount < _eastUnitCount);
                            private _weakerSide = [west, east] select (_westUnitCount > _eastUnitCount);

                            // Only increment dominant if weaker side is at 0
                            if (_captureProg get _weakerSide <= 0) then {
                                private _multi = _self call ["GetCaptureRateMultiplier", [_dominantSide, _captureUnits]];
                                private _value = 1 min ((_captureProg get _dominantSide) + (_progressPerTick * _multi));
                                _captureProg set [_dominantSide, _value];
                            };

                            // Always decay weak side
                            private _value = 0 max ((_captureProg get _weakerSide) - _progressPerTick);
                            _captureProg set [_weakerSide, _value];
                        };
                        // Do nothing if counts are equal
                    };
                };
            };
        };

        private _newOwner = sideUnknown;
        private _highestProgress = 0;
        private _hasCaptureValue = false;

        {
            private _progress = _captureProg get _x;
            if (_progress >= 1 && {_progress > _highestProgress}) then {
                _newOwner = _x;
                _highestProgress = _progress;
            };

            if (_progress > 0) then { _hasCaptureValue = true };
        } forEach [west, east];

        if (_newOwner != sideUnknown) then {
            if (_newOwner != _owner) then {
                [_silo, _newOwner] call FUNC(SiloUpdateOwnership);
            };
        } else {
            {
                if (_y > 0) then { _hasCaptureValue = false; break };
            } forEach [west, east];
        };

        if (!_hasCaptureValue) then {
            if (_owner != sideUnknown) then {
                [_silo, sideUnknown] call FUNC(SiloUpdateOwnership);
            };            
        };

        // Update client UI
        {
            [QEGVAR(ui,UpdateSiloStatus), [_silo, _x, abs _y, _updateRate / 2]] call CBA_fnc_globalEvent;
        } forEach _captureProg;
    }]
]];