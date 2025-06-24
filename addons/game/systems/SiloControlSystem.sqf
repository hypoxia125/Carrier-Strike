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

        private _enabled = _silo getVariable [QGVAR(Enabled), false];
        if (_enabled) exitWith {};

        private _siloNumber = _silo getVariable QGVAR(silo_number);

        if (_forced) exitWith {
            _silo setVariable [QGVAR(Enabled), true, true];
            [QEGVAR(ui,EnableSiloControl), [_siloNumber, true]] call CBA_fnc_globalEventJIP;
        };

        private _activeUnits = allUnits select {
            private _veh = objectParent _x;

            _x isKindOf "CAManBase" &&
            getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "isUAV") != 1
        };

        private _playerCountUnlock = _silo getVariable [QGVAR(player_count_unlock), 0];

        if (count _activeUnits >= _playerCountUnlock) then {
            _silo setVariable [QGVAR(Enabled), true, true];
            [QEGVAR(ui,EnableSiloControl), [_siloNumber, true]] call CBA_fnc_globalEventJIP;
        };
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
    ["UpdateCapture", {
        params ["_silo"];

        private _siloNumber = _silo getVariable QGVAR(silo_number);

        // Get all units within capture radius
        private _captureRadius = _self get "m_captureRadius";
        private _nearUnits = allUnits inAreaArray [getPosATL _silo, _captureRadius, _captureRadius, 0, false];

        // Count units for each side
        private _westUnits = {side group _x == west} count _nearUnits;
        private _eastUnits = {side group _x == east} count _nearUnits;

        // Get current silo state
        private _currentSide = _silo getVariable [QGVAR(side), sideUnknown];
        private _currentProgress = _silo getVariable [QGVAR(captureProgress), 0];

        // Determine capturing team and advantage
        private _capturingSide = sideUnknown;
        private _unitAdvantage = 0;

        if (_westUnits > _eastUnits) then {
            _capturingSide = west;
            _unitAdvantage = _westUnits - _eastUnits;
            if (_eastUnits == 0) then { _unitAdvantage = 0 };
        };
        if (_eastUnits > _westUnits) then {
            _capturingSide = east;
            _unitAdvantage = _eastUnits - _westUnits;
            if (_westUnits == 0) then { _unitAdvantage = 0 };
        };
        private _isContested = (_eastUnits > 0 && _westUnits > 0) && (_eastUnits == _westUnits);

        // Calculate progress per tick
        private _updateRate = _self get "m_updateRate";
        private _captureTime = _self get "m_captureTime";
        private _progressPerTick = 0;

        private _baseProgress = _updateRate / _captureTime * 2;
        private _speedMultiplier = 1 + (_unitAdvantage * 0.1);
        _progressPerTick = _baseProgress * _speedMultiplier;

        // Apply direction
        switch _capturingSide do {
            case west: { _progressPerTick = _progressPerTick * -1 };
            case east: { _progressPerTick = _progressPerTick * 1 };
            // Maintain current owner if no capturing
            case sideUnknown: {
                switch _currentSide do {
                    case west: { _progressPerTick = _progressPerTick * -1 };
                    case east: { _progressPerTick = _progressPerTick * 1 };
                };
            };
        };

        // Update progress
        if (!_isContested) then {
            _currentProgress = (_currentProgress + _progressPerTick) max -1 min 1;
        };
        if (_capturingSide == sideUnknown && _currentSide == sideUnknown && !_isContested) then {
            if (_currentProgress != 0) then {
                _currentProgress = 0;
                [QEGVAR(ui,UpdateSiloStatus), [_silo, west, 0, _updateRate / 2]] call CBA_fnc_globalEvent;
                [QEGVAR(ui,UpdateSiloStatus), [_silo, east, 0, _updateRate / 2]] call CBA_fnc_globalEvent;
            };
        };

        // Handle state transitions
        private _fnc_getSidePlayers = {
            params ["_side"];
            allPlayers select { side group _x == _side };
        };
        private _alerts = missionNamespace getVariable QGVAR(alerts);
        private _respawn = _silo getVariable [QGVAR(respawn), []];
        // Switch side to west
        if (_currentProgress <= -1 && _currentSide != west) then {
            _currentSide = west;
            _currentProgress = -1;
            [QGVAR(AlertAddToSystem), [(_alerts get "silocapture") get _siloNumber], west call _fnc_getSidePlayers] call CBA_fnc_targetEvent;
            // Change respawn position
            if (count _respawn == 2) then {
                _respawn call BIS_fnc_removeRespawnPosition;
            };
            _respawn = [west, getPosATL _silo, format["Silo %1", _siloNumber]] call BIS_fnc_addRespawnPosition;
            _silo setVariable [QGVAR(respawn), _respawn];
        };
        // Switch side to east
        if (_currentProgress >= 1 && _currentSide != east) then {
            _currentSide = east;
            _currentProgress = 1;
            [QGVAR(AlertAddToSystem), [(_alerts get "silocapture") get _siloNumber], allPlayers select { side group _x == east }] call CBA_fnc_targetEvent;
            // Change respawn position
            if (count _respawn == 2) then {
                _respawn call BIS_fnc_removeRespawnPosition;
            };
            _respawn = [east, getPosATL _silo, format["Silo %1", _siloNumber]] call BIS_fnc_addRespawnPosition;
            _silo setVariable [QGVAR(respawn), _respawn];
        };
        // Switch side to neutral
        if (_currentSide == west && _currentProgress >= 0) then {
            _currentSide = sideUnknown;
            [QGVAR(AlertAddToSystem), [(_alerts get "silolost") get _siloNumber], allPlayers select { side group _x == west }] call CBA_fnc_targetEvent;
            // Change respawn position
            if (count _respawn == 2) then {
                _respawn call BIS_fnc_removeRespawnPosition;
            };
            _silo setVariable [QGVAR(respawn), nil];
        };
        if (_currentSide == east && _currentProgress <= 0) then {
            _currentSide = sideUnknown;
            [QGVAR(AlertAddToSystem), [(_alerts get "silolost") get _siloNumber], allPlayers select { side group _x == east }] call CBA_fnc_targetEvent;
            // Change respawn position
            if (count _respawn == 2) then {
                _respawn call BIS_fnc_removeRespawnPosition;
            };
            _silo setVariable [QGVAR(respawn), nil];
        };

        // Update HUD
        if (!_isContested) then {
            if (_currentProgress < 0) then {
                [QEGVAR(ui,UpdateSiloStatus), [_silo, west, abs _currentProgress, _updateRate / 2]] call CBA_fnc_globalEvent;
                [QEGVAR(ui,UpdateSiloStatus), [_silo, east, 0, _updateRate / 2]] call CBA_fnc_globalEvent;
            };
            if (_currentProgress > 0) then {
                [QEGVAR(ui,UpdateSiloStatus), [_silo, east, abs _currentProgress, _updateRate / 2]] call CBA_fnc_globalEvent;
                [QEGVAR(ui,UpdateSiloStatus), [_silo, west, 0, _updateRate / 2]] call CBA_fnc_globalEvent;
            };
        };

        _silo setVariable [QGVAR(captureProgress), _currentProgress];

        // Update variables
        [_silo, _currentSide] call FUNC(SiloUpdateOwnership);
        _silo setVariable [QGVAR(captureProgress), _currentProgress, true];
    }]
]];