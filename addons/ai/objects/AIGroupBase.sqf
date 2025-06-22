#include "script_component.hpp"

if (!isServer) exitWith {};

if (!isNil QGVAR(AIGroupBase)) exitWith {};

GVAR(AIGroupBase) = [
    ["#type", "AIGroupBase"],
    ["#create", {
        params ["_side", "_personality", "_groupSize"];

        // Define properties
        _self set ["group", grpNull];
        _self set ["side", sideUnknown];
        _self set ["units", []];
        _self set ["personality", _personality];
        _self set ["siloPriorities", []];
        _self set ["objective", objNull];
        _self set ["respawnTime", 0];
        _self set ["timeSinceStart", 0];
        _self set ["spawnDelay", 0];
        _self set ["assignedVehicle", objNull];

        // Modify properties
        _self set ["side", _side];
        _self set ["max_units", _groupSize];
        _self set ["respawnTime", getNumber (missionConfigFile >> "respawnDelay")];
        _self set ["group", createGroup [_side, false]];        

        for "_i" from 0 to _groupSize - 1 do {
            (_self get "units") pushBack [objNull, _i, true];
        };
    }],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        params ["_updateRate", "_elapsedTime"];

        _self call ["UpdateSiloPriorities"];
        _self call ["SortSiloPriorities"];

        _self call ["CleanDead"];
        _self call ["TickRespawnTimes", [_updateRate]];

        _self call ["SpawnUnits"];

        private _assignedVehicle = _self get "assignedVehicle";
        private _group = _self get "group";
        if (isNull _assignedVehicle || !alive _assignedVehicle || !canMove _assignedVehicle || !canFire _assignedVehicle) then {
            _group leaveVehicle _assignedVehicle;
            _assignedVehicle = _self call ["FindVehicle"];
            if (!isNull _assignedVehicle) then {
                _group addVehicle _assignedVehicle;
                _self set ["assignedVehicle", _assignedVehicle];
                _assignedVehicle setVariable [QGVAR(assignedGroup), _assignedVehicle];
            };
        };

        if (_elapsedTime % 30 == 0) then {
            LOG_1("AIGroupBase | Updating group objective for group: %1",_group);
            _self call ["UpdateObjective"];
            _self call ["AssignWaypoints"];
        };
    }],

    //------------------------------------------------------------------------------------------------
    ["SetRandomLoadout", {
        params ["_unit"];

        _unit setUnitLoadout (configFile >> "EmptyLoadout");

        private _side = _self get "side";
        private _loadouts = (missionNamespace getVariable [QEGVAR(game,loadouts), createHashMap]) get _side;

        private _loadout = selectRandom _loadouts;
        private _uniform = getText (_loadout >> "uniformClass");
        private _backpack = getText (_loadout >> "backpack");
        private _weapons = getArray (_loadout >> "weapons");
        private _magazines = getArray (_loadout >> "magazines");
        private _items = getArray (_loadout >> "items");
        private _linkedItems = getArray (_loadout >> "linkedItems");

        private _helmet = _linkedItems select {
            getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type") == TYPE_HEADGEAR
        } select 0;
        _linkedItems = _linkedItems - [_helmet];
        private _vest = _linkedItems select {
            getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type") == TYPE_VEST
        } select 0;
        _linkedItems = _linkedItems - [_vest];

        private _primaryWeaponItems = _linkedItems select {
            _x in (compatibleItems primaryWeapon _unit);
        };
        {
            private _index = _linkedItems find _x;
            if (_index != -1) then { _linkedItems deleteAt _index };
        } forEach _primaryWeaponItems;

        private _secondaryWeaponItems = _linkedItems select {
            _x in (compatibleItems secondaryWeapon _unit);
        };
        {
            private _index = _linkedItems find _x;
            if (_index != -1) then { _linkedItems deleteAt _index };
        } forEach _secondaryWeaponItems;

        private _handgunWeaponItems = _linkedItems select {
            _x in (compatibleItems handgunWeapon _unit);
        };
        {
            private _index = _linkedItems find _x;
            if (_index != -1) then { _linkedItems deleteAt _index };
        } forEach _handgunWeaponItems;

        _unit forceAddUniform _uniform;
        _unit addVest _vest;
        _unit addBackpack _backpack;
        _unit addHeadgear _helmet;
        { _unit addMagazine _x } forEach _magazines;
        { _unit addWeapon _x } forEach _weapons;
        { _unit addItem _x } forEach _items;
        { _unit linkItem _x } forEach _linkedItems;
        { _unit addPrimaryWeaponItem _x} forEach _primaryWeaponItems;
        { _unit addSecondaryWeaponItem _x} forEach _secondaryWeaponItems;
        { _unit addHandgunItem _x} forEach _handgunWeaponItems;
    }],

    //------------------------------------------------------------------------------------------------
    ["AssignWaypoints", {
        private _objective = _self get "objective";
        if (isNull _objective) exitWith {};

        private _position = ASLToAGL getPosASL _objective;
        for "_i" from 0 to 1000 do {
            private _candidate = _position getPos [random 50, random 360];
            if !(surfaceIsWater _candidate) exitWith { _position = _candidate };
        };
        _position = ASLToATL AGLToASL _position;
        _position set [2, 0];

        private _group = _self get "group";

        _group call CBA_fnc_clearWaypoints;

        private _wp = _group addWaypoint [_position, -1];
        _wp setWaypointType "MOVE";
        _wp setWaypointCombatMode selectRandom ["RED", "WHITE"];
        _wp setWaypointTimeout [1e6, 1e6, 1e6];
    }],

    //------------------------------------------------------------------------------------------------
    ["CleanDead", {
        private _activeUnits = _self get "units";
        {
            _x params ["_unit", "_respawnTimer", "_enabled"];
            if (
                (!isNull _unit && {!alive _unit}) ||
                !_enabled
            ) then {
                _unit setDamage [1, false];
                [_unit] joinSilent (createGroup [civilian, true]);
                _x set [0, objNull];
                _x set [1, _self get "respawnTime"];

                private _side = _self get "side";
                private _allUnits = GVAR(AISystem) get "allUnits" get _side;
                _allUnits = _allUnits - [_unit];
            };
        } forEach _activeUnits;
    }],

    ["FindVehicle", {
        private _leader = (_self get "units") #0#0;
        if (isNull _leader) exitWith { objNull };

        private _nearVehicles = (ASLToAGL getPosASL _leader) nearEntities [["LandVehicle", "Plane", "Helicopter"], 100];
        if (_nearVehicles isEqualTo []) exitWith { objNull };

        private _nearestValid = _nearVehicles select { isNull (_x getVariable [QGVAR(assignedGroup), grpNull]) };
        _nearestValid = _nearestValid select 0;
        if (isNil "_nearestValid") exitWith { objNull };

        _nearestValid;
    }],

    //------------------------------------------------------------------------------------------------
    ["GetSpawnPositionATL", {
        private _objective = _self get "objective";
        private _groupSide = _self get "side";

        private _pos = [0,0,0]; // fallback

        // Leader spawn
        private _leader = (_self get "units") #0#0;
        if (alive _leader && _groupSide != independent) then {
            if (isNull _leader) exitWith {};
            private _posATL = getPosATL _leader;
            private _area = [_posATL, 15, 15, 0, false, -1];
            _area params ["_center", "_a", "_b", "_angle", "_rect", "_h"];
            _pos = [_center, 0, _a max _b, 5, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
            if (!(_pos isEqualType []) || {!(count _pos in [2,3])}) exitWith {
                LOG_1("GetSpawnPositionATL::LeaderSpawn | Position Found: %1",_pos);
            };
            _pos set [2, 0];
        };
        if (_pos isNotEqualTo [0,0,0]) exitWith { _pos };

        // Silo spawn
        private _siloOwner = _objective getVariable [QEGVAR(game,side), sideUnknown];
        if (_siloOwner == _groupSide && _objective in (missionNamespace getVariable [QEGVAR(game,silos), []])) then {
            private _maxDistance = [QEGVAR(game,Settings_SiloPlayerSpawnDistance)] call CBA_settings_fnc_get;
            private _pos = getPosATL _objective;
            private _area = [_posATL, 10, 10, 0, false, -1];
            _area params ["_center", "_a", "_b", "_angle", "_rect", "_h"];
            _pos = [_center, 0, _a max _b, 5, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
            if (!(_pos isEqualType []) || {!(count _pos in [2,3])}) exitWith {
                LOG_1("GetSpawnPositionATL::SiloSpawn | Position Found: %1",_pos);
            };
            _pos set [2, 0];
        };
        if (_pos isNotEqualTo [0,0,0]) exitWith { _pos };

        // Carrier spawn
        private _carriers = missionNamespace getVariable [QEGVAR(game,carriers), createHashMap];
        if (_objective == _carriers getOrDefault [_groupSide, objNull]) then {
            private _respawns = missionNamespace getVariable [QEGVAR(game,respawn_positions), []];
            private _respawnsForSide = _respawns select {_x#0#0 == _groupSide};
            private _carrierRespawns = _respawnsForSide select {_x#1 == "carrier"};
            private _respawnArea = (selectRandom _carrierRespawns) select 2;
            _respawnArea params ["_center", "_a", "_b", "_angle", "_isRectangle", "_h"];
            _pos = _respawnArea call BIS_fnc_randomPosTrigger;
            _pos set [2, _center#2];
            _pos;
        };
        if (_pos isNotEqualTo [0,0,0]) exitWith { _pos };

        // Base Default Spawn
        private _respawns = missionNamespace getVariable [QEGVAR(game,respawn_positions), []];
        private _respawnsForSide = _respawns select {_x#0#0 == _groupSide};
        private _baseRespawns = _respawnsForSide select {_x#1 == "base"};
        private _respawnArea = (selectRandom _baseRespawns) select 2;
        _respawnArea params ["_center", "_a", "_b", "_angle", "_isRectangle", "_h"];
        _pos = _respawnArea call BIS_fnc_randomPosTrigger;
        _pos set [2, _center#2];
        _pos;
    }],

    //------------------------------------------------------------------------------------------------
    ["SortSiloPriorities", {
        private _siloPriorities = _self get "siloPriorities";

        private _arr = _siloPriorities;
        for "_i" from 1 to (count _arr - 1) do {
            private _key = _arr select _i;
            private _j = _i - 1;
            while {_j >= 0 && ((_arr select _j) select 1 < (_key select 1))} do {
                _arr set [_j + 1, _arr select _j];
                _j = _j - 1;
            };
            _arr set [_j + 1, _key];
        };
    }],

    //------------------------------------------------------------------------------------------------
    ["RemoveUnitsBasedOnPlayers", {
        private _side = _self get "side";
        private _activeUnits = _self get "units";
        {
            _x params ["_unit", "_respawnTimer", "_enabled"];

            private _allUnits = GVAR(AISystem) get "allUnits" get _side;
            
            if (_forEachIndex == 0) then { continue };
            if (
                count _allUnits + count (units _side select { isPlayer _x }) >= playableSlotsNumber _side
            ) then {
                _allUnits = _allUnits - [_unit];
                _unit setDamage 1;
            };
        } forEach _activeUnits;
    }],

    //------------------------------------------------------------------------------------------------
    ["SpawnUnits", {
        private _activeUnits = _self get "units";
        private _group = _self get "group";
        private _side = _self get "side";
        {
            _x params ["_unit", "_respawnTimer", "_enabled"];
            
            private _allUnits = GVAR(AISystem) get "allUnits" get _side;

            if (!_enabled) then { continue };
            if (_respawnTimer > 0 || !isNull _unit) then { continue };
            if (
                count _allUnits + count (units _side select { isPlayer _x }) >= playableSlotsNumber _side
            ) then { continue };

            if (isNull _group) then {
                _group = createGroup (_self get "side");
                _self set ["group", _group];
            };

            private _pos = _self call ["GetSpawnPositionATL"];
            if (!(_pos isEqualType [])) exitWith {
                LOG_1("AIGroupBase::SpawnUnits | ErrorCode:1 with position. Position given: %1",_pos);
            };
            if (count _pos != 3 || !(_pos isEqualTypeArray [-1,-1,-1])) exitWith {
                LOG_1("AIGroupBase::SpawnUnits | ErrorCode:2 with position. Position given: %1",_pos);
            };
            _pos set [2, 0];
            _unit = _group createUnit ["CarrierStrike_AISoldier", [0,0,0], [], 0, "NONE"];
            _self call ["SetRandomLoadout", [_unit]];
            _unit setDir (random 360);
            _unit setPosATL _pos;

            [_unit] joinSilent _group;
            if (_forEachIndex == 0) then {
                _group selectLeader _unit;
            };

            _allUnits = _allUnits pushBack _unit;

            _unit setSkill (random [0.3, 0.7, 1.0]);
            {
                _x addCuratorEditableObjects [[_unit], true];
            } forEach allCurators;

            TRACE_2("SpawnUnits | Unit Created",_unit,_pos);

            _x set [0, _unit];
            _x set [1, _self get "respawnTime"];
        } forEach _activeUnits;
    }],

    //------------------------------------------------------------------------------------------------
    ["TickRespawnTimes", {
        params ["_updateRate"];

        private _activeUnits = _self get "units";
        {
            _x params ["_unit", "_respawnTimer", "_enabled"];
            if (!_enabled || alive _unit) then { continue };
            _respawnTimer = (_respawnTimer - _updateRate) max 0;
            _x set [1, _respawnTimer];
        } forEach _activeUnits;
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateObjective", {
        private _siloPriorities = _self get "siloPriorities";
        private _siloNum = _siloPriorities#0#0;
        private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
        private _silo = _silos select { _x getVariable QEGVAR(game,silo_number) == _siloNum };
        _silo = _silo#0;

        _self set ["objective", _silo];
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateSiloPriorities", {
        private _personality = _self get "personality";
        _self set ["siloPriorities", []];
        private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
        _silos = _silos select { _x getVariable [QEGVAR(game,enabled), true] };
        {
            private _silo = _x;
            private _siloNum = _silo getVariable QEGVAR(game,silo_number);
            private _side = _self get "side";
            private _siloPriorities = _self get "siloPriorities";

            private _carriers = missionNamespace getVariable QEGVAR(game,Carriers);
            private _carrier = _carriers get _side;

            // Distance Scoring
            private _leader = (_self get "units") #0#0;
            private _distanceScore = 0;
            if (alive _leader) then {
                private _maxDistance = (worldSize / 2) * sqrt 2;
                private _distance = _leader distance2D _silo;
                private _distanceNormalized = _distance / _maxDistance;

                _distanceScore = ((1 - _distanceNormalized) min 1) max 0;
            } else {
                private _maxDistance = (worldSize / 2) * sqrt 2;
                private _distance = _silo distance2D _carrier;
                private _distanceNormalized = _distance / _maxDistance;
                _distanceScore = ((1 - _distanceNormalized) min 1) max 0;
            };

            // Ownership Score
            private _owner = _silo getVariable QEGVAR(game,side);
            private _ownerScore = call {
                switch _personality do {
                    case AI_PERSONALITY_NEUTRAL: { // Prioritize neutral > enemy > friendly
                        if (_owner == _side) exitWith { 0.5 };
                        if (_owner == sideUnknown) exitWith { 1.0 };
                        if (_owner != _side) exitWith { 0.75 };
                    };
                    case AI_PERSONALITY_OFFENSIVE: { // Prioritize enemy > neutral > friendly
                        if (_owner == _side) exitWith { 0.3 };
                        if (_owner == sideUnknown) exitWith { 0.75 };
                        if (_owner != _side) exitWith { 1.0 };
                    };
                    case AI_PERSONALITY_DEFENSIVE: { // Prioritize friendly > neutral > enemy
                        if (_owner == _side) exitWith { 0.8 };
                        if (_owner == sideUnknown) exitWith { 1.0 };
                        if (_owner != _side) exitWith { 0.4 };
                    };
                    case AI_PERSONALITY_CHAOTIC: {
                        random 1;
                    };
                };
            };

            // Friendly Score
            private _area = [getPosATL _silo, 200, 200, 0, false, -1];
            private _friendlyNearby = count (allUnits select {alive _x && side group _x == _side && _x inArea _area});
            private _maxFriendlies = playableSlotsNumber _side;
            private _friendliesNormalized = _friendlyNearby / _maxFriendlies;
            private _friendlyScore = ((1 - _friendliesNormalized) min 1) max 0;
            if (_owner == sideUnknown) then { _friendlyScore = 0 };

            // Countdown Score
            private _countdown = _silo getVariable QEGVAR(game,countdown);
            private _maxCountdown = _silo getVariable QEGVAR(game,countdown_time);
            private _countdownNormalized = _countdown / _maxCountdown;
            private _countdownScore = ((1 - _countdownNormalized) min 1) max 0;

            // Multipliers
            private _ownerMulti = 1.0;
            private _distanceMulti = 1.0;
            private _friendlyMulti = 1.0;
            private _countdownMulti = 1.0;

            switch (_personality) do {
                case AI_PERSONALITY_NEUTRAL: {
                    _ownerMulti = 1.0;
                    _distanceMulti = 1.0;
                    _friendlyMulti = 1.1;
                    _countdownMulti = 1.2;
                };
                case AI_PERSONALITY_OFFENSIVE: {
                    _ownerMulti = 1.4;
                    _distanceMulti = 0.9;
                    _friendlyMulti = 0.6;
                    _countdownMulti = 1.3;
                };
                case AI_PERSONALITY_DEFENSIVE: {
                    _ownerMulti = 0.8;
                    _distanceMulti = 1.2;
                    _friendlyMulti = 1.4;
                    _countdownMulti = 0.7;
                };
                case AI_PERSONALITY_CHAOTIC: {
                    _ownerMulti = 0.5 + random 1.0;
                    _distanceMulti = 0.5 + random 1.0;
                    _friendlyMulti = 0.3 + random 1.4;
                    _countdownMulti = 0.5 + random 1.0;
                };
            };

            // Final score
            private _priorityScore =
                (_ownerScore * 0.4 * _ownerMulti) +
                (_distanceScore * 0.2 * _distanceMulti) +
                (_friendlyScore * 0.1 * _friendlyMulti) +
                (_countdownScore * 0.3 * _countdownMulti);
            

            _siloPriorities set [_forEachIndex, [_siloNum, _priorityScore]];
        } forEach _silos;
    }]
];