#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\defines.hpp"

if (!hasInterface) exitWith {};

params ["_siloNumber", "_state"];

private _display = localNamespace getVariable [QGVAR(carrierHUD), displayNull];
if (isNull _display) exitWith {};

private _picture = controlNull;
switch _siloNumber do {
    case 1: { _picture = IDC_SILO_GREY_1 };
    case 2: { _picture = IDC_SILO_GREY_2 };
    case 3: { _picture = IDC_SILO_GREY_3 };
    case 4: { _picture = IDC_SILO_GREY_4 };
    case 5: { _picture = IDC_SILO_GREY_5 };
};
_picture = _display displayCtrl _picture;
_picture ctrlShow _state;