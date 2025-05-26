#include "script_component.hpp"

[QGVAR(PlaySiloSound3DLocal), {
    call FUNC(PlaySiloSound3DLocal);
}] call CBA_fnc_addEventHandler;

[QGVAR(AlertAddToSystem), {
    call FUNC(AlertAddToSystem);
}] call CBA_fnc_addEventHandler;

[QGVAR(ExplosionSequence), {
    call FUNC(ExplosionSequence);
}] call CBA_fnc_addEventHandler;

[QGVAR(ReactorShotSimInit), {
    call FUNC(ReactorShotSimInit);
}] call CBA_fnc_addEventHandler;