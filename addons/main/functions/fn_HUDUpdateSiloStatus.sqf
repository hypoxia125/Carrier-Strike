/*
    fn_HUDUpdateSiloStatus
    Locality: Client

    Updates UI elements for current owner of silos
*/

#include "script_component.hpp"
#include "\z\carrierstrike\addons\main\defines.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

params ["_silo", "_side", "_percent", "_tickrate"];

if (_side isEqualTo sideUnknown) exitWith {};

private _siloNumber = _silo getVariable QGVAR(silo_number);

private _color = switch _side do {
    case west: {"Blue"};
    case east: {"Red"};
};

private _group = uiNamespace getVariable format[QGVAR(Silo%1_%2_Group), _color, _siloNumber];
private _picture = uiNamespace getVariable format[QGVAR(Silo%1_%2), _color, _siloNumber];

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