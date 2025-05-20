#include "script_component.hpp"

params ["_sound", "_soundPath"];

private _pos = getPosATL _silo vectorAdd [0,0,2];

playSound3D [
    _soundPath,
    objNull,
    false,
    _pos,
    5,
    1,
    200,
    0,
    true
];