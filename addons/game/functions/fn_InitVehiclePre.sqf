#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_typeData", [], [[]], 2],
    ["_position", [0,0,0]],
    ["_direction", 0],
    ["_classData", [], [[]]],
    ["_respawnTime", 30]
];

_classData params [["_classWest", "", [""]], ["_classEast", "", [""]], ["_classIndependent", "", [""]]];

private _owner = objNull;
private _ownerType = _typeData param [0, "", [""]];
switch toLowerANSI _ownerType do {
    case "silo": {
        private _siloNumber = _typeData param [1, -1, [-1]];
        private _silos = GVAR(Game) getVariable QGVAR(silos);
        private _silo = _silos select { _x getVariable QGVAR(silo_number) == _siloNumber };
        _owner = _silo#0;
    };

    case "carrier": {
        private _side = _typeData param [1, sideUnknown, [sideUnknown]];
        private _carriers = GVAR(Game) getVariable QGVAR(carriers);
        private _carrier = _carriers get _side;
        _owner = _carrier;
    };

    case "base": {
        private _side = _typeData param [1, sideUnknown, [sideUnknown]];
        _owner = _side;
    };
};

private _dataHash = createHashMapFromArray [
    [west, _classWest],
    [east, _classEast],
    [independent, _classIndependent],
    ["position", _position],
    ["direction", _direction],
    ["active_vehicle", objNull],
    ["respawn_time", _respawnTime],
    ["owner", _owner],
    ["countdown", _respawnTime],
    ["initial_spawn", true]
];

// Register to the system
GVAR(VehicleRespawnSystem) call ["Register", [_dataHash]];