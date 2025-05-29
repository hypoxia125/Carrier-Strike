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

private _siloNum = _module getVariable "silonumber";

waitUntil { !isNil QEGVAR(game,Game) };
waitUntil {
    private _silos = EGVAR(game,Game) getVariable [QEGVAR(game,silos), []];
    _silos isNotEqualTo [];
};
sleep 0.5;

private _silos = EGVAR(game,Game) getVariable [QEGVAR(game,silos), []];
private _silo = _silos select { _x getVariable QEGVAR(game,silo_number) == _siloNum };
_silo = _silo#0;

private _positionASL = getPosASL _module;
private _data = _silo getVariable [QEGVAR(game,speaker_positions), []];
_data pushBackUnique _positionASL;
_silo setVariable [QEGVAR(game,speaker_positions), _data, true];