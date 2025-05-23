#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_typeData", [], [[]], 2],
    ["_position", [0,0,0]],
    ["_direction", 0],
    ["_classData", [], [[]]],
    ["_respawnTime", 30]
];

if (isNil QGVAR(VehicleInitQueue)) then { GVAR(VehicleInitQueue) = [] };

GVAR(VehicleInitQueue) pushBack _this;