#include "script_component.hpp"

waitUntil { time > 2 };
private _disabled = (missionNamespace getVariable [QGVAR(Silos), []]) select {!(_x getVariable [QGVAR(enabled), false])};

if !([QGVAR(Settings_SeedingMode)] call CBA_settings_fnc_get) exitWith {};

while {
    private _disabled = (missionNamespace getVariable [QGVAR(Silos), []]) select {!(_x getVariable [QGVAR(enabled), false])};
    _disabled isNotEqualTo []
} do {
    private _disabled = _disabled apply {_x getVariable QGVAR(silo_number)};
    _disabled = _disabled call BIS_fnc_sortNum;
    [QGVAR(NotificationSeedingModeEnabled), [_disabled]] call CBA_fnc_globalEvent;
    sleep 60;
};
