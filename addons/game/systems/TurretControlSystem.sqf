#include "script_component.hpp"

if (!isServer) exitWith {};
if (!isNil QGVAR(TurretControlSystem)) exitWith {};

GVAR(TurretControlSystem) = createHashMapObject [[
    ["#type", "TurretControlSystem"],
    ["#base", +GVAR(SystemBase)],

    ["m_updateRate", 0.2],
    ["m_entities", []],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _turretData = _self get "m_entities";
        {
            private _hash = _x;
            private _turret = _hash get "turret";
            private _maxRange = _hash get "max_range";
            private _aiType = _hash get "ai_type";
            private _destroyPercent = _hash get "destroy_percent";
            private _side = _hash get "side";

            if (!isMultiplayer && isGamePaused) then { continue };

            if (!alive _turret) then {
                _self call ["Unregister", [_hash]];
                continue;
            };

            // determine if it is time to destroy
            private _carrier = ((missionNamespace getVariable QGVAR(carriers)) get _side);
            if (isNull _carrier) then {
                continue;
            };
            private _carrierHP = _carrier getVariable QGVAR(current_hp);
            private _maxHP = _carrier getVariable QGVAR(max_hp);
            private _percent = _carrierHP / _maxHP;
            if (_percent <= _destroyPercent) then {
                _turret setDamage 1;
                continue;
            };

            if (!isVehicleRadarOn _turret) then { _turret setVehicleRadar 1 };

            switch _AIType do {
                case "antiair": {
                    private _target = _turret getVariable [QGVAR(currentTarget), objNull];
                    if (alive _target) then {
                        private _modelSelectionPos = _turret selectionPosition "optic";
                        private _pos = _turret modelToWorldWorld _modelSelectionPos;
                        private _isVisible = lineIntersects [_pos, getPosASL _target, _turret] isEqualTo [];
                        if (!_isVisible) then {
                            _turret setVariable [QGVAR(currentTarget), objNull];
                            gunner _turret doTarget objNull;
                            continue;
                        };
                    };

                    // Skip if target is alive
                    private _target = _turret getVariable [QGVAR(currentTarget), objNull];
                    if (alive _target) then { continue };

                    // Acquire new target //
                    _turret setVariable [QGVAR(currentTarget), objNull];
                    gunner _turret doTarget objNull;

                    private _airUnits = (entities "air") select {
                        alive _x &&
                        count crew _x > 0 &&
                        _x distance2D _turret <= _maxRange &&
                        crew _x findIf { !(side group _x in [side group gunner _turret, civilian]) } != -1
                    };

                    // order
                    _airUnits = [_airUnits, [_turret], {_x distance2D _input0}, "ASCEND"] call BIS_fnc_sortBy;

                    private _target = _airUnits param [0, objNull];
                    if (isNull _target) then { continue };

                    _turret reveal _target;
                    gunner _turret doTarget _target;
                    _turret setVariable [QGVAR(currentTarget), _target];

                    // rearm
                    _turret setVehicleAmmo 1;
                };
            };
        } forEach _turretData;
    }],

    //------------------------------------------------------------------------------------------------
    ["Register", {
        params ["_entity"];
        if (isNil "_entity") exitWith {};

        private _entities = _self get "m_entities";
        private _idx = _entities find _entity;
        if (_idx != -1) exitWith {
            LOG_1("%1::Register | Entity already registered.",(_self get "#type")#0);
        };

        _entities insert [-1, [_entity], true];
        _self set ["m_entities", _entities];

        // Broadcast
        missionNamespace setVariable [QGVAR(turrets), _entities, true];

        LOG_2("%1::Register | Entity registered: %2",(_self get "#type")#0,_entity);
    }],

    //------------------------------------------------------------------------------------------------
    ["Unregister", {
        params ["_entity"];
        if (isNil "_entity") exitWith {};

        private _entities = _self get "m_entities";
        private _idx = _entities find _entity;
        if (_idx == -1) exitWith {
            LOG_1("%1::Unregister | Entity not managed by system.",(_self get "#type")#0);
        };

        _entities deleteAt _idx;
        _self set ["m_entities", _entities];

        // Broadcast
        missionNamespace setVariable [QGVAR(turrets), _self get "m_entities", true];

        LOG_2("%1::Unregister | Entity unregistered: %2",(_self get "#type")#0,_entity);
    }]
]];
