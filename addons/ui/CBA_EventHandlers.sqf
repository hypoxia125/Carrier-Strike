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