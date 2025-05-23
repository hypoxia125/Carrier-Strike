/*
    fn_HUDUpdateCarrierStatus
    Locality: Client

    Updates UI elements for current carrier HP
*/

#include "script_component.hpp"
#include QPATHTOF(defines.hpp)

disableSerialization;

if (!hasInterface) exitWith {};

params ["_side", "_percent", "_tickrate"];

private _group = switch _side do {
    case west: { (findDisplay IDD_CARRIERHUD) displayCtrl IDC_CARRIER_BLUE_LIGHT_GROUP };
    case east: { (findDisplay IDD_CARRIERHUD) displayCtrl IDC_CARRIER_RED_LIGHT_GROUP };
};

private _picture = switch _side do {
    case west: { IDC_CARRIER_BLUE_LIGHT };
    case east: { IDC_CARRIER_RED_LIGHT };
};

switch _side do {
    case west: {
        private _group_x = CARRIER_LEFT * GRID_W;
        private _group_width = CARRIER_W * GRID_W;

        _picture ctrlSetPositionX (_group_width * (1 - _percent));
        _group ctrlSetPositionX (_group_x - _group_width * (1 - _percent));
    };
    case east: {
        private _group_x = CARRIER_RIGHT * GRID_W;
        private _group_width = CARRIER_W * GRID_W;

        _picture ctrlSetPositionX (_group_width * -(1 - _percent));
        _group ctrlSetPositionX (_group_x + _group_width * (1 - _percent));
    };
};

_group ctrlCommit _tickrate;
_picture ctrlCommit _tickrate;