#include "script_component.hpp"

disableSerialization;

if (!hasInterface) exitWith {};

"HUD" cutRsc ["carrierHUD", "PLAIN", 1e-6];

GVAR(Game) setVariable [QGVAR(hud_initialized), true];