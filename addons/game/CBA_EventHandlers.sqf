#include "script_component.hpp"

[QGVAR(AlertAddToSystem), {
    call FUNC(AlertAddToSystem);
}] call CBA_fnc_addEventHandler;

[QGVAR(ExplosionSequence), {
    call FUNC(ExplosionSequence);
}] call CBA_fnc_addEventHandler;

[QGVAR(ReactorShotSimInit), {
    call FUNC(ReactorShotSimInit);
}] call CBA_fnc_addEventHandler;

[QGVAR(AddToChatChannel), {
    call FUNC(AddToChatChannel);
}] call CBA_fnc_addEventHandler;