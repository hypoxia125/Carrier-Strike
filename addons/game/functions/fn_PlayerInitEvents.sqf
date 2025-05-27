#include "script_component.hpp"

if (!hasInterface) exitWith {};

player addMPEventHandler ["MPRespawn", {
    params ["_unit", "_corpse"];

    INFO("PlayerInitEvents | Respawn event triggered. Executing post respawn scripts...");
    _unit call FUNC(RespawnPost);
}];