/*
    Missile Tracking System
    Locality: Server

    Manages all missiles fired from silos and detects when they hit their target
*/

#include "script_component.hpp"

if (!isNil QGVAR(MissileTrackingSystem)) exitWith {};

GVAR(MissileTrackingSystem) = createHashMapObject [[
    ["#type", "MissileTrackingSystem"],
    ["#create", {
        _self call ["SystemStart", []];
    }],

    ["m_updateRate", 0],
    ["m_frameSystemHandle", -1],
    ["m_entities", []],
    ["m_sides", []],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _missiles = _self get "m_entities";
        {
            private _missile = _x;

            if (!alive _missile) then {
                private _side = (_self get "m_sides") # _forEachIndex;
                private _targets = missionNamespace getVariable QGVAR(missile_targets);
                private _target = _targets get _side;
                if (isNil "_target") exitWith {
                    LOG_1("%1::Update | No target found for missile",(_self get "#type")#0);
                    _self call ["Unregister", [_missile]];
                };
                private _targetSide = _target getVariable [QGVAR(side), sideUnknown];

                [_targetSide, "missile"] call FUNC(CarrierDamageDealt);
                _self call ["Unregister", [_missile]];
            };
        } forEach _missiles;
    }],

    //------------------------------------------------------------------------------------------------
    ["Register", {
        params ["_entity"];

        private _entities = _self get "m_entities";
        private _entitySides = _self get "m_sides";
        private _idx = _entities find _entity;
        if (_idx != -1) exitWith {
            LOG_1("%1::Register | Entity already registered.",(_self get "#type")#0);
        };

        _entities insert [-1, [_entity]];
        _entitySides insert [-1, [_entity getVariable [QGVAR(side), sideUnknown]]];
        _self set ["m_entities", _entities];
        _self set ["m_sides", _entitySides];

        // Broadcast
        missionNamespace setVariable [QGVAR(missiles), _self get "m_entities", true];

        LOG_2("%1::Register | Entity registered: %2",(_self get "#type")#0,_entity);
    }],

    //------------------------------------------------------------------------------------------------
    ["Unregister", {
        params ["_entity"];

        private _entities = _self get "m_entities";
        private _entitySides = _self get "m_sides";
        private _idx = _entities find _entity;
        if (_idx == -1) exitWith {
            LOG_1("%1::Unregister | Entity not managed by system.",(_self get "#type")#0);
        };

        _entities deleteAt _idx;
        _entitySides deleteAt _idx;
        _self set ["m_entities", _entities];
        _self set ["m_sides", _entitySides];

        //Broadcast
        missionNamespace setVariable [QGVAR(missiles), _self get "m_entities", true];

        LOG_2("%1::Unregister | Entity unregistered: %2",(_self get "#type")#0,_entity);
    }],

    //------------------------------------------------------------------------------------------------
    ["SystemStart", {
        private _handle = [{
            params ["_args", "_handle"];
            _args params ["_self"];

            if (!isMultiplayer && isGamePaused) exitWith {};

            _self call ["Update", []];
        }, _self get "m_updateRate", [_self]] call CBA_fnc_addPerFrameHandler;

        LOG_1("%1::SystemStart | System started.",(_self get "#type")#0);

        _self set ["m_frameSystemHandle", _handle];
    }]
]];