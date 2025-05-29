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

private _positionASL = getPosASL _module;
private _data = _carrier getVariable [QEGVAR(game,speaker_positions), []];
_data pushBackUnique _positionASL;
_carrier setVariable [QEGVAR(game,speaker_positions), _data, true];