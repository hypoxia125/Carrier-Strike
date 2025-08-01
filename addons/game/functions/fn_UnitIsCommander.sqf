#include "script_component.hpp"

private ["_unit"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith { false };
private _commander = _commadnerData get "commanders" get (side group _unit);

_commander == getPlayerID _unit;
