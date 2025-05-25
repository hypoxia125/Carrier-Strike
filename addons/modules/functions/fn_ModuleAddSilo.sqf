#include "script_component.hpp"

// Parameters
//------------------------------------------------------------------------------------------------
params [
    ["_mode", "", [""]],
    ["_input", [], [[]]]
];
_input params [
    ["_module", objNull, [objNull]],
    ["_isActivated", false, [true]],
    ["_isCuratorPlaced", false, [true]]
];

// Pre-Execution Checks
//------------------------------------------------------------------------------------------------
if (!isServer) exitWith {};
if (is3DEN) exitWith {};

private _siloNum = _module getVariable "silonumber";

private _syncedSilos = synchronizedObjects _module select { _x isKindOf "B_Ship_MRLS_01_F" };
if (count _syncedSilos > 1) exitWith {
    ERROR(QGVAR(ModuleAddSilo) + " too many silos are synced too this module. Not going to add any of them!");
};
private _silo = _syncedSilos#0;
if (isNil "_silo") exitWith {};

[_silo, _siloNum] call EFUNC(game,AddToSiloInitQueue);