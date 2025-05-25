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

private _ownerVal = _module getVariable "owner";
private _typeVal = _module getVariable "type";
private _westType = _module getVariable ["westtype", ""];
private _eastType = _module getVariable ["easttype", ""];
private _independentType = _module getVariable ["independenttype", ""];
private _dir = _module getVariable ["dir", 0];
private _respawnTime = _module getVariable ["respawntime", 30];
private _code = compile (_module getVariable ["expression", "true"]);

private _type = switch _typeVal do {
    case 0: { "base" };
    case 1: { "carrier" };
    case 2: { "silo" };
};
private _side = switch _ownerVal do {
    case 0: { east };
    case 1: { west };
    case 2: { independent };
    default { sideUnknown };
};
private _siloNumber = switch _ownerVal do {
    case 3: { 1 };
    case 4: { 2 };
    case 5: { 3 };
    case 6: { 4 };
    case 7: { 5 };
};

private _posASL = getPosASL _module; _posASL vectorAdd [0,0,0.5];
private _posAGL = ASLToAGL _posASL;

if (_type == "silo") then {
    [
        ["silo", _siloNumber],
        _posAGL,
        _dir,
        [_westType, _eastType, _independentType],
        _respawnTime,
        _code
    ] call EFUNC(game,AddToVehicleInitQueue);
};
if (_type == "base") then {
    [
        ["base", _side],
        _posAGL,
        _dir,
        [_westType, _eastType, _independentType],
        _respawnTime,
        _code
    ] call EFUNC(game,AddToVehicleInitQueue);
};
if (_type == "carrier") then {
    [
        ["carrier", _side],
        _posAGL,
        _dir,
        [_westType, _eastType, _independentType],
        _respawnTime,
        _code
    ] call EFUNC(game,AddToVehicleInitQueue);
};