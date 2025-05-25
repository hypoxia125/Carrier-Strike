/*
    fn_HUDUpdateSiloCountdown
    Locality: Client

    Updates UI elements for current cooldown on silo launches
*/

#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\defines.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

params ["_silo", "_countdown"];

private _siloNumber = _silo getVariable QEGVAR(game,silo_number);

private _display = localNamespace getVariable [QGVAR(carrierHUD), displayNull];
if (isNull _display) exitWith {};

private _ctrl = switch _siloNumber do {
    case 1: { IDC_SILO_CD_1 };
    case 2: { IDC_SILO_CD_2 };
    case 3: { IDC_SILO_CD_3 };
    case 4: { IDC_SILO_CD_4 };
    case 5: { IDC_SILO_CD_5 };
};
_ctrl = _display displayCtrl _ctrl;

private _color = [1,0,0,1];
if (_countdown isEqualType -1) then {
    _ctrl ctrlSetText str _countdown;

    private _countdownMax = _silo getVariable QEGVAR(game,countdown_time);
    _color = call {
        if (_countdown > _countdownMax * 0.66) exitWith { [0,1,0,1] };
        if ((_countdown > _countdownMax * 0.33) && (_countdown <= _countdownMax * 0.66)) exitWith { [1,1,0,1] };
        if (_countdown <= _countdownMax * 0.33) exitWith { [1,0,0,1] };
        [1,1,1,1];
    };
};
if (_countdown isEqualType "") then {
    _ctrl ctrlSetText _countdown;
};

_ctrl ctrlSetTextColor _color;