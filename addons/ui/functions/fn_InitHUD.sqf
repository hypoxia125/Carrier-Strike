#include "script_component.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

"HUD" cutRsc [QGVAR(CarrierHUD), "PLAIN", 1e-6];

missionNamespace setVariable [QEGVAR(game,hud_initialized), true];

// Hide unused silos
[] spawn {
    waitUntil { missionNamespace getVariable [QEGVAR(game,silos), []] isNotEqualTo [] };
    sleep 0.5;

    #include "\z\carrierstrike\addons\ui\defines.hpp"

    private _display = localNamespace getVariable [QGVAR(carrierHUD), displayNull];
    if (isNull _display) exitWith {};

    private _silosToRemove = [1, 2, 3, 4, 5];
    private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
    {
        private _silo = _x;
        private _siloNumber = _silo getVariable QEGVAR(game,silo_number);
        _silosToRemove = _silosToRemove - [_siloNumber];
    } forEach _silos;

    {
        private _siloNumber = _x;

        {
            private _side = _x;
            private ["_group", "_picture"];
            switch _side do {
                case west: {
                    switch _siloNumber do {
                        case 1: { _group = IDC_SILO_BLUE_1_GROUP; _picture = IDC_SILO_BLUE_1; };
                        case 2: { _group = IDC_SILO_BLUE_2_GROUP; _picture = IDC_SILO_BLUE_2; };
                        case 3: { _group = IDC_SILO_BLUE_3_GROUP; _picture = IDC_SILO_BLUE_3; };
                        case 4: { _group = IDC_SILO_BLUE_4_GROUP; _picture = IDC_SILO_BLUE_4; };
                        case 5: { _group = IDC_SILO_BLUE_5_GROUP; _picture = IDC_SILO_BLUE_5; };
                    };
                };
                case east: {
                    switch _siloNumber do {
                        case 1: { _group = IDC_SILO_RED_1_GROUP; _picture = IDC_SILO_RED_1; };
                        case 2: { _group = IDC_SILO_RED_2_GROUP; _picture = IDC_SILO_RED_2; };
                        case 3: { _group = IDC_SILO_RED_3_GROUP; _picture = IDC_SILO_RED_3; };
                        case 4: { _group = IDC_SILO_RED_4_GROUP; _picture = IDC_SILO_RED_4; };
                        case 5: { _group = IDC_SILO_RED_5_GROUP; _picture = IDC_SILO_RED_5; };
                    };
                };
            };

            _group = _display displayCtrl _group;
            _picture = _display displayCtrl _picture;

            _group ctrlShow false;
            _picture ctrlShow false;
        } forEach [west, east];

        private _picture = controlNull;
        switch _siloNumber do {
            case 1: { _picture = IDC_SILO_GREY_1 };
            case 2: { _picture = IDC_SILO_GREY_2 };
            case 3: { _picture = IDC_SILO_GREY_3 };
            case 4: { _picture = IDC_SILO_GREY_4 };
            case 5: { _picture = IDC_SILO_GREY_5 };
        };
        _picture = _display displayCtrl _picture;
        _picture ctrlShow false;
    } forEach _silosToRemove;
}