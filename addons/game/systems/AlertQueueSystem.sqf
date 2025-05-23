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
    ["m_currentAlert", -1],

    ["Update", {
        private _currentAlert = _self get "m_currentAlert";
        private _allAlerts = _self get "m_alerts";
        if (soundParams _currentAlert isEqualTo []) then {
            private _newAlert = _allAlerts#0;
            private _alert = playSoundUI [_newAlert, 0.5];
            _self set ["m_currentAlert", _alert];
            _allAlerts deleteAt 0;
            _self get ["m_alerts", _allAlerts];
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

        LOG_2("%1::Register | Alert registered: %2",(_self get "#type")#0,_alert);
    }],

    // ["Unregister", {
    //     params ["_alert"];

    //     private _alerts = _self get "m_alerts";
    //     private _idx = _alerts find _alert;
    //     if (_idx == -1) exitWith {
    //         LOG_1("%1::Unregister | Alert not managed by system.",(_self get "#type")#0);
    //     };

    //     _alerts deleteAt _idx;
    //     _self set ["m_alerts", _alerts];

    //     LOG_2("%1::Unregister | Alert unregistered: %2",(_self get "#type")#0,_alert);
    // }]

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