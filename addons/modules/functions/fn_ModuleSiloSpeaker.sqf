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
waitUntil { time > 0 };

private _siloNum = _module getVariable "silonumber";

private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
private _silo = _silos select { _x getVariable QEGVAR(game,silo_number) == _siloNum };
_silo = _silo#0;

private _siloNum = _silo getVariable [QEGVAR(game,silo_number), -1];
private _positionASL = getPosASL _module;
private _data = _silo getVariable [QEGVAR(game,speaker_positions), []];
_data pushBackUnique _positionASL;

_silo setVariable [QEGVAR(game,speaker_positions), _data, true];