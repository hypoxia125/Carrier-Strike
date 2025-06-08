#include "script_component.hpp"

params ["_caller"];

if (!isServer) exitWith {};

private _group = group _caller;
private _leader = leader _group;

if (_leader isNotEqualTo _caller) exitWith {};
if !(_group getVariable [QGVAR(RallyPoint_CanCreate), false]) exitWith {};

// If there is already a rally point, kill it
private _rally = _group getVariable [QGVAR(RallyPointObject), objNull];
if (!isNull _rally) then { _group call FUNC(RallyPointDelete) };

private _rallyComposition = createHashMapFromArray [
    ["base", "Land_HelipadEmpty_F"],
    ["satellite", "SatelliteAntenna_01_Small_Sand_F"],
    ["satellite_pos", [0,0.1,0]],
    ["satellite_dir_diff", 0],
    ["laptop", "Land_Laptop_03_sand_F"],
    ["laptop_pos", [0.264648,-0.0648623,0.000240326]],
    ["laptop_dir_diff", 308.283],
    ["flag", "FlagSmall_F"],
    ["flag_neutral", "#(argb,8,8,3)color(1,1,1,1)"],
    ["flag_west", "#(argb,8,8,3)color(0,0.3,0.6,1)"],
    ["flag_east", "#(argb,8,8,3)color(0.5,0,0,1)"],
    ["flag_independent", "#(argb,8,8,3)color(0,0.5,0,1)"],
    ["flag_civilian", "#(argb,8,8,3)color(0.4,0,0.5,1)"],
    ["flag_pos", [-0.15,-0.05,9.15527e-005]],
    ["flag_dir_diff", 59.088],
    ["rally_destroy_radius", 5]
];

private _className = _rallyComposition get "base";
private _dir = getDir _caller;
private _pos = getPosATL _caller;
_pos set [2, 0];

private _fnc_checkPos = {
    params ["_testPos"];

    private _isNearTerrainObject = nearestTerrainObjects [_testPos, [], 3] isNotEqualTo [];
    private _isWater = surfaceIsWater _testPos;

    if (!_isNearTerrainObject && !_isWater) exitWith { true };
    false;
};

for "_i" from 0 to 1000 do {
    private _candidate = _caller getPos [2, random [_dir - 90, _dir - 180, _dir - 270]];
    _candidate set [2, 0];

    private _valid = [_candidate] call _fnc_checkPos;
    if (_valid) exitWith {
        _pos = _candidate;
    };
};
if (surfaceIsWater _pos) exitWith {};
LOG_1("RallyPointCreate | Final Position Of Rally: %1",_pos);

private _rally = createVehicle [_className, [0,0,0], [], 0, "CAN_COLLIDE"];
_rally setDir 0;
_rally setPosASL (AGLToASL _pos);
_rally enableSimulation false;

// Create other ambient objects
{
    private _className = _rallyComposition get _x;
    private _relPos = _rallyComposition get (format["%1_pos", _x]);
    private _pos = _rally modelToWorldWorld _relPos;
    private _dirDiff = _rallyComposition get (format["%1_dir_diff", _x]);

    private _object = createVehicle [_className, [0,0,0], [], 0, "CAN_COLLIDE"];
    _object setDir (getDir _rally + _dirDiff);
    _object setPosASL _pos;
    _object enableSimulationGlobal false;
    //[_object, _rally] call BIS_fnc_attachToRelative;

    // Set flag color
    if (_forEachIndex == 1) then {
        private _team = switch side _group do {
            case west: {"west"};
            case east: {"east"};
            case independent: {"independent"};
            case civilian: {"civilian"};
            default {"neutral"};
        };
        private _texture = _rallyComposition get (format["flag_%1", _team]);
        _object setObjectTextureGlobal [0, _texture];
    };

    private _objects = _rally getVariable [QGVAR(RallyObjects), []];
    _objects pushBack _object;
    _rally setVariable [QGVAR(RallyObjects), _objects];
} forEach ["satellite", "flag", "laptop"];

private _respawn = [_group, getPosATL _rally, "Rally Point"] call BIS_fnc_addRespawnPosition;

_rally setVariable [QGVAR(ownerGroup), _group];
_group setVariable [QGVAR(RallyRespawnPosition), _respawn];
_group setVariable [QGVAR(RallyPointObject), _rally];
_group setVariable [QGVAR(RallyPoint_Cooldown), [QGVAR(Settings_RallyPlacementCooldown)] call CBA_settings_fnc_get, true];

[QGVAR(HintSilent), ["Rally Point Created"], units _group] call CBA_fnc_targetEvent;