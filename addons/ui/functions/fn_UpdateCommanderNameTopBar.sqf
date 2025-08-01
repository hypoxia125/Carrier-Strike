#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\defines.hpp"

if (!hasInterface) exitWith {};

params [["_name", ""], "_side"];

if (_name == "") then { _name = "NO COMMANDER" };

private _display = localNamespace getVariable [QGVAR(carrierHUD), displayNull];
private _control = controlNull;
switch _side do {
    case west: {
        _control = _display displayCtrl IDC_COMMANDER_WEST;
    };

    case east: {
        _control = _display displayCtrl IDC_COMMANDER_EAST;
    };
};

_control ctrlSetText toUpperANSI _name;