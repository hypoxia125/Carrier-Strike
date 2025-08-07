#include "script_component.hpp"

if (!isServer) exitWith {};
if (!isNil QGVAR(RallyPointSystem)) exitWith {};

GVAR(RallyPointSystem) = createHashMapObject [[
    ["#type", "RallyPointSystem"],
    ["#base", +GVAR(SystemBase)],

    ["m_updateRate", 1],
    ["m_entities", []],

    ["Update", {
        _self call ["CleanRallies"];

        private _groups = allGroups select { (units _x findIf { isPlayer _x }) != -1 };
        {
            private _group = _x;

            _self call ["CheckCanCreateRally", [_group]];
            
            if (_self call ["CheckDestroyRally", [_group]]) then {
                _group call FUNC(RallyPointDelete);
            };

            _self call ["PlayRallyBeep", [_group]];
            _self call ["TickCooldown", [_group]];
        } forEach _groups;
    }],

    ["AddRallies", {
        params ["_group"];

        private _rallyPoint = _group getVariable [QGVAR(RallyPointObject), objNull];
        if (isNull _rallyPoint) exitWith {};

        private _allRallies = _self get "m_entities";
        _allRallies pushBackUnique _rallyPoint;
    }],

    ["CleanRallies", {
        private _allRallies = _self get "m_entities";
        {
            private _rally = _x;
            private _group = _rally getVariable [QGVAR(ownerGroup), grpNull];
            if (isNull _group || count units _group == 0) then {
                _rally call FUNC(RallyPointDelete);
                _allRallies deleteAt _forEachIndex;
            };
        } forEachReversed _allRallies;
    }],

    ["CheckCanCreateRally", {
        params ["_group"];

        private _canCreate = true;

        private _cooldown = _group getVariable [QGVAR(RallyPoint_Cooldown), 0];
        if (_cooldown > 0) then { _canCreate = false };

        private _sizeRequirement = [QGVAR(Settings_RallyGroupSizeRequirement)] call CBA_settings_fnc_get;
        if (count units _group < _sizeRequirement) then { _canCreate = false };

        _group setVariable [QGVAR(RallyPoint_CanCreate), _canCreate, true];
    }],

    ["CheckDestroyRally", {
        params ["_group"];

        private _rally = _group getVariable [QGVAR(RallyPointObject), objNull];
        private _sizeRequirement = [QGVAR(Settings_RallyGroupSizeRequirement)] call CBA_settings_fnc_get;
        if (count units _group < _sizeRequirement) exitWith { true };

        private _enemySides = (side _group) call BIS_fnc_enemySides;
        private _units = [];
        {
            _units = _units + units _x;
        } forEach _enemySides;
        private _destroyRadius = [QGVAR(Settings_RallyDestroyRadius)] call CBA_settings_fnc_get;
        private _enemiesNearby = _units findIf {alive _x && _x distance _rally <= _destroyRadius} != -1;
        if (_enemiesNearby) exitWith { true };
    }],

    ["PlayRallyBeep", {
        params ["_group"];

        private _rallyPoint = _group getVariable [QGVAR(RallyPointObject), objNull];
        if (!alive _rallyPoint) exitWith {};

        private _soundPath = "A3\Missions_F_Oldman\Data\sound\beep.ogg";
        playSound3D [_soundPath, _rallyPoint, false, getPosASL _rallyPoint, 1, 1, 100];
    }],

    ["TickCooldown", {
        params ["_group"];

        private _cooldown = _group getVariable [QGVAR(RallyPoint_Cooldown), 0];
        private _rallyPoint = _group getVariable [QGVAR(RallyPointObject), objNull];
        private _cooldownTime = [QGVAR(Settings_RallyPlacementCooldown)] call CBA_settings_fnc_get;

        if (_cooldown <= 0 && !alive _rally) exitWith {};

        _cooldown = _cooldown - 1;
        _group setVariable [QGVAR(RallyPoint_Cooldown), _cooldown, true];        
    }]
]];
