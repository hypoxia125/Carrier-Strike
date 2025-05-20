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

LOG_1("ModuleAddVehicle:: SiloNumber: %1", _siloNumber);
LOG_1("ModuleAddVehicle:: Type: %1",_type);
if (_type == "silo") then {
    [
        ["silo", _siloNumber],
        ASLToAGL getPosASL _module,
        _dir,
        [_westType, _eastType, _independentType],
        _respawnTime
    ] call EFUNC(main,AddToVehicleInitQueue);
};
if (_type == "base") then {
    [
        ["base", _side],
        ASLToAGL getPosASL _module,
        _dir,
        [_westType, _eastType, _independentType],
        _respawnTime
    ] call EFUNC(main,AddToVehicleInitQueue);
};
if (_type == "carrier") then {
    [
        ["carrier", _side],
        ASLToAGL getPosASL _module,
        _dir,
        [_westType, _eastType, _independentType],
        _respawnTime
    ] call EFUNC(main,AddToVehicleInitQueue);
};