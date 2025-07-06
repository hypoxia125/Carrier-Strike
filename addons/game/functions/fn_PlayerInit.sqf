#include "script_component.hpp"

if (!hasInterface) exitWith {};

player addMPEventHandler ["MPRespawn", {
    params ["_unit", "_corpse"];

    INFO("MPRespawn | Triggered...");
    _unit call FUNC(RespawnPost);
}];
if (!isMultiplayer) then { player call FUNC(RespawnPost) };

player addMPEventHandler ["MPKilled", {
    params ["_unit", "_corpse"];

    INFO("MPKilled | Triggered...");
    call FUNC(FixBIRespawnInventoryBullshit);
}];
