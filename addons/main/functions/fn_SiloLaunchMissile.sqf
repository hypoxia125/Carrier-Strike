#include "script_component.hpp"

if !(isServer) exitWith {};

params ["_silo"];

private _side = _silo getVariable [QGVAR(side), sideUnknown];

// TODO: Grab target for silo

/*

if (isNull _target) exitWith {};

private _muzzle = currentMuzzle gunner _silo;
private _currentAmmo = _silo ammo _muzzle;

if (_currentAmmo <= 0) then {
    _silo setAmmo [_muzzle, 18];
};

_silo setWeaponReloadingTime [gunner _silo, _muzzle, 0];

// TODO: Build fired event handler
[_silo] call FUNC(SiloFiredEventHandler);
_silo fireAtTarget [_target, _muzzle];

*/