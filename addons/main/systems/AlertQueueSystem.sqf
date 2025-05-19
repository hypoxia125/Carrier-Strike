/*
    Alert Queue System
    Locality: Client

    Manages a list of alert sounds to be played once the previous alert is finished
*/

#include "script_component.hpp"

if (!hasInterface) exitWith {};
if (!isNil QGVAR(AlertQueueSystem)) exitWith {};

GVAR(AlertQueueSystem) = createHashMapObject [[
    ["#type", "AlertQueueSystem"],
    ["#create", {
        _self call ["SystemStart", []];
    }],

    ["m_updateRate", 0.5],
    ["m_frameSystemHandle", -1],
    ["m_alerts", []],
    ["m_currentAlert", objNull],

    ["Update", {
        private _currentAlert = _self get "m_currentAlert";
        if (isNull _currentAlert) then {
            private _newAlert = (_self get "m_alerts")#0;
            private _alert = playSound _newAlert;
            _self set ["m_currentAlert", _alert];
            _self call ["Unregister", [_alert]];
        };
    }],

    ["Register", {
        params ["_alert"];

        private _alerts = _self get "m_alerts";
        private _idx = _alerts find _alert;
        if (_idx != -1) exitWith {
            LOG_1("%1::Register | Alert already registered.",(_self get "#type")#0);
        };

        _alerts insert [-1, [_alert], true];
        _self set ["m_alerts", _alerts];

        LOG_2("%1::Register | Entity registered: %2",(_self get "#type")#0,_alert);
    }],

    ["Unregister", {
        params ["_alert"];

        private _alerts = _self get "m_alerts";
        private _idx = _alerts find _alert;
        if (_idx == -1) exitWith {
            LOG_1("%1::Unregister | Entity not managed by system.",(_self get "#type")#0);
        };

        _alerts deleteAt _idx;
        _self set ["m_alerts", _alerts];

        LOG_2("%1::Unregister | Entity unregistered: %2",(_self get "#type")#0,_alert);
    }]
]]