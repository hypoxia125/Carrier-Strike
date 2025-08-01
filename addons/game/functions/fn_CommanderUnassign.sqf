#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_side"];

private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
private _commanders = _commanderData get "commanders";
private _commander = _commanders get (_side);

_commanders set [_side, "-1"];

private _commanderNames = _commanderData get "commanderNames";
_commanderNames set [_side, ""];

[QEGVAR(ui,UpdateCommanderNameTopBar), ["", _side]] call CBA_fnc_globalEvent;

missionNamespace setVariable [QGVAR(CommanderData), _commanderData, true];
