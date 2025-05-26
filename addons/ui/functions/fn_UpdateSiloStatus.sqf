/*
    fn_HUDUpdateSiloStatus
    Locality: Client

    Updates UI elements for current owner of silos
*/

#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\defines.hpp"
#include "\z\carrierstrike\addons\ui\Grids.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

params ["_silo", "_side", "_percent", "_tickrate"];

if (_side isEqualTo sideUnknown) exitWith {};

private _siloNumber = _silo getVariable QEGVAR(game,silo_number);
private _display = localNamespace getVariable [QGVAR(carrierHUD), displayNull];
if (isNull _display) exitWith {};

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

if (isNil "_group") exitWith {
    ERROR("Something went wrong with Update Silo Status - No Group");
};
if (isNil "_picture") exitWith {
    ERROR("Something went wrong with Update Silo Status - No Picture");
};

// calculate
private _group_top_y = SILO_Y * GRID_H;
private _group_height = SILO_H * GRID_H;
_picture ctrlSetPositionY (_group_height * -(1 - _percent));
_group ctrlSetPositionY (_group_top_y - _group_height * -(1 - _percent));

_group ctrlCommit _tickrate;
_picture ctrlCommit _tickrate;