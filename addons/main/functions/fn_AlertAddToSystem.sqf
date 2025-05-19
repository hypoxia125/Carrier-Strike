#include "script_component.hpp"

if (!hasInterface) exitWith {};

params ["_alert"];

GVAR(AlertQueueSystem) call ["Register", [_alert]];