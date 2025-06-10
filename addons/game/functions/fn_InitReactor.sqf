#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_reactor", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNull _reactor) exitWith {};

_reactor allowDamage false;

// Build data
private _data = createHashMapFromArray [
    ["side", _side],
    ["max_hp", [QGVAR(Settings_ReactorMaxHP)] call CBA_settings_fnc_get],
    ["current_hp", [QGVAR(Settings_ReactorMaxHP)] call CBA_settings_fnc_get]
];
{
    _reactor setVariable [format[QGVAR(%1),_x], _y, true];
} forEach _data;

// add to game data
private _reactorData = missionNamespace getVariable [QGVAR(reactors), []];
_reactorData pushBack _reactor;
missionNamespace setVariable [QGVAR(reactors), _reactorData, true];