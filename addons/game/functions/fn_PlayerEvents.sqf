#include "script_component.hpp"

params ["_player"];

if (!local _player) exitWith {};

///  Reactor ShotInit
///  Allows for singular hit with explosives and custom damage handling on the carrier reactors
///  There is a client component and a server component to this system
_player addEventHandler ["FiredMan", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

    private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));

    if (isNil {GVAR(Game) getVariable QGVAR(reactor_relavant_shots)}) then {
        GVAR(Game) setVariable [QGVAR(reactor_relavant_shots), createHashMap];
    };

    if (GVAR(Game) getVariable QGVAR(reactor_relavant_shots) getOrDefaultCall [_ammo, {
            private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));
            private _valid = _simulation in (["shotMissile", "shotRocket", "shotBullet", "shotMine", "shotGrenade"] apply {toLowerANSI _x});

            !_valid
        }, true]
    ) exitWith {};

    _projectile setVariable [QGVAR(Reactor_Shot_ReactorsHit), []];
    [QGVAR(ReactorShotSimInit), ["client", _projectile]] call CBA_fnc_localEvent;
}];
