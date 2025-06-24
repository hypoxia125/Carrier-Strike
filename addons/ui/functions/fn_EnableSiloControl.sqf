#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\defines.hpp"

if (!hasInterface) exitWith {};

params ["_siloNumber", "_state"];

// private _silo = missionNamespace getVariable [QGVAR(silos), []];
// _silo = _silo select { _x getVariable QGVAR(silo_number) == _siloNumber };
// _silo = _silo#0;
// if (_silo getVariable [QEGVAR(game,Enabled), false]) exitWith {};

private _display = localNamespace getVariable [QGVAR(carrierHUD), displayNull];
if (isNull _display) exitWith {};

private _picture = controlNull;
private _path = "";
switch _siloNumber do {
    case 1: { _picture = IDC_SILO_GREY_1 };
    case 2: { _picture = IDC_SILO_GREY_2 };
    case 3: { _picture = IDC_SILO_GREY_3 };
    case 4: { _picture = IDC_SILO_GREY_4 };
    case 5: { _picture = IDC_SILO_GREY_5 };
};
switch _state do {
    case false: {
        switch _siloNumber do {
            case 1: { _path = QPATHTOF(data\hud\silos\SiloGrey_1_Disabled.paa) };
            case 2: { _path = QPATHTOF(data\hud\silos\SiloGrey_2_Disabled.paa) };
            case 3: { _path = QPATHTOF(data\hud\silos\SiloGrey_3_Disabled.paa) };
            case 4: { _path = QPATHTOF(data\hud\silos\SiloGrey_4_Disabled.paa) };
            case 5: { _path = QPATHTOF(data\hud\silos\SiloGrey_5_Disabled.paa) };
        };
    };
    case true: {
        switch _siloNumber do {
            case 1: { _path = QPATHTOF(data\hud\silos\SiloGrey_1.paa) };
            case 2: { _path = QPATHTOF(data\hud\silos\SiloGrey_2.paa) };
            case 3: { _path = QPATHTOF(data\hud\silos\SiloGrey_3.paa) };
            case 4: { _path = QPATHTOF(data\hud\silos\SiloGrey_4.paa) };
            case 5: { _path = QPATHTOF(data\hud\silos\SiloGrey_5.paa) };
        };
    };
};
_picture = _display displayCtrl _picture;
_picture ctrlSetText _path;