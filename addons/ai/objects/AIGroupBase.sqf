#include "script_component.hpp"

GVAR(AIGroupBase) = createHashMapFromArray [
    ["#type", "AIGroupBase"],
    ["#create", {
        params ["_side", "_groupSize"];

        _self set ["side", _side];
        _self set ["max_units", _groupSize];

        private _respawnTime = getNumber (missionConfigFile >> "respawnDelay");
        _self set ["respawnTime", _respawnTime];

        for "_i" from 0 to _groupSize - 1 do {
            (_self get "active_units") pushBack [objNull, 0];
        };
    }],

    ["group", grpNull],
    ["side", sideUnknown],
    ["max_units", -1],
    ["active_units", []], // [<entity>,<respawnTimer>] - idx 0 is the leader
    ["personality", AI_PERSONALITY_NEUTRAL],
    ["silo_priorities", []],
    ["objective", objNull],
    ["timeSinceStart", 0],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        params ["_updateRate"];

        _self call ["UpdateSiloPriorities"];
        _self call ["CleanDead"];
        _self call ["TickRespawnTimes", [_updateRate]];
        _self call ["SpawnUnits"];

        private _timeSinceStart = _self get "timeSinceStart";
        if (_timeSinceStart % 15 == 0) then {
            _self call ["AssignWaypoints"];
        };
        _timeSinceStart = _timeSinceStart + _updateRate;
        _self set ["timeSinceStart", _timeSinceStart];
    }],

    //------------------------------------------------------------------------------------------------
    ["SpawnUnits", {
        private _activeUnits = _self get "active_units";
        private _group = _self get "group";
        {
            _x params ["_unit", "_respawnTimer"];
            if (_respawnTimer > 0) then { continue };

            private _pos = _self call ["GetSpawnPositionATL"];
            _unit = _group createUnit ["CarrierStrike_AISoldier", [0,0,0], [], 0, "NONE"];
            _self call ["SetRandomLoadout", [_unit]];
            _unit setDir (random 360);
            _unit setPosATL _pos;

            [_unit] joinSilent _group;
            _x set [_unit, _self get "respawnTime"];
        } forEach _activeUnits;
    }],

    //------------------------------------------------------------------------------------------------
    ["TickRespawnTimes", {
        params ["_updateRate"];

        private _activeUnits = _self get "active_units";
        {
            _x params ["_unit", "_respawnTimer"];
            _respawnTimer = (_respawnTimer - _updateRate) max 0;
            _x set [1, _respawnTimer];
        } forEach _activeUnits;
    }],

    //------------------------------------------------------------------------------------------------
    ["CleanDead", {
        private _activeUnits = _self get "active_units";
        {
            _x params ["_unit", "_respawnTimer"];
            if (!isNull _unit && {!alive _unit}) then {
                _x set [0, objNull];
                _x set [1, _self get "respawnTime"];
            };
        } forEach _activeUnits;
    }],

    //------------------------------------------------------------------------------------------------
    ["AssignWaypoints", {
        private _objective = _self get "objective";
        if (isNull _objective) exitWith {};

        private _position = ASLToAGL getPosASL _objective;
        _position = _position getPos [random 50, random 360];
        _position = ASLToATL AGLToASL _position;
        _position set [2, 0];

        private _group = _self get "group";

        _group call CBA_fnc_clearWaypoints;

        private _wp = _group addWaypoint [_position, -1];
        _wp setWaypointType "SAD";
        _wp setWaypointTimeout [1e6, 1e6, 1e6];
    }],

    //------------------------------------------------------------------------------------------------
    ["FindVehicle", {
        private _leader = _self getOrDefault ["leader", objNull];
        if (isNull _leader) exitWith { objNull };

        private _nearVehicles = (ASLToAGL getPosASL _leader) nearEntities [["LandVehicle", "Plane", "Helicopter"], 100];
        if (_nearVehicles isEqualTo []) exitWith { objNull };

        private _nearestValid = _nearVehicles select { !isNull (_x getVariable [QGVAR(assignedGroup), grpNull]) };
        _nearestValid = _nearestValid select 0;
        if (isNil "_nearestValid") exitWith { objNull };

        _nearestValid;
    }],

    //------------------------------------------------------------------------------------------------
    ["GetSpawnPositionATL", {
        private _objective = _self get "objective";
        private _groupSide = _self get "side";

        private _pos = [0,0,0]; // fall back position

        // Leader spawn
        private _leader = _self getOrDefault ["leader", objNull];
        if (alive _leader) exitWith {
            private _posATL = getPosATL _leader;
            for "_i" from 0 to 1000 do {
                private _candidateAGL = (getPosASL _leader) getPos [random 15 min 5, random 360];
                private _candidateASL = AGLToASL _candidateAGL;

                private _valid = [_candidateASL, 7, 7] call EFUNC(game,IsSafePos);
                if (_valid) exitWith { _pos = ASLToATL _candidateASL };
            };
            _pos set [2, 0];
            _pos;
        };

        // Silo spawn
        private _siloOwner = _objective getVariable [QEGVAR(game,side), sideUnknown];
        if (_siloOwner == _groupSide && _objective in (missionNamespace getVariable [QEGVAR(game,silos), []])) exitWith {
            private _maxDistance = [QEGVAR(game,Settings_SiloPlayerSpawnDistance)] call CBA_settings_fnc_get;
            private _pos = getPosATL _objective;
            for "_i" from 0 to 1000 do {
                private _candidateAGL = (getPosASL _objective) getPos [random _maxDistance max 10, random 360];
                private _candidateASL = AGLToASL _candidateAGL;

                private _valid = [_candidateASL, 7, 7] call EFUNC(game,IsSafePos);
                if (_valid) exitWith { _pos = ASLToATL _candidateASL };
            };
            _pos set [2, 0];
            _pos;
        };

        // Carrier spawn
        private _carriers = missionNamespace getVariable [QEGVAR(game,carriers), createHashMap];
        if (_objective == _carriers getOrDefault [_groupSide, objNull]) exitWith {
            private _respawns = missionNamespace getVariable [QEGVAR(game,respawn_positions), []];
            private _respawnsForSide = _respawns select {_x#0#0 == _groupSide};
            private _carrierRespawns = _respawnsForSide select {_x#1 == "carrier"};
            private _respawnArea = (selectRandom _carrierRespawns) select 2;
            _respawnArea params ["_centerATL", "_a", "_b", "_angle", "_isRectangle", "_h"];
            _pos = _respawnArea call BIS_fnc_randomPosTrigger;
            _pos set [2, _centerATL#2];
            _pos;
        };

        // Base Default Spawn
        private _respawns = missionNamespace getVariable [QEGVAR(game,respawn_positions), []];
        private _respawnsForSide = _respawns select {_x#0#0 == _groupSide};
        private _baseRespawns = _respawnsForSide select {_x#1 == "base"};
        private _respawnArea = (selectRandom _baseRespawns) select 2;
        _respawnArea params ["_centerATL", "_a", "_b", "_angle", "_isRectangle", "_h"];
        _pos = _respawnArea call BIS_fnc_randomPosTrigger;
        _pos set [2, _centerATL#2];
        _pos;
    }],

    //------------------------------------------------------------------------------------------------
    ["SortSiloPriorities", {
        private _siloPriorities = _self get "silo_priorities";

        private _arr = _siloPriorities;
        for "_i" from 1 to (count _arr - 1) do {
            private _key = _arr select _i;
            private _j = _i - 1;
            while {_j >= 0 && ((_arr select _j) select 1 > (_key select 1))} do {
                _arr set [_j + 1, _arr select _j];
                _j = _j - 1;
            };
            _arr set [_j + 1, _key];
        };
    }],

    //------------------------------------------------------------------------------------------------
    ["UpdateSiloPriorities", {
        private _personality = _self get "personality";
        private _silos = missionNamespace getVariable [QEGVAR(game,silos), []];
        {
            private _silo = _x;
            private _siloNum = _silo getVariable QEGVAR(game,silo_number);
            private _side = _self get "side";
            private _siloPriorities = _self get "silo_priorities";

            private _carriers = missionNamespace getVariable QEGVAR(game,Carriers);
            private _carrier = _carriers get _side;

            // Distance Scoring
            private _leader = _self getOrDefault ["leader", objNull];
            private _distanceScore = 0;
            if (alive _leader) then {
                private _maxDistance = (worldSize / 2) * sqrt 2;
                private _distance = _leader distance2D _silo;
                private _distanceNormalized = _distance / _maxDistance;

                _distanceScore = 1 / (_distanceNormalized max 1e-12);
            } else {
                private _maxDistance = (worldSize / 2) * sqrt 2;
                private _distance = _silo distance2D _carrier;
                private _distanceNormalized = _distance / _maxDistance;
                _distanceScore = 1 / (_distanceNormalized max 1e-12);
            };

            // Friendly Score
            private _friendlyNearby = count (allUnits select {alive _x && side group _x == _side});
            private _maxFriendlies = playableSlotsNumber _side;
            private _friendliesNormalized = _friendlyNearby / _maxFriendlies;
            private _friendlyScore = 1 - _friendliesNormalized;

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
                        if (_owner == sideUnknown) exitWith { 0.9 };
                        if (_owner != _side) exitWith { 1.0 };
                    };
                    case AI_PERSONALITY_DEFENSIVE: { // Prioritize friendly > neutral > enemy
                        if (_owner == _side) exitWith { 0.8 };
                        if (_owner == sideUnknown) exitWith { 0.6 };
                        if (_owner != _side) exitWith { 0.4 };
                    };
                    case AI_PERSONALITY_CHAOTIC: {
                        random 1;
                    };
                };
            };

            // Countdown Score
            private _countdown = _silo getVariable QEGVAR(game,countdown);
            private _maxCountdown = _silo getVariable QEGVAR(game,countdown_time);
            private _countdownNormalized = _countdown / _maxCountdown;
            private _countdownScore = 1 / (_countdownNormalized max 1e-12);

            // Final score
            private _priorityScore =
                (_ownerScore * 0.5) +
                (_distanceScore * 0.3) +
                (_friendlyScore * 0.1) +
                (_countdownScore * 0.8);
            
            _siloPriorities set [_forEachIndex, [_siloNum, _priorityScore]];
            _self call ["SortSiloPriorities"];
        } forEach _silos;
    }]
];