#include "script_component.hpp"

params ["_position", "_callerSide"];

if (!canSuspend) exitWith { _this spawn FUNC(CommanderArtillery) };

#define ARTILLERY_LENGTH    10

// Check position if its in a respawn area
private _valid = true;
private _respawnData = missionNamespace getVariable [QGVAR(respawn_positions), []];
{
    _x params ["_respawn", "_type", "_area"];

    // extend area
    _area set [1, 300];
    _area set [2, 300];

    if (_position inArea _area) exitWith {
        _valid = false;
    };
} forEach _respawnData;
if (!_valid) exitWith {
    hint LLSTRING(InvalidArtilleryLocation);
};

hintSilent LLSTRING(ArtilleryFiring);
[QGVAR(CommanderResetArtillery), [side group player]] call CBA_fnc_serverEvent;

sleep 10;

_position = [_position, 100, 100, 0, false, 0];

// Main barrage
private _startTime = serverTime;
while {serverTime < _startTime + ARTILLERY_LENGTH } do {
    private _rounds = [1,2] selectRandomWeighted [0.75,0.25];

    for "_i" from 1 to _rounds do {
        private _pos = _position call BIS_fnc_randomPosTrigger;
        _pos set [2, 500];

        private _round = createVehicle ["Sh_155mm_AMOS", _pos, [], 0, "NONE"];
        _round setVelocity [0,0,-1000];
    };

    sleep random [1, 1.5, 2];
};
