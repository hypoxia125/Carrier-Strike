#include "script_component.hpp"

if (!isServer) exitWith {};

GVAR(Game) = true call CBA_fnc_CreateNamespace;

private _data = createHashMapFromArray [
    ["allSilos", []],
    ["gameState", ""],

    ["chatNotificationChannels", createHashMapFromArray [
        [west, -1],
        [east, -1],
        [independent, -1]
    ]],

    ["missile_targets", createHashMapFromArray [
        [west, objNull],
        [east, objNull],
        [independent, objNull]
    ]],

    ["carriers", createHashMapFromArray [
        [west, objNull],
        [east, objNull]
    ]],
    
    ["eventHandles", createHashMapFromArray [
    ]]
];

{
    GVAR(Game) setVariable [format[QGVAR(%1),_x], _y]
} forEach _data;