#include "script_component.hpp"

// Game settings
[
    QGVAR(Settings_SeedingMode),
    "CHECKBOX",
    "Enable Silos w/ Player Count",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowAI),
    "CHECKBOX",
    "AI - Enabled",
    [LLSTRING(GameSettings), LLSTRING(AISettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowWestFactionAI),
    "CHECKBOX",
    "Allow BLUFOR Faction - AI",
    [LLSTRING(GameSettings), LLSTRING(AISettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowEastFactionAI),
    "CHECKBOX",
    "Allow OPFOR Faction - AI",
    [LLSTRING(GameSettings), LLSTRING(AISettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowIndependentFactionAI),
    "CHECKBOX",
    "Allow INDEPENDENT Faction - AI",
    [LLSTRING(GameSettings), LLSTRING(AISettingsCategory)],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowIndependentFaction),
    "CHECKBOX",
    "Allow Independent Faction",
    [LLSTRING(GameSettings), "zz In Development zz"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AIEnabled),
    "CHECKBOX",
    "Fill Slots w/ AI",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

// World settings
[
    QGVAR(Settings_RandomizeWeather),
    "CHECKBOX",
    "Randomize Weather",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_MaxHumidity),
    "SLIDER",
    "Max Humidity",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    [0, 1, 1, 0, true],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_HumidityOverride),
    "CHECKBOX",
    "Humidity Override",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_HumidityOverrideAmount),
    "SLIDER",
    "Humidity Override Amount",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    [0, 1, 0, 0, true],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowRain),
    "CHECKBOX",
    "Allow Rain",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_AllowFog),
    "CHECKBOX",
    "Allow Fog",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_NightChance),
    "SLIDER",
    "Night Chance",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    [0, 1, 0.3, 0, true],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_TimeScale),
    "SLIDER",
    "Time Scale",
    [LLSTRING(GameSettings), LLSTRING(WeatherSettingsCategory)],
    [1, 120, 1, 0, false],
    1,
    {},
    true
] call CBA_fnc_addSetting;


// Carrier settings
[
    QGVAR(Settings_CarrierMaxHP),
    "SLIDER",
    "Carrier Max HP",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_ReactorMaxHP),
    "SLIDER",
    "Reactor Max HP",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_ReactorDestroyedDamage),
    "SLIDER",
    "Reactor Destroyed Damage",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 100, 12.5, 1],
    1,
    {},
    true
] call CBA_fnc_addSetting;

// Silo settings
[
    QGVAR(Settings_SiloLaunchCooldown),
    "SLIDER",
    "Silo Missile Launch Cooldown (s)",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 60*60, 120, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileDamage),
    "SLIDER",
    "Silo Missile Damage",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 100, 2, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloAllowSpawnOnSilo),
    "CHECKBOX",
    "Allow Spawn On Silo (Owner Team)",
    [LLSTRING(GameSettings), "zz In Development zz"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloPlayerSpawnDistance),
    "SLIDER",
    "Silo Player Spawn Distance (Owner Team)",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 1000, 200, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloCaptureTime),
    "SLIDER",
    "Silo Capture Time",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 15*60, 30, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloCaptureRadius),
    "SLIDER",
    "Silo Capture Radius",
    [LLSTRING(GameSettings), LLSTRING(GameSettingsCategory)],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloShowMissile3DTracking),
    "CHECKBOX",
    "Show Missile 3D Tracking",
    [LLSTRING(GameSettings), LLSTRING(ClientSettingsCategory)],
    true,
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorWest),
    "COLOR",
    "Missile Tracking Color - BLUFOR",
    [LLSTRING(GameSettings), LLSTRING(ClientSettingsCategory)],
    [0,0,1],
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorEast),
    "COLOR",
    "Missile Tracking Color - OPFOR",
    [LLSTRING(GameSettings), LLSTRING(ClientSettingsCategory)],
    [0.9,0,0],
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_SiloMissileTrackingColorIndependent),
    "COLOR",
    "Missile Tracking Color - Resistance",
    [LLSTRING(GameSettings), LLSTRING(ClientSettingsCategory)],
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
    [LLSTRING(GameSettings), LLSTRING(RallyPointSettingsCategory)],
    [0, 100, 50, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyPlacementCooldown),
    "SLIDER",
    "Placement Cooldown",
    [LLSTRING(GameSettings), LLSTRING(RallyPointSettingsCategory)],
    [0, 60*60, 90, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyGroupSizeRequirement),
    "SLIDER",
    "Group Size Requirement",
    [LLSTRING(GameSettings), LLSTRING(RallyPointSettingsCategory)],
    [0, 6, 3, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_RallyMinDistanceFromSilo),
    "SLIDER",
    "Minimum Distance From Silo",
    [LLSTRING(GameSettings), "zz In Development zz"],
    [0, 1000, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

// Commander Settings
[
    QGVAR(Settings_CommanderScanCooldown),
    "SLIDER",
    "Scan Cooldown",
    [LLSTRING(GameSettings), LLSTRING(CommanderSettingsCategory)],
    [10, MINTOSEC(15), 45, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_CommanderUAVCooldown),
    "SLIDER",
    "UAV Cooldown",
    [LLSTRING(GameSettings), "zz In Development zz"],
    [10, MINTOSEC(15), 60, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(Settings_CommanderArtilleryCooldown),
    "SLIDER",
    "Artillery Cooldown",
    [LLSTRING(GameSettings), LLSTRING(CommanderSettingsCategory)],
    [10, MINTOSEC(15), 90, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;
