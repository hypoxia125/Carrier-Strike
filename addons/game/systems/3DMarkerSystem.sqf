/*
    3D Marker System
    Locality: Client

    Manages Draw3D code for things like silo icons, missiles flying through air, etc
*/

#include "script_component.hpp"

if (!hasInterface) exitWith {};
if (!isNil QGVAR(3DMarkerSystem)) exitWith {};

GVAR(3DMarkerSystem) = createHashMapObject [[
    ["#type", "3DMarkerSystem"],
    ["#create", {
        if (!hasInterface) exitWith {};
        _self call ["SystemStart", []];
    }],

    ["m_frameSystemHandle", -1],
    ["m_codeArray", []],

    //------------------------------------------------------------------------------------------------
    ["Register", {
        params [["_code", {}, [{}]]];

        private _codeArray = _self get "m_codeArray";
        private _idx = _codeArray find _code;
        if (_idx != -1) exitWith {
            LOG_1("%1::Register | Code already registered.",(_self get "#type")#0);
        };

        _codeArray insert [-1, [_code]];
        _self set ["m_codeArray", _codeArray];

        LOG_1("%1::Register | Code registered",(_self get "#type")#0);
    }],

    //------------------------------------------------------------------------------------------------
    ["Unregister", {
        params [["_code", {}, [{}]]];

        private _codeArray = _self get "m_codeArray";
        private _idx = _codeArray find _code;
        if (_idx == -1) exitWith {
            LOG_1("%1::Unregister | Code not managed by system.",(_self get "#type")#0);
        };

        _codeArray deleteAt _idx;
        _self set ["m_codeArray", _codeArray];

        LOG_1("%1::Unregister | Code unregistered",(_self get "#type")#0);
    }],

    //------------------------------------------------------------------------------------------------
    ["SystemStart", {
        private _handle = addMissionEventHandler ["Draw3D", {
            _thisArgs params ["_self"];

            private _codeArray = _self get "m_codeArray";
            { call _x } forEach _codeArray;
        }, [_self]];

        LOG_1("%1::SystemStart | System started.",(_self get "#type")#0);

        _self set ["m_frameSystemHandle", _handle];
    }]
]];