#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_typeData", [], [[]], 2],
    ["_position", [0,0,0]],
    ["_direction", 0],
    ["_classData", [], [[]]],
    ["_respawnTime", 30],
    ["_code", {}, [{}]]
];

if (isNil QGVAR(VehicleInitQueue)) then { GVAR(VehicleInitQueue) = [] };

// duplicate check
private _idx = GVAR(VehicleInitQueue) findIf {
    _x#0 isEqualTo _typeData &&
    _x#1 isEqualTo _position &&
    _x#2 == _direction &&
    _x#3 isEqualTo _classData &&
    _x#5 isEqualTo _code
};
if (_idx != -1) exitWith {};

GVAR(VehicleInitQueue) pushBack _this;