#include "script_component.hpp"

if (!isServer) exitWith {};

// Game settings
[
    QGVAR(Settings_AllowIndependentFaction),
    "CHECKBOX",
    "Allow Independent Faction",
    ["Carrier Strike - Game Settings", "Game"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

// World settings
[
    QGVAR(Settings_AllowRain),
    "CHECKBOX",
    "Allow Rain",
    ["Carrier Strike - Game Settings", "World"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowFog),
    "CHECKBOX",
    "Allow Fog",
    ["Carrier Strike - Game Settings", "World"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowNight),
    "CHECKBOX",
    "Allow Night",
    ["Carrier Strike - Game Settings", "World"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RainChance),
    "SLIDER",
    "Rain Chance",
    ["Carrier Strike - Game Settings", "World"],
    [0, 1, 0.3, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_NightChance),
    "SLIDER",
    "Night Chance",
    ["Carrier Strike - Game Settings", "World"],
    [0, 1, 0.3, 0, true],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_TimeScale),
    "SLIDER",
    "Time Scale",
    ["Carrier Strike - Game Settings", "World"],
    [0, 24, 1],
    1,
    {},
    true
] call CBA_fnc_addSetting;


// Carrier settings
[
    QGVAR(Settings_CarrierMaxHP),
    "SLIDER",
    "Max HP",
    ["Carrier Strike - Game Settings", "Carriers"],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_ReactorMaxHP),
    "SLIDER",
    "Reactor Max HP",
    ["Carrier Strike - Game Settings", "Carriers"],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowAutomatedDefences),
    "CHECKBOX",
    "Allow Automated Defences",
    ["Carrier Strike - Game Settings", "Carriers"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

// Silo settings
[
    QGVAR(Settings_SiloLaunchCooldown),
    "SLIDER",
    "Missile Launch Cooldown (s)",
    ["Carrier Strike - Game Settings", "Silos"],
    [0, 60*60, 120, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileDamage),
    "SLIDER",
    "Missile Damage",
    ["Carrier Strike - Game Settings", "Silos"],
    [0, 100, 5, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloAllowSpawnOnSilo),
    "CHECKBOX",
    "Allow Spawn On Silo (Owner Team)",
    ["Carrier Strike - Game Settings", "Silos"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloPlayerSpawnDistance),
    "SLIDER",
    "Player Spawn Distance (Owner Team)",
    ["Carrier Strike - Game Settings", "Silos"],
    [0, 1000, 200, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloCaptureTime),
    "SLIDER",
    "Capture Time",
    ["Carrier Strike - Game Settings", "Silos"],
    [0, 15*60, 30, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloCaptureRadius),
    "SLIDER",
    "Capture Radius",
    ["Carrier Strike - Game Settings", "Silos"],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloShowMissile3DTracking),
    "CHECKBOX",
    "Show Missile 3D Tracking",
    ["Carrier Strike - Game Settings", "Silos"],
    true,
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorWest),
    "COLOR",
    "Missile Tracking Color - BLUFOR",
    ["Carrier Strike - Game Settings", "Silos"],
    [0,0,1],
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorEast),
    "COLOR",
    "Missile Tracking Color - OPFOR",
    ["Carrier Strike - Game Settings", "Silos"],
    [0.9,0,0],
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorIndependent),
    "COLOR",
    "Missile Tracking Color - Resistance",
    ["Carrier Strike - Game Settings", "Silos"],
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
    [0, 100, 5, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyPlacementCooldown),
    "SLIDER",
    "Placement Cooldown",
    ["Carrier Strike - Game Settings", "Rally Points"],
    [0, 60*60, 90, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyGroupSizeRequirement),
    "SLIDER",
    "Group Size Requirement",
    ["Carrier Strike - Game Settings", "Rally Points"],
    [0, 6, 3, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyMinDistanceFromSilo),
    "SLIDER",
    "Minimum Distance From Silo",
    ["Carrier Strike - Game Settings", "Rally Points"],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;