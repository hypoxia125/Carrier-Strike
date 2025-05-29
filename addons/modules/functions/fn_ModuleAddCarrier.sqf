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

waitUntil { !isNil QEGVAR(game,Game) };
waitUntil { (EGVAR(game,Game) getVariable [QEGVAR(game,game_state), -1]) >= GAME_STATE_INIT };

private _sideVal = _module getVariable "side";

private _side = switch _sideVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
    default { sideUnknown };
};

// User input checks
private _syncedCarrier = synchronizedObjects _module;;
if (count _syncedCarrier > 1) exitWith {
    ERROR_WITH_TITLE("ModuleAddCarrier","Too many carriers/objects/triggers are synced too this module!");
};
if (count _syncedCarrier <= 0) exitWith {
    ERROR_WITH_TITLE("ModuleAddCarrier","Nothing is synced to this module!");
};

// Execute
private _carrier = _syncedCarrier#0;
INFO_1("ModuleAddCarrier: Adding carrier for side: %1",_side);
[_carrier, _side] call EFUNC(game,InitCarrier);