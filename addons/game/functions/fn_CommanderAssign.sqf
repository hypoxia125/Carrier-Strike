#include "script_component.hpp"

params ["_playerID"];

private _userInfo = getUserInfo _playerID;
private _owner = _userInfo select 1;
private _name = _userInfo select 3;
private _unit = _userInfo select 10;

private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
private _commanders = _commanderData get "commanders";
private _commander = _commanders get (side group _unit);

_commanders set [side group _unit, _playerID];

private _commanderNames = _commanderData get "commanderNames";
_commanderNames set [side group _unit, _name];

missionNamespace setVariable [QGVAR(CommanderData), _commanderData, true];
