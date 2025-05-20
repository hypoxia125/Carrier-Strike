/*
    fn_HUDUpdateSiloCountdown
    Locality: Client

    Updates UI elements for current cooldown on silo launches
*/

#include "script_component.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

params ["_silo", "_countdown"];

private _siloNumber = _silo getVariable QGVAR(silo_number);

private _ctrl = uiNamespace getVariable format[QGVAR(Silo_CD_%1), _siloNumber];
if (isNil "_ctrl") exitWith {
    ERROR_1("HUDUpdateSiloTimer | No control found for silo cd %1",_siloNumber);
};

private _color = [1,0,0,1];
if (_countdown isEqualType -1) then {
    _ctrl ctrlSetText str _countdown;

    private _countdownMax = _silo getVariable QGVAR(countdown_time);
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