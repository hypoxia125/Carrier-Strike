#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_silo", objNull, [objNull]],
    ["_siloNumber", -1, [-1]]
];

if (isNull _silo) exitWith {};
if (_siloNumber <= 0) exitWith {};
if (_siloNumber > 5) exitWith {};

// Build data
private _data = createHashMapFromArray [
    ["side", sideUnknown],
    ["lights", []],
    ["silo_number", _siloNumber],
    ["crew_group", grpNull],

    ["composition", createHashMapFromArray [
        ["light_unknown", "PortableHelipadLight_01_yellow_F"],
        ["light_west", "PortableHelipadLight_01_blue_F"],
        ["light_east", "PortableHelipadLight_01_red_F"],
        ["light_independent", "PortableHelipadLight_01_green_F"],
        ["light_civilian", "Land_PortableHelipadLight_01_F"],
        ["platform", "BlockConcrete_F"],
        ["light_r", [4.08691,2.9585,-1.1]],
        ["light_l", [-4.16309,2.93945,-1.1]],
        ["platform_rear", [0.0258789,-1.08105,-3.34349]],
        ["platform_front", [0.0263672,0.800293,-3.34282]]
    ]],

    // Launch system variables
    ["countdown_time", [QGVAR(Settings_SiloLaunchCooldown)] call CBA_settings_fnc_get],
    ["countdown", [QGVAR(Settings_SiloLaunchCooldown)] call CBA_settings_fnc_get],
    ["is_firing", false],

    // Icons
    ["icons", createHashMap]
];
// build image hashes
{
    private _side = _x;
    private _sideHash = createHashMap;
    for "_i" from 1 to 5 do {
        private _silo = _i;
        private _siloHash = createHashMap;
        for "_j" from 1 to 21 do {
            private _frameIndex = _j;
            private _path = format[QPATHTOEF(ui,data\icons\silos\Silo_%1_%2_%3.paa),_side,_silo,_frameIndex];
            _siloHash insert [[_frameIndex, _path]];
        };
        _sideHash insert [[_silo, _siloHash]];
    };
    (_data get "icons") insert [[_side, _sideHash]];
} forEach [west, east];

_data get "icons" insert [[sideUnknown, createHashMap]];
for "_i" from 1 to 5 do {
    private _path = format[QPATHTOEF(ui,data\icons\silos\Silo_%1_%2.paa),sideUnknown,_i];
    ((_data get "icons") get sideUnknown) insert [[_i, _path]];
};
// store data hash in namespace
{
    _silo setVariable [format[QGVAR(%1),_x], _y, true];
} forEach _data;

// Add to control system
GVAR(SiloControlSystem) call ["Register", [_silo]];

// Set invuln
_silo allowDamage false;

// Create crew
private _group = createGroup civilian;
private _crew = units (createVehicleCrew _silo);
_crew joinSilent _group;
_silo setVariable [QGVAR(crewGroup), _group, true];

// Create and attach platforms
private _composition = _silo getVariable QGVAR(composition);
{
    private _pos = _silo modelToWorldWorld (_composition get _x);
    private _type = _composition get "platform";

    private _platform = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
    _platform setDir getDir _silo;
    _platform setPosASL _pos;

    _platform setVectorDirAndUp [vectorDir _silo, vectorUp _silo];
    [_silo, _platform] call BIS_fnc_attachToRelative;
} forEach ["platform_rear", "platform_front"];

// create and attach neutral lights
private _lights = _silo getVariable QGVAR(lights);
{
    private _pos =  _silo modelToWorldWorld (_composition get _x);
    private _type = _composition get "light_unknown";

    private _light = createVehicle [_type, [0,0,0], [], 0, "NONE"];
    _light setPosASL _pos;

    _light setVectorDirAndUp [vectorDir _silo, vectorUp _silo];
    [_light, _silo] call BIS_fnc_attachToRelative;

    _lights insert [-1, [_light]];
} forEach ["light_r", "light_l"];
_silo setVariable [QGVAR(lights), _lights, true];

// Remove silo frag rounds
_silo removeMagazinesTurret ["magazine_Missiles_Cruise_01_Cluster_x18", [0]];

// Create fired event handler
_silo addEventHandler ["Fired", {
    private _silo = _this#0;
    private _projectile = _this#6;

    _projectile allowDamage false;

    // Set projectile team affiliation
    private _side = _silo getVariable [QGVAR(side), sideUnknown];
    _projectile setVariable [QGVAR(side), _side, true];

    GVAR(MissileTrackingSystem) call ["Register", [_projectile]];
}];