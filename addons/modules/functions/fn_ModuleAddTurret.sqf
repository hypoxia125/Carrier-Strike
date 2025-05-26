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
private _minTurn = _module getVariable ["minTurn", -180];
private _maxTurn = _module getVariable ["maxTurn", 180];
private _minElev = _module getVariable ["minElev", -90];
private _maxElev = _module getVariable ["maxElev", 90];
private _AILogicVal = _module getVariable "aitype";
private _maxRange = _module getVariable ["maxRange", 1000];
private _destroyPercent = _module getVariable ["destroyPercent", 0.5];

private _turretLimits = [_minTurn, _maxTurn, _minElev, _maxElev];

private _side = switch _sideVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
    default { sideUnknown };
};

private _ailogic = switch _AILogicVal do {
    case 0: { "antiair" };
    default { "" };
};

private _syncedTurrets = synchronizedObjects _module select {
    private _isUAV = getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "isUAV") == 1;
    
    _isUAV || (_x isKindOf "StaticMGWeapon")
};

{ [_x, _side, _turretLimits, _AILogic, _maxRange, _destroyPercent] call EFUNC(game,AddToTurretInitQueue) } forEach _syncedTurrets;