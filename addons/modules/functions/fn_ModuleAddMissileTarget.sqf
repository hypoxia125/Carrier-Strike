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

private _sideVal = _module getVariable "ownerSide";

private _side = switch _sideVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
    default { sideUnknown };
};

waitUntil { !isNil QEGVAR(game,Game) };

private _targetHash = EGVAR(game,Game) getVariable QEGVAR(game,missile_targets);

if !(isNull (_targetHash getOrDefault [_side, objNull])) exitWith {};

// Missile target
private _pos = getPosASL _module;
private _target = createVehicle ["laserTargetC", _pos, [], 0, "CAN_COLLIDE"];
_target setPosASL _pos;
_target attachTo [_module];
_target setVariable [QEGVAR(game,side), ([west, east] - [_side])#0, true];
civilian reportRemoteTarget [_target, 1e12];

_targetHash set [_side, _target];
EGVAR(game,Game) setVariable [QEGVAR(game,missile_targets), _targetHash, true];