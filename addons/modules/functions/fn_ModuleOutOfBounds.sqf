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

private _area = _module getVariable "ObjectArea";
_area = [getPosASL _module] + _area;

private _westEnabled = _module getVariable "WestEnabled";
private _eastEnabled = _module getVariable "EastEnabled";
private _independenetEnabled = _module getVariable "IndependentEnabled";
private _planeEnabled = _module getVariable "PlaneEnabled";
private _heliEnabled = _module getVariable "HeliEnabled";

private _dataHash = createHashmapFromArray [
    ["area", _area],
    ["west_enabled", _westEnabled],
    ["east_enabled", _eastEnabled],
    ["independent_enabled", _independentEnabled],
    ["plane_enabled", _planeEnabled],
    ["heli_enabled", _heliEnabled]
];

