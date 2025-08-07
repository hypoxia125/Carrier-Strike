#include "script_component.hpp"

GVAR(SystemBase) = createHashMapObject [[
    ["#type", "SystemBase"],
    ["#create", {
        if ((_self get "#type" select 0) == "SystemBase") exitWith {};

        _self call ["SystemStart"];
    }],

    ["m_updateRate", 1],
    ["m_frameSystemHandle", -1],
    ["m_entities", []],

    //------------------------------------------------------------------------------------------------
    ["Update", {}],

    //------------------------------------------------------------------------------------------------
    ["Register", {}],

    //------------------------------------------------------------------------------------------------
    ["Unregister", {}],

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
