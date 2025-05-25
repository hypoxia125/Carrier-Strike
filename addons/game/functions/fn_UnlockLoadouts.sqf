#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_tier"];

private _westLoadouts = [];
private _eastLoadouts = [];
private _independentLoadouts = [];

switch _tier do {
    case 1: {
        private _cfgLoadouts = toString {
            private _config = _x;
            private _configName = configName _config;
            ["tier1", _configName, false] call BIS_fnc_inString;
        } configClasses (missionConfigFile >> "CfgRespawnInventory");
        _westLoadouts = _cfgLoadouts select { ["west", configName _x, false] call BIS_fnc_inString };
        _eastLoadouts = _cfgLoadouts select { ["east", configName _x, false] call BIS_fnc_inString };
        _independentLoadouts = _cfgLoadouts select { ["independent", configName _x, false] call BIS_fnc_inString };
    };

    case 2: {
        private _cfgLoadouts = toString {
            private _config = _x;
            private _configName = configName _config;
            ["tier2", _configName, false] call BIS_fnc_inString;
        } configClasses (missionConfigFile >> "CfgRespawnInventory");
        _westLoadouts = _cfgLoadouts select { ["west", configName _x, false] call BIS_fnc_inString };
        _eastLoadouts = _cfgLoadouts select { ["east", configName _x, false] call BIS_fnc_inString };
        _independentLoadouts = _cfgLoadouts select { ["independent", configName _x, false] call BIS_fnc_inString };
    };

    case 3: {
        private _cfgLoadouts = toString {
            private _config = _x;
            private _configName = configName _config;
            ["tier3", _configName, false] call BIS_fnc_inString;
        } configClasses (missionConfigFile >> "CfgRespawnInventory");
        _westLoadouts = _cfgLoadouts select { ["west", configName _x, false] call BIS_fnc_inString };
        _eastLoadouts = _cfgLoadouts select { ["east", configName _x, false] call BIS_fnc_inString };
        _independentLoadouts = _cfgLoadouts select { ["independent", configName _x, false] call BIS_fnc_inString };
    };
};

{ [west, configName _x] call BIS_fnc_addRespawnInventory } forEach _westLoadouts;
{ [east, configName _x] call BIS_fnc_addRespawnInventory } forEach _eastLoadouts;
{ [independent, configName _x] call BIS_fnc_addRespawnInventory } forEach _independentLoadouts;