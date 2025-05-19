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

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _silos = _self get "m_entities";
        {
            private _silo = _x;
            if (!alive _silo) then {
                _self call ["Unregister", [_silo]];
                continue;
            };

            _self call ["UpdateSilo", [_silo]];
            _self call ["UpdateCapture", [_silo]];
        } forEach _silos;
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
        GVAR(Game) setVariable [QGVAR(silos), _entities, true];

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
        GVAR(Game) setVariable [QGVAR(silos), _self get "m_entities", true];

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
    ["UpdateSilo", {
        params ["_silo"];

        private _countdown = _silo getVariable QGVAR(countdown);
        private _isFiring = _silo getVariable QGVAR(is_firing);
        private _side = _silo getVariable QGVAR(side);

        // Launch missile sequence start
        if (_countdown <= 0 && _side isEqualTo sideUnknown) exitWith {
            _countdown = 0;
            _silo setVariable [QGVAR(countdown), 0];
            [_silo, "Ready"] call FUNC(HUDUpdateSiloCountdown);
        };
        if (_countdown <= 0) exitWith {
            if (!_isFiring) then {
                _silo setVariable [QGVAR(is_firing), true];
                _silo setVariable [QGVAR(countdown), 0];
                [_silo] call FUNC(SiloLaunchMissile);
                [_silo, "Launch"] call FUNC(HUDUpdateSiloCountdown);

                // Wait some time and reset silo
                [{
                    params ["_silo", "_self"];
                    private _countdown = _silo getVariable QGVAR(countdown);
                    private _countdownTime = _self get "m_countdownTime";

                    _silo setVariable [QGVAR(countdown), _countdownTime];
                    _silo setVariable [QGVAR(is_firing), false];
                }, [_silo, _self], 3] call CBA_fnc_waitAndExecute;
            };
        };

        [_silo, _countdown] call FUNC(HUDUpdateSiloCountdown);
        [_silo] call FUNC(SiloCountdownWarning);

        // Increment countdown
        _countdown = _countdown - 1;
        _silo setVariable [QGVAR(countdown), _countdown];
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateCapture", {
        params ["_silo"];

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
                [_silo, west, 0, _updateRate / 2] call FUNC(HUDUpdateSiloStatus);
                [_silo, east, 0, _updateRate / 2] call FUNC(HUDUpdateSiloStatus);
            }
        };

        // Handle state transitions
        // Switch side to west
        if (_currentProgress <= -1) then {
            _currentSide = west;
            _currentProgress = -1;
        };
        // Switch side to east
        if (_currentProgress >= 1) then {
            _currentSide = east;
            _currentProgress = 1;
        };
        // Switch side to neutral
        if (_currentSide == west && _currentProgress >= 0) then {
            _currentSide = sideUnknown;
        };
        if (_currentSide == east && _currentProgress <= 0) then {
            _currentSide = sideUnknown;
        };

        // Update HUD
        if (!_isContested) then {
            if (_currentProgress < 0) then {
                [_silo, west, abs _currentProgress, 1] call FUNC(HUDUpdateSiloStatus);
                [_silo, east, 0, _updateRate / 2] call FUNC(HUDUpdateSiloStatus);
            };
            if (_currentProgress > 0) then {
                [_silo, east, abs _currentProgress, 1] call FUNC(HUDUpdateSiloStatus);
                [_silo, west, 0, _updateRate / 2] call FUNC(HUDUpdateSiloStatus);
            };
        };

        _silo setVariable [QGVAR(captureProgress), _currentProgress];

        // Update variables
        [_silo, _currentSide] call FUNC(SiloUpdateOwnership);
        _silo setVariable [QGVAR(captureProgress), _currentProgress, true];
    }]
]];