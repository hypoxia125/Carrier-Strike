/*
    fn_HUDUpdateCarrierStatus
    Locality: Client

    Updates UI elements for current carrier HP
*/

#include "script_component.hpp"
#include "\z\carrierstrike\addons\main\defines.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

params ["_side", "_percent", "_tickrate"];

private _color = switch _side do {
    case west: {"Blue"};
    case east: {"Red"};
};

private _group = uiNamespace getVariable format[QGVAR(Carrier_%1_Light_Group), _color];
private _picture = uiNamespace getVariable format[QGVAR(Carrier_%1_Light), _color];

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