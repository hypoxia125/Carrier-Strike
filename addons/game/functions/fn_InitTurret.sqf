#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_turret", "_side", "_turretLimits", "_AIType", "_maxRange", "_destroyPercent"];
_turretLimits params ["_minTurn", "_maxTurn", "_minElev", "_maxElev"];

// delete current turret crew
{ deleteVehicle _x } forEach crew _turret;

_turret allowDamage false;
if (_turretLimits isNotEqualTo []) then {
    _turret setTurretLimits [[0], _minTurn, _maxTurn, _minElev, _maxElev]
};

private _group = createGroup _side;
private _units = units createVehicleCrew _turret;
_units joinSilent _group;

private _gunner = gunner _turret;
["AUTOTARGET", "TARGET", "SUPPRESSION", "PATH", "MOVE", "COVER", "RADIOPROTOCOL"] apply {_gunner disableAI _x};

private _dataHash = createHashMapFromArray [
    ["turret", _turret],
    ["max_range", _maxRange],
    ["ai_type", _AIType],
    ["destroy_percent", _destroyPercent],
    ["side", _side]
];

GVAR(TurretControlSystem) call ["Register", _dataHash];