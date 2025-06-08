#include "script_component.hpp"

// Game settings
[
    QGVAR(Settings_AllowIndependentFaction),
    "CHECKBOX",
    "Allow Independent Faction",
    ["Carrier Strike - Game Settings", "zz In Development zz"],
    false,
    2,
    {},
    true
] call CBA_fnc_addSetting;

// World settings
[
    QGVAR(Settings_RandomizeWeather),
    "CHECKBOX",
    "Randomize Weather",
    ["Carrier Strike - Game Settings", "Weather"],
    true,
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_MaxHumidity),
    "SLIDER",
    "Max Humidity",
    ["Carrier Strike - Game Settings", "Weather"],
    [0, 1, 1, 0, true],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_HumidityOverride),
    "CHECKBOX",
    "Humidity Override",
    ["Carrier Strike - Game Settings", "Weather"],
    false,
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_HumidityOverrideAmount),
    "SLIDER",
    "Humidity Override Amount",
    ["Carrier Strike - Game Settings", "Weather"],
    [0, 1, 0, 0, true],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowRain),
    "CHECKBOX",
    "Allow Rain",
    ["Carrier Strike - Game Settings", "Weather"],
    true,
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowFog),
    "CHECKBOX",
    "Allow Fog",
    ["Carrier Strike - Game Settings", "Weather"],
    true,
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_NightChance),
    "SLIDER",
    "Night Chance",
    ["Carrier Strike - Game Settings", "Weather"],
    [0, 1, 0.3, 0, true],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_TimeScale),
    "SLIDER",
    "Time Scale",
    ["Carrier Strike - Game Settings", "Weather"],
    [1, 120, 1, 0, false],
    2,
    {},
    true
] call CBA_fnc_addSetting;


// Carrier settings
[
    QGVAR(Settings_CarrierMaxHP),
    "SLIDER",
    "Carrier Max HP",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 1000, 100, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_ReactorMaxHP),
    "SLIDER",
    "Reactor Max HP",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 1000, 100, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_ReactorDestroyedDamage),
    "SLIDER",
    "Reactor Destroyed Damage",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 100, 12.5, 1],
    2,
    {},
    true
] call CBA_fnc_addSetting;

// Silo settings
[
    QGVAR(Settings_SiloLaunchCooldown),
    "SLIDER",
    "Silo Missile Launch Cooldown (s)",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 60*60, 120, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileDamage),
    "SLIDER",
    "Silo Missile Damage",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 100, 2, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloAllowSpawnOnSilo),
    "CHECKBOX",
    "Allow Spawn On Silo (Owner Team)",
    ["Carrier Strike - Game Settings", "zz In Development zz"],
    true,
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloPlayerSpawnDistance),
    "SLIDER",
    "Silo Player Spawn Distance (Owner Team)",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 1000, 200, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloCaptureTime),
    "SLIDER",
    "Silo Capture Time",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 15*60, 30, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloCaptureRadius),
    "SLIDER",
    "Silo Capture Radius",
    ["Carrier Strike - Game Settings", "Game Settings"],
    [0, 1000, 50, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloShowMissile3DTracking),
    "CHECKBOX",
    "Show Missile 3D Tracking",
    ["Carrier Strike - Game Settings", "Client Settings"],
    true,
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorWest),
    "COLOR",
    "Missile Tracking Color - BLUFOR",
    ["Carrier Strike - Game Settings", "Client Settings"],
    [0,0,1],
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorEast),
    "COLOR",
    "Missile Tracking Color - OPFOR",
    ["Carrier Strike - Game Settings", "Client Settings"],
    [0.9,0,0],
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorIndependent),
    "COLOR",
    "Missile Tracking Color - Resistance",
    ["Carrier Strike - Game Settings", "Client Settings"],
    [0,0.8,0],
    0,
    {},
    true
] call CBA_fnc_addSetting;

// Rally point settings
[
    QGVAR(Settings_RallyDestroyRadius),
    "SLIDER",
    "Enemy Destroy Radius",
    ["Carrier Strike - Game Settings", "Rally Points"],
    [0, 100, 50, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyPlacementCooldown),
    "SLIDER",
    "Placement Cooldown",
    ["Carrier Strike - Game Settings", "Rally Points"],
    [0, 60*60, 90, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyGroupSizeRequirement),
    "SLIDER",
    "Group Size Requirement",
    ["Carrier Strike - Game Settings", "Rally Points"],
    [0, 6, 3, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyMinDistanceFromSilo),
    "SLIDER",
    "Minimum Distance From Silo",
    ["Carrier Strike - Game Settings", "zz In Development zz"],
    [0, 1000, 100, 0],
    2,
    {},
    true
] call CBA_fnc_addSetting;