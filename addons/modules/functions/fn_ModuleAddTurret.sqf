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

private _syncedTurrets = synchronizedObjects _module;

// User input checks
private _wrongTypes = [];
if (count _syncedTurrets <= 0) exitWith {
    ERROR_WITH_TITLE("ModuleAddTurret","Expected turrets: >= 1 | Passed: 0");
};
{
    private _isUAV = getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "isUAV") == 1;
    if (!_isUAV || !(_x isKindOf "StaticMGWeapon")) then {
        _wrongTypes pushBack _x;
    }
} forEach _syncedTurrets;

if (_wrongTypes isNotEqualTo []) exitWith {
    ERROR_WITH_TITLE_1("ModuleAddTurret","Wrong kinds of objects synced to module: %1",_wrongTypes apply {typeOf _x});
};

// Execute
INFO_2("ModuleAddReactor: Adding %1 turrets for side: %2",count _syncedTurrets,_side);
{ [_x, _side, _turretLimits, _AILogic, _maxRange, _destroyPercent] call EFUNC(game,InitTurret) } forEach _syncedTurrets;
