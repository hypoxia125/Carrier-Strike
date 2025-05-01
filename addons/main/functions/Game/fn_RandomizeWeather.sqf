// TODO: Weather System

/*
#define SCRIPTNAME "fn_Game_RandomizeWeather:: "

if !(isServer) exitWith {};

// Functions
private _getRainChance = {
    params ["_overcast"];

    ((_overcast) ^ 3) min 1;
};

private _getRainIntensity = {
    params ["_rainChance"];

    (_rainChance) ^ 1.5 min 1
};

private _getLightningChance = {
    params ["_overcast"];

    100 * (1 - (EULERS ^ -0.8))
};

private _getLightningIntensity = {
    params ["_lightningChance"];

    (1 - (EULERS ^ -0.8)) ^ 2
};

private _getFog = {
    params ["_overcast"];

    _overcast ^ 4
};

private _getFogBaseASL = {
    params ["_temperature", ["_baseASL", 0]];

    _baseASL + humidity * _temperature
};

private _getTemperature = {
    params ["_timeOfDay", ["_coldestTemp", 54]];

    (_timeOfDay - 12) ^ 2 + _coldestTemp
};

private _getDate = {
    private _nightChance = GVAR(Weather_NightChance);

    private _allHours = [];
    for "_i" from 1 to 24 do {
        _allHours insert [-1, [_i]]
    };

    private _dayHours = [7,8,9,10,11,12,13,14,15,16,17];
    private _nightHours = _allHours - _dayHours;

    private _year = 2035;
    private _month = random 12;
    private _day = random 28;
    private _hour = selectRandom _dayHours;
    private _min = random 60;

    if (random 1 < _nightChance) then {
        _hour = selectRandom _nightHours;
    };

    // return
    [_year, _month, _day, _hour, _min]
};

// Variables
private ["_date", "_overcast", "_wind"];
if (GVAR(Weather_Randomize)) then {
    _date = call _getDate;
    _overcast = random 1;
    _wind = random 1;
} else {
    _date = GVAR(WeatherParameters) get "date";
    _overcast = GVAR(WeatherParameters) get "overcast";
};

// Date
setDate _date;

// Overcast
0 setOvercast _overcast;
INFO_1(SCRIPTNAME + "Setting Overcast - %1",_overcast);

// Rain
private _rainChance = [_overcast] call _getRainChance;
private _rainIntensity = [_rainChance] call _getRainIntensity;
0 setRain _rainIntensity;
INFO_1(SCRIPTNAME + "Setting Rain Intensity - %1",_rainIntensity);
TRACE_2("Vars",_rainChance,_rainIntensity);

// Lightnings
private _lightningChance = [_overcast] call _getLightningChance;
private _lightningIntensity = [_lightningChance] call _getLightningIntensity;
0 setLightnings _lightningIntensity;
INFO_1(SCRIPTNAME + "Setting Lightning Intensity - %1",_lightningIntensity);
TRACE_2("Vars",_lightningChance,_lightningIntensity);

// Fog
private _fog = [_overcast] call _getFog;
private _temperature = [dayTime] call _getTemperature;
private _fogBase = [_temperature] call _getFogBaseASL;
0 setFog [
    _fog min 0.4,
    0,
    _fogBase
];
INFO_1(SCRIPTNAME + "Setting Fog Intensity - %1",_fog);
TRACE_4("Vars",_fog,_temperature,humidity,_fogBase);

// Waves
private _waveIntensity = moonIntensity;
0 setWaves _waveIntensity;
INFO_1(SCRIPTNAME + "Setting Fog Intensity - %1",_fog);
forceWeatherChange;
*/