#include "script_component.hpp"

if (!hasInterface) exitWith {};
if (!canSuspend) exitWith { _this spawn FUNC(FixBIRespawnInventoryBullshit) };

waitUntil {!alive player};
INFO("FixBIRespawnInventoryBullshit | Start script, looking for issues...");
while {sleep 0.1; !alive player} do {
    private _type = typeOf player;
    private _inventories = [player] call BIS_fnc_getRespawnInventories;
    if (_inventories findIf { _x isEqualTo _type } != -1) then {
        [player, _inventories#_index] call BIS_fnc_removeRespawnInventory;
    };
};
