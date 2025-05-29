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
waitUntil { (EGVAR(game,Game) getVariable [QEGVAR(game,game_state), -1]) >= GAME_STATE_INIT };

private _siloNum = _module getVariable "silonumber";

// User input checks
private _syncedSilos = synchronizedObjects _module select { _x isKindOf "B_Ship_MRLS_01_F" };
if (count _syncedSilos > 1) exitWith {
    ERROR_WITH_TITLE_1("ModuleAddSilo","Expected silos: 1 | Synced: %1",count _syncedSilos);
};
if (count _syncedSilos <= 0) exitWith {
    ERROR_WITH_TITLE("ModuleAddSilo","Expected silos: 1 | Synced: 0");
};

// Execute
private _silo = _syncedSilos#0;
INFO_1("ModuleAddSilo: Adding silo: %1",_siloNum);
[_silo, _siloNum] call EFUNC(game,InitSilo);