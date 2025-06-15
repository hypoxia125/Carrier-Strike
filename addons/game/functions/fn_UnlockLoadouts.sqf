#include "script_component.hpp"

if (!isServer) exitWith {};

params [["_percentHP", 1], ["_override", -1]];

private _loadoutTiers = getNumber (missionConfigFile >> "loadout_tiers");
if (_loadoutTiers == 0) exitWith {};

private _slice = 1 / _loadoutTiers;
private _currentTier = 1;

// Determine current tier based on HP percentage
for "_i" from _loadoutTiers to 1 step -1 do {
    private _threshold = 1 - (_slice * (_i - 1));
    if (_percentHP <= _threshold) exitWith {
        _currentTier = _i;
    };
};

TRACE_3("UnlockLoadouts",_slice,_percentHP,_currentTier);

if (_override > 0) then {
    _currentTier = _override;
};

private _westLoadouts = [];
private _eastLoadouts = [];
private _independentLoadouts = [];

private _tierLoadouts = "true" configClasses (missionConfigFile >> "CfgRespawnInventory");
_tierLoadouts = _tierLoadouts select { getNumber (_x >> "tier") == _currentTier };

INFO_1("Attempting to unlock tier: %1",_currentTier);
if (isNil {missionNamespace getVariable QGVAR(unlocked_loadouts)}) then {
    missionNamespace setVariable [QGVAR(unlocked_loadouts), createHashMap];
};
private _unlockHash = missionNamespace getVariable [QGVAR(unlocked_loadouts), createHashMap];
if (_unlockHash getOrDefault [_currentTier, false, true]) exitWith {
    INFO_1("Tier: %1 already unlocked!",_currentTier);
};
_unlockHash set [_currentTier, true];

{
    private _side = getNumber (_x >> "side");
    switch _side do {
        case 0: { _eastLoadouts pushBack configName _x };
        case 1: { _westLoadouts pushBack configName _x };
        case 2: { _independentLoadouts pushBack configName _x };
    };
} forEach _tierLoadouts;

{ [west, _x] call BIS_fnc_addRespawnInventory } forEach _westLoadouts;
{ [east, _x] call BIS_fnc_addRespawnInventory } forEach _eastLoadouts;
{ [independent, _x] call BIS_fnc_addRespawnInventory } forEach _independentLoadouts;

INFO_1("Tier: %1 Unlocked",_currentTier);

// Send notification
[QGVAR(HintSilent), format ["Tier %1 Loadouts: Unlocked", _currentTier]] call CBA_fnc_globalEvent;