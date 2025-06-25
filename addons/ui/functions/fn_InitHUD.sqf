#include "script_component.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

"HUD" cutRsc [QGVAR(CarrierHUD), "PLAIN", 1e-6];

missionNamespace setVariable [QEGVAR(game,hud_initialized), true];

// Silo Enabled Check
[] spawn {
    waitUntil { time > 0 };

    private _updateSilos = {
        private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
        {
            if (_x getVariable [QEGVAR(game,enabled), false]) then {
                private _siloNumber = _x getVariable QEGVAR(game,silo_number);
                [_siloNumber, true] call FUNC(EnableSiloControl);
            };
        } forEach _silos;
    };

    while {
        sleep 1;
        private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
        _silos findIf { !(_x getVariable [QEGVAR(game,enabled), false]) } != -1
    } do {
        call _updateSilos;
    };

    call _updateSilos;
};