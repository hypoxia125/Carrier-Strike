#include "script_component.hpp"

[QGVAR(UpdateCarrierStatus), {
    call FUNC(UpdateCarrierStatus);
}] call CBA_fnc_addEventHandler;

[QGVAR(UpdateSiloCountdown), {
    call FUNC(UpdateSiloCountdown);
}] call CBA_fnc_addEventHandler;

[QGVAR(UpdateSiloStatus), {
    call FUNC(UpdateSiloStatus);
}] call CBA_fnc_addEventHandler;

[QGVAR(EnableSiloControl), {
    call FUNC(EnableSiloControl);
}] call CBA_fnc_addEventHandler;

[QGVAR(UpdateCommanderMenu), {
    call FUNC(UpdateCommanderMenu);
}] call CBA_fnc_addEventHandler;

[QGVAR(UpdateCommanderNameTopBar), {
    call FUNC(UpdateCommanderNameTopBar);
}] call CBA_fnc_addEventHandler;
