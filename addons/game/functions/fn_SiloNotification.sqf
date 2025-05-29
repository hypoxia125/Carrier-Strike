#include "script_component.hpp"

params [["_silo", objNull], "_soundPath", ["_altPos", []]];

private _pos = getPosATL _silo vectorAdd [0,0,2];
private _distance = 200;

if (_altPos isNotEqualTo []) then {
    _pos = _altPos;
};

playSound3D [_soundPath, objNull, false, _pos, 5, 1, _distance];