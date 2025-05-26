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

private _sideVal = _module getVariable "side";

private _side = switch _sideVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
    default { sideUnknown };
};

private _syncedCarrier = synchronizedObjects _module select { _x isKindOf "Land_Carrier_01_base_F" };
if (count _syncedCarrier > 1) exitWith {
    ERROR(QGVAR(ModuleAddCarrier) + " too many carriers are synced too this module. Not going to add any of them!");
};
private _carrier = _syncedCarrier#0;
if (isNil "_carrier") exitWith {};

[_carrier, _side] call EFUNC(game,AddToCarrierInitQueue);