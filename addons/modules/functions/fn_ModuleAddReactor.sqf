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

waitUntil { (missionNamespace getVariable [QEGVAR(game,game_state), -1]) >= GAME_STATE_INIT };

private _sideVal = _module getVariable "side";

private _side = switch _sideVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
    default { sideUnknown };
};

// User input checks
private _syncedReactors = synchronizedObjects _module select {
    !(_x isKindOf "EmptyDetector") &&
    !(_x isKindOf "Module_F")
};

if (count _syncedReactors <= 0) exitWith {
    ERROR_WITH_TITLE("ModuleAddReactor","Expected synced objects: > 1 | Passed: 0");
};

// Execute
INFO_2("ModuleAddReactor: Adding %1 reactors for side: %2",count _syncedReactors,_side);
{ [_x, _side] call EFUNC(game,InitReactor) } forEach _syncedReactors;