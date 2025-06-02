#include "script_component.hpp"

if (!hasInterface) exitWith {};

player addMPEventHandler ["MPRespawn", {
    params ["_unit", "_corpse"];

    _unit call FUNC(RespawnPost);
}];
if (!isMultiplayer) then { player call FUNC(RespawnPost) };