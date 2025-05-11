#include "script_component.hpp"

if (!isNil QGVAR(SiloControlSystem)) exitWith {};

GVAR(SiloControlSystem) = createHashMapObject [[
    ["#base", GVAR(GameSystem)],
    ["#type", "SiloControlSystem"],
    ["#create", {
        _self call ["SystemStart", []];
    }],

    ["m_siloCountdownTime", [QGVAR(Settings_SiloLaunchCooldown), "server"] call CBA_settings_fnc_get],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        LOG_1("%1::Update | Updating entities.",(_self get "#type")#0);
        LOG_2("%1::Update | %2",(_self get "#type")#0,(_self get "m_entities"));
        private _silos = _self get "m_entities";
        {
            private _silo = _x;
            if (!alive _silo) then {
                _self call ["Unregister", [_silo]];
                continue;
            };

            _self call ["UpdateSilo", [_silo]];
        } forEach _silos;
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateSilo", {
        params ["_silo"];

        private _countdown = _silo getVariable QGVAR(countdown);
        private _isFiring = _silo getVariable QGVAR(isFiring);
        private _side = _silo getVariable QGVAR(side);

        // Launch missile sequence start
        if (_countdown <= 0 && _side isEqualTo sideUnknown) exitWith {};
        if (_countdown <= 0) then {

            if (!isFiring) then {
                _silo setVariable [QGVAR(isFiring), true];
                [_silo] call FUNC(SiloLaunchMissile);

                // Wait some time and reset silo
                [{
                    params ["_silo"];
                    private _countdown = _silo getVariable QGVAR(countdown);
                    private _countdownTime = _self get "siloCountdownTime";

                    _silo setVariable [QGVAR(countdown), _countdownTime];
                    _silo setVariable [QGVAR(isFiring), false];
                }, [_silo], 3] call CBA_fnc_waitAndExecute;
            };
        };

        [_silo] call FUNC(SiloCountdownWarning);

        // Increment countdown
        _countdown = _countdown - 1;
        _silo setVariable [QGVAR(countdown), _countdown];

        LOG_2("SiloControlSystem::Update | Silo [%1] countdown: %2",_silo,_countdown);
    }]
]];