#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_silo", objNull, [objNull]],
    ["_siloNumber", -1, [-1]]
];

if !(isServer) exitWith {};

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
    ["icons", createHashMapFromArray [
        [west, createHashMapFromArray [
            [1, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_1_21"]
            ]],
            [2, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_2_21"]
            ]],
            [3, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_3_21"]
            ]],
            [4, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_4_21"]
            ]],
            [5, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_West_5_21"]
            ]]
        ]],
        [east, createHashMapFromArray [
            [1, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_1_21"]
            ]],
            [2, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_2_21"]
            ]],
            [3, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_3_21"]
            ]],
            [4, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_4_21"]
            ]],
            [5, createHashMapFromArray [
                [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_1"],
                [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_2"],
                [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_3"],
                [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_4"],
                [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_5"],
                [6, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_6"],
                [7, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_7"],
                [8, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_8"],
                [9, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_9"],
                [10, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_10"],
                [11, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_11"],
                [12, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_12"],
                [13, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_13"],
                [14, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_14"],
                [15, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_15"],
                [16, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_16"],
                [17, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_17"],
                [18, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_18"],
                [19, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_19"],
                [20, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_20"],
                [21, "\z\carrierstrike\addons\main\data\icons\silos\Silo_East_5_21"]
            ]]
        ]],
        [sideUnknown, createHashMapFromArray [
            [1, "\z\carrierstrike\addons\main\data\icons\silos\Silo_Unknown_1"],
            [2, "\z\carrierstrike\addons\main\data\icons\silos\Silo_Unknown_2"],
            [3, "\z\carrierstrike\addons\main\data\icons\silos\Silo_Unknown_3"],
            [4, "\z\carrierstrike\addons\main\data\icons\silos\Silo_Unknown_4"],
            [5, "\z\carrierstrike\addons\main\data\icons\silos\Silo_Unknown_5"]
        ]]
    ]]
];
{
    _silo setVariable [format[QGVAR(%1),_x], _y];
} forEach _data;

// Add to control system
GVAR(SiloControlSystem) call ["Register", [_silo]];

// Set invuln
_silo allowDamage false;

// Create crew
private _group = createGroup civilian;
private _crew = units (createVehicleCrew _silo);
_crew joinSilent _group;
_silo setVariable [QGVAR(crewGroup), _group];

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
_silo setVariable [QGVAR(lights), _lights];

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