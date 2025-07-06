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

waitUntil { (missionNamespace getVariable [QEGVAR(game,game_state), -1]) >= GAME_STATE_POSTINIT };
sleep 1;

private _ownerVal = _module getVariable "owner";
private _typeVal = _module getVariable "type";
private _westType = _module getVariable ["westtype", ""];
private _eastType = _module getVariable ["easttype", ""];
private _independentType = _module getVariable ["independenttype", ""];
private _respawnTime = _module getVariable ["respawntime", 30];
private _code = compile (_module getVariable ["expression", "params [""_newVehicle"", ""_side""];"]);

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

// User input checks
LOG("ModuleAddVehicle | Getting synced objects...");
private _synced = synchronizedObjects _module select { !(_x isKindOf "EmptyDetector") };
if (count _synced == 0) exitWith {
    ERROR_WITH_TITLE("ModuleAddVehicle","Needs to have a synced vehicle.");
};
LOG_2("ModuleAddVehicle | %1 synced vehicles found: %2",count _synced,_synced);

{
    private _syncedObject = _x;

    if (isNull _syncedObject) then { continue };
    
    private _posASL = getPosASL _syncedObject;
    private _posAGL = ASLToAGL _posASL;
    _dir = getDir _syncedObject;
    deleteVehicle _syncedObject;

    if ([_westType, _eastType, _independentType] findIf {_x isKindOf "Air"} != -1) then {
        _posAGL = _posAGL vectorAdd [0,0,0.2];
    };

    LOG("ModuleAddVehicle | Attempting to add vehicle...");
    LOG_1("ModuleAddVehicle | Vehicle Type: %1",_type);
    LOG_1("ModuleAddVehicle | Vehicle Side: %1",_side);
    LOG_1("ModuleAddVehicle | Vehicle Pos: %1",_posAGL);
    LOG_1("ModuleAddVehicle | Vehicle Dir: %1",_dir);

    if (_type == "silo") then {
        [
            ["silo", _siloNumber],
            _posAGL,
            _dir,
            [_westType, _eastType, _independentType],
            _respawnTime,
            _code
        ] call EFUNC(game,InitVehicle);
    };
    if (_type == "base") then {
        [
            ["base", _side],
            _posAGL,
            _dir,
            [_westType, _eastType, _independentType],
            _respawnTime,
            _code
        ] call EFUNC(game,InitVehicle);
    };
    if (_type == "carrier") then {
        [
            ["carrier", _side],
            _posAGL,
            _dir,
            [_westType, _eastType, _independentType],
            _respawnTime,
            _code
        ] call EFUNC(game,InitVehicle);
    };
} forEach _synced;
