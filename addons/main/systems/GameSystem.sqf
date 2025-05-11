#include "script_component.hpp"

if (!isNil QGVAR(GameSystem)) exitWith {};

GVAR(GameSystem) = createHashMapObject [[
    ["#type", "GameSystem"],
    ["#create", {}],

    ["m_updateRate", 1],
    ["m_frameSystemHandle", -1],
    ["m_entities", []],

    //------------------------------------------------------------------------------------------------
    ["Update", {}],

    //------------------------------------------------------------------------------------------------
    ["Register", {
        params ["_entity"];
        if (isNil "_entity") exitWith {};

        private _entities = _self get "m_entities";
        private _idx = _entities find _entity;
        if (_idx != -1) exitWith {
            LOG_1("%1::Register | Entity already registered.",(_self get "#type")#0);
        };

        _entities insert [-1, [_entity]];
        _self set ["m_entities", _entities];

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