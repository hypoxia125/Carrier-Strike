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

waitUntil { !isNil QEGVAR(game,Game) };
waitUntil {
    private _carriers = EGVAR(game,Game) getVariable [QEGVAR(game,carriers), createHashMap];
    private _carrier = _carriers getOrDefault [_side, objNull];
    !isNull _carrier;
};

private _carriers = EGVAR(game,Game) getVariable [QEGVAR(game,carriers), createHashMap];
private _carrier = _carriers getOrDefault [_side, objNull];

private _position = ASLToAGL getPosASL _module;
_carrier setVariable [QEGVAR(game,endGameCameraPosition), _position, true];