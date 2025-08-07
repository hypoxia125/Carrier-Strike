#include "script_component.hpp"

if (!isServer) exitWith {};
if (!isNil QGVAR(CommanderTimeoutSystem)) exitWith {};

GVAR(CommanderTimeoutSystem) = createHashMapObject [[
    ["#type", "CommanderTimeoutSystem"],
    ["#create", {
        _commanderData = createHashMapFromArray [
            ["commanders", createHashMapFromArray [
                [west, "-1"],
                [east, "-1"]
            ]],
            ["commanderNames", createHashMapFromArray [
                [west, ""],
                [east, ""]
            ]],
            ["scanCooldowns", createHashMapFromArray [
                [west, _self get "m_scanCooldownTime"],
                [east, _self get "m_scanCooldownTime"]
            ]],
            ["uavCooldowns", createHashMapFromArray [
                [west, _self get "m_uavCooldownTime"],
                [east, _self get "m_uavCooldownTime"]
            ]],
            ["artilleryCooldowns", createHashMapFromArray [
                [west, _self get "m_artilleryCooldownTime"],
                [east, _self get "m_artilleryCooldownTime"]
            ]]
        ];
        missionNamespace setVariable [QGVAR(CommanderData), _commanderData, true];

        _self call ["SystemStart", []];
    }],

    ["m_updateRate", 1],
    ["m_frameSystemHandle", -1],

    ["m_scanCooldownTime", [QGVAR(Settings_CommanderScanCooldown)] call CBA_settings_fnc_get],
    ["m_uavCooldownTime", [QGVAR(Settings_CommanderUAVCooldown)] call CBA_settings_fnc_get],
    ["m_artilleryCooldownTime", [QGVAR(Settings_CommanderArtilleryCooldown)] call CBA_settings_fnc_get],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
        if (isNil "_commanderData") exitWith {};

        _scanCooldowns = _commanderData get "scanCooldowns";
        {
            private _side = _x;
            private _value = _y;

            _value = (_value - 1) max 0;

            _scanCooldowns set [_x, _value];
        } forEach _scanCooldowns;

        _uavCooldowns = _commanderData get "uavCooldowns";
        {
            private _side = _x;
            private _value = _y;

            _value = (_value - 1) max 0;

            _uavCooldowns set [_x, _value];
        } forEach _uavCooldowns;

        _artilleryCooldowns = _commanderData get "artilleryCooldowns";
        {
            private _side = _x;
            private _value = _y;

            _value = (_value - 1) max 0;

            _artilleryCooldowns set [_x, _value];
        } forEach _artilleryCooldowns;

        missionNamespace setVariable [QGVAR(CommanderData), _commanderData, true];
        [QEGVAR(ui,UpdateCommanderMenu)] call CBA_fnc_globalEvent;
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
]]
