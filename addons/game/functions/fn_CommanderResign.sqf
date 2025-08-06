#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_unit"];
private _side = side group _unit;

[QGVAR(HintSilent), [format["Commander %1 has resigned.",name _unit]]] call CBA_fnc_globalEvent;
[_side] call FUNC(CommanderUnassign);
