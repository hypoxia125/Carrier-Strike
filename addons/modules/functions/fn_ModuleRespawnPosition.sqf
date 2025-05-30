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
waitUntil { (EGVAR(game,Game) getVariable [QEGVAR(game,game_state), -1]) >= GAME_STATE_POSTINIT };

private _sideVal = _module getVariable "side";
private _typeVal = _module getVariable "type";

private _side = switch _sideVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
};
private _type = switch _typeVal do {
    case 0: { "BASE" };
    case 1: { "CARRIER" };
};
private _nameSide = switch _sideVal do {
    case 0: { "OPFOR" };
    case 1: { "BLUFOR" };
    case 2: { "RESISTANCE" };
};
private _formattedName = _nameSide + " " + _type;

// Code Start
//------------------------------------------------------------------------------------------------
LOG(QGVAR(ModuleRespawnPosition) + ":: adding respawn position...");
private _respawnData = EGVAR(game,Game) getVariable QEGVAR(game,respawn_positions);
private _area = _module getVariable "ObjectArea";
_area = [getPosATL _module] + _area;

private _respawn = [_side, _area#0, _formattedName] call BIS_fnc_addRespawnPosition;

_respawnData insert [-1, [[_respawn, _type, _area]]];
EGVAR(game,Game) setVariable [QEGVAR(game,respawn_positions), _respawnData];

INFO_1("ModuleRespawnPosition: Adding respawn position for side: %1",_side);