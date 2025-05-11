#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_carrier", "_side"];

private _carriers = GVAR(Game) getVariable QGVAR(carriers);
_carriers set [_side, _carrier];
GVAR(Game) setVariable [QGVAR(carriers), _carriers, true];

private _data = createHashMapFromArray [
    ["side", sideUnknown],
    ["max_hp", [QGVAR(Settings_CarrierMaxHP), "server"] call CBA_settings_fnc_get],
    ["current_hp", [QGVAR(Settings_CarrierMaxHP), "server"] call CBA_settings_fnc_get],
    ["allow_automated_defences", [QGVAR(Settings_AllowAutomatedDefences), "server"] call CBA_settings_fnc_get],
    ["reactors", []],

    ["composition", createHashMapFromArray [
        ["missile_target_pos", [24.9297,66.3911,0]],
        ["explosion_pos", [
            [-35.1406,163.192,23.4817],
            [-1.58936,173.036,23.59],
            [32.2993,151.088,23.5145],
            [-8.19434,30.502,23.5511],
            [-16.2852,130.631,23.5373],
            [-22.3359,5.81689,23.4596],
            [34.1396,74.8433,23.5628],
            [-15.9707,-81.1201,23.5184],
            [19.8208,-40.1528,23.4595],
            [-30.6777,62.7466,23.4832],
            [1.66064,-151.622,23.6522],
            [-27.4341,-39.2256,23.5044],
            [24.6304,11.7412,23.508],
            [7.12061,117.999,23.5175]
        ]],
        ["alarm_sound_pos", [
            [-22.627,111.096,28.4444],
            [45.0649,40.417,24.8704],
            [-34.6914,-81.4736,35.4021]
        ]],
        ["camera_pos", [75.4604,282.184,111.056]]
    ]]
];
{
    _carrier setVariable [format[QGVAR(%1),_x], _y];
} forEach _data;

_carrier setVariable [QGVAR(side), _side, true];

// Ramps
private _pos = getPosASL _carrier;
private _ramps = _pos nearObjects ["Land_Obstacle_Ramp_F", 300];
_ramps apply {
    private _class = typeOf _x;
    private _vectorDirAndUp = [vectorDir _x, vectorUp _x];
    private _pos = getPosASL _x;

    deleteVehicle _x;
    private _newRamp = createSimpleObject [_class, _pos, false];
    _newRamp setVectorDirAndUp _vectorDirAndUp;
    _newRamp setObjectScale 3;
};

// Missile target
private _class = "laserTarget";
private _pos = _carrier modelToWorldWorld (_data get "composition" get "missile_target_pos");
private _base = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
_base setPosASL _pos;
private _target = createVehicle ["laserTargetC", _pos, [], 0, "CAN_COLLIDE"];
_target setPosASL _pos;
_target attachTo [_base];

private _missileTargetData = GVAR(Game) getVariable QGVAR(missile_targets);
_missileTargetData set [_side, _target];
GVAR(Game) setVariable [QGVAR(missile_targets), _missileTargetData];

civilian reportRemoteTarget [_target, 1e12];