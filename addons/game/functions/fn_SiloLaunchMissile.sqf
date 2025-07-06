#include "script_component.hpp"

if !(isServer) exitWith {};

params ["_silo"];

private _side = _silo getVariable [QGVAR(side), sideUnknown];
private _targetSide = ([west, east] - [_side])#0;
private _missileTargets = missionNamespace getVariable QGVAR(missile_targets);
private _target = _missileTargets get _targetSide;

if (isNull _target) exitWith {};

private _muzzle = currentMuzzle gunner _silo;
private _currentAmmo = _silo ammo _muzzle;

if (_currentAmmo <= 0) then {
    _silo setAmmo [_muzzle, 18];
};

_silo setWeaponReloadingTime [gunner _silo, _muzzle, 0];

_silo fireAtTarget [_target, _muzzle];
