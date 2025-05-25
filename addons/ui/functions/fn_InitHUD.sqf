#include "script_component.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

"HUD" cutRsc [QGVAR(CarrierHUD), "PLAIN", 1e-6];

EGVAR(game,Game) setVariable [QEGVAR(game,hud_initialized), true];