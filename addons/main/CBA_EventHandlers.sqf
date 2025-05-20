#include "script_component.hpp"

[QGVAR(HUDUpdateCarrierStatus), {
    call FUNC(HUDUpdateCarrierStatus);
}] call CBA_fnc_addEventHandler;

[QGVAR(HUDUpdateSiloCountdown), {
    call FUNC(HUDUpdateSiloCountdown);
}] call CBA_fnc_addEventHandler;

[QGVAR(HUDUpdateSiloStatus), {
    call FUNC(HUDUpdateSiloStatus);
}] call CBA_fnc_addEventHandler;

[QGVAR(PlaySiloSound3DLocal), {
    call FUNC(PlaySiloSound3DLocal);
}] call CBA_fnc_addEventHandler;

[QGVAR(AlertAddToSystem), {
    call FUNC(AlertAddToSystem);
}] call CBA_fnc_addEventHandler;

[QGVAR(ExplosionSequence), {
    call FUNC(ExplosionSequence);
}] call CBA_fnc_addEventHandler;