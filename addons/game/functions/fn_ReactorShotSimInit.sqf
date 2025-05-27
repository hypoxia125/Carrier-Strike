#include "script_component.hpp"

params ["_mode"];

switch _mode do {
    case "client": {
        if (!hasInterface) exitWith {};

        params ["_mode", "_projectile"];

        private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));

        // LOG_2("ReactorShotSimInit::Client | Processing projectile: [%1, %2]",_projectile,_simulation);

        // Explosion event handler on projectile
        private _explosionEH = _projectile addEventHandler ["HitExplosion", {
            params ["_projectile", "_hitEntity", "_projectileOwner", "_hitSelections", "_instigator"];

            private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));

            if !(alive _hitEntity) exitWith {};

            private _isReactor = _hitEntity in (GVAR(Game) getVariable QGVAR(reactors));
            private _side = _hitEntity getVariable [QGVAR(side), sideUnknown];
            private _isVulnerable = (GVAR(Game) getVariable QGVAR(reactor_vulnerabilities)) get _side;
            private _isFF = (_side isEqualTo side group _projectileOwner);
            private _isUnique = (_projectile getVariable QGVAR(Reactor_Shot_ReactorsHit) pushBackUnique _hitEntity != -1);

            if (!_isReactor) exitWith {};
            if (!_isVulnerable) exitWith {};
            if (_isFF) exitWith {};
            if (!_isUnique) exitWith {};

            private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));
            [QGVAR(ReactorShotSimInit), ["server", _hitEntity, _simulation]] call CBA_fnc_serverEvent;
        }];

        // Hitpart event handler on projectile
        private _hitPartEH = _projectile addEventHandler ["HitPart", {
            params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType", "_instigator"];

            private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));

            if !(alive _hitEntity) exitWith {};

            private _isReactor = _hitEntity in (GVAR(Game) getVariable QGVAR(reactors));
            private _side = _hitEntity getVariable [QGVAR(side), sideUnknown];
            private _isVulnerable = (GVAR(Game) getVariable QGVAR(reactor_vulnerabilities)) get _side;
            private _isFF = (_side isEqualTo side group _projectileOwner);
            private _isUnique = (_projectile getVariable QGVAR(Reactor_Shot_ReactorsHit) pushBackUnique _hitEntity != -1);

            if (!_isReactor) exitWith {};
            if (!_isVulnerable) exitWith {};
            if (_isFF) exitWith {};
            if (!_isUnique) exitWith {};

            private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));
            [QGVAR(ReactorShotSimInit), ["server", _hitEntity, _simulation]] call CBA_fnc_serverEvent;
        }];

        // Submunition handler on projectile
        private _subEH = _projectile addEventHandler ["SubmunitionCreated", {
            params ["_projectile", "_submunitionProjectile", "_pos", "_velocity"];

            [QGVAR(ReactorShotSimInit), ["client", _submunitionProjectile]] call CBA_fnc_localEvent;
        }];

        // Explode event for shotMine and shotGrenade
        if (_simulation in (["shotMine", "shotGrenade"] apply {toLowerANSI _x})) then {
            private _explodeEH = _projectile addEventHandler ["Explode", {
                params ["_projectile", "_pos", "_velocity"];

                private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));

                private _explosiveDistance = getNumber (configFile >> "CfgAmmo" >> typeOf _projectile >> "indirectHitRange");
                private _inRangeReactors = (GVAR(Game) getVariable QGVAR(reactors)) select {_x distance _projectile <= _explosiveDistance};

                if (_inRangeReactors isEqualTo []) exitWith {};

                private _simulation = toLowerANSI (getText (configFile >> "CfgAmmo" >> typeOf _projectile >> "simulation"));
                private _reactor = _inRangeReactors select 0;

                [QGVAR(ReactorShotSimInit), ["server", _reactor, _simulation]] call CBA_fnc_serverEvent;
            }];
        };
    };

    case "server": {
        if (!isServer) exitWith {};

        params ["_mode", "_reactor", "_simulation"];

        if (!alive _reactor) exitWith {};
        private _side = _reactor getVariable [QGVAR(side), sideUnknown];
        _simulation = toLowerANSI _simulation;

        private _reactorMaxHP = _reactor getVariable QGVAR(max_hp);

        private _damage = call {
            if (_simulation in (["shotMissile", "shotRocket"] apply {toLowerANSI _x})) exitWith { 12.5 };
            if (_simulation in (["shotBullet"] apply {toLowerANSI _x})) exitWith { 0.1 };
            if (_simulation in (["shotMine"] apply {toLowerANSI _x})) exitWith { 25 };
            if (_simulation in (["shotGrenade"] apply {toLowerANSI _x})) exitWith { 3.33 };
            0
        };

        private _reactorCurrentHP = _reactor getVariable QGVAR(current_hp);
        _reactorCurrentHP = _reactorCurrentHP - _damage;
        _reactor setVariable [QGVAR(current_hp), _reactorCurrentHP, true];

        if (_reactorCurrentHP <= 0) then {
            [_side, "reactor"] call FUNC(CarrierDamageDealt);
            _reactor setDamage 1;
        };
    };
};
