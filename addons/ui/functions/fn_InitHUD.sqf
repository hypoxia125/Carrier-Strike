#include "script_component.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

"HUD" cutRsc [QGVAR(CarrierHUD), "PLAIN", 1e-6];

missionNamespace setVariable [QEGVAR(game,hud_initialized), true];

for "_i" from 1 to 5 do {
    [_i, false] call FUNC(EnableSiloControl);
};