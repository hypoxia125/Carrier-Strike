#include "script_component.hpp"

params ["_unit"];

private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
if (isNil "_commanderData") exitWith { false };
private _commander = _commanderData get "commanders" get (side group _unit);

_commander == getPlayerID _unit;
