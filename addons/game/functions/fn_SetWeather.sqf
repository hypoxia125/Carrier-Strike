#include "script_component.hpp"

if (!isServer) exitWith {};

if !([QGVAR(Settings_RandomizeWeather)] call CBA_settings_fnc_get) exitWith {};

private _allowRain = [QGVAR(Settings_AllowRain)] call CBA_settings_fnc_get;
private _allowFog = [QGVAR(Settings_AllowFog)] call CBA_settings_fnc_get;
private _nightChance = [QGVAR(Settings_NightChance)] call CBA_settings_fnc_get;
private _timeScale = [QGVAR(Settings_TimeScale)] call CBA_settings_fnc_get;

// Figure out the date
private _allHours = [];
for "_i" from 1 to 24 do {
    _allHours pushBack _i;
};

private _dayHours = [];
for "_i" from 7 to 17 do {
    _dayHours pushBack _i;
};

private _nightHours = _allHours - _dayHours;

private _year = 2035;
private _month = random 12;
private _day = random 28;
private _hour = selectRandom _dayHours;
private _min = random 60;

if (random 1 < _nightChance) then {
    params ["_humidity"];
    
    _hour = selectRandom _nightHours;
};

setDate [_year, _month, _day, _hour, _min];

// Weather
private _fnc_rainIntensity = {
    params ["_humidity"];
    
    if (_humidity < 0.3) exitWith { 0.0 };
    if (_humidity < 0.7) exitWith {
        0.5 * ((_humidity - 0.3) / 0.4) ^ 2
    };

    private _base = 0.5 + 0.5 * ((_humidity - 0.7) / 0.3);
    1.0 min (_base + random [-0.1, 0, 0.1]);
};

private _fnc_overcast = {
    params ["_humidity"];
    
    private _exponent = -10 * (_humidity - 0.5);
    private _expTerm = 2.71828 ^ _exponent;
    1 / (1 + _expTerm);
};

private _fnc_fog = {
    params ["_humidity"];
    
    if (_humidity < 0.4) exitWith { 0.0 };
    if (_humidity < 0.8) exitWith {
        4 * (_humidity - 0.4) * (0.8 - _humidity)
    };

    0 max (0.5 - (_humidity - 0.8) * 2.5);
};

private _fnc_lightning = {
    params ["_humidity"];

    if (_humidity < 0.5) exitWith { 0.0 };

    private _base = (_humidity - 0.5) * 1.5;
    if (random 1 < (_humidity - 0.5) * 0.3) then {
        1 min (_base + random[0.2, 0.35, 0.5])
    } else {
        1 min (_base + random[-0.1, 0, 0.1])
    };
};

private _humidity = 0;
private _maxHumidity = [QGVAR(Settings_MaxHumidity)] call CBA_settings_fnc_get;

if ([QGVAR(Settings_HumidityOverride)] call CBA_settings_fnc_get) then {
    _humidity = [QGVAR(Settings_HumidityOverrideAmount)] call CBA_settings_fnc_get
} else {
    _humidity = random [0, _maxHumidity / 2, _maxHumidity];
};
missionNamespace setVariable [QGVAR(Humidity), _humidity, true];

0 setOvercast (_humidity call _fnc_overcast);
if (_allowRain) then { 0 setRain (_humidity call _fnc_rainIntensity) };
if (_allowFog) then { 0 setFog (_humidity call _fnc_fog) };
0 setLightnings (_humidity call _fnc_lightning);

setTimeMultiplier _timeScale;

forceWeatherChange;