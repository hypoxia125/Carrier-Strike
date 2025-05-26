#include "script_component.hpp"

if (!isServer) exitWith {};
if (!isNil QGVAR(VehicleRespawnSystem)) exitWith {};

GVAR(VehicleRespawnSystem) = createHashMapObject [[
    ["#type", "VehicleRespawnSystem"],
    ["#create", {
        _self call ["SystemStart", []];
    }],

    ["m_updateRate", 1],
    ["m_frameSystemHandle", -1],
    ["m_entityMaps", []],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _entityMaps = _self get "m_entityMaps";
        {
            private _entityMap = _x;
            private _owner = _entityMap get "owner";
            if (isNil "_owner") then { continue };
            private _side = sideUnknown;
            if (_owner isEqualType sideUnknown) then {
                _side = _owner;
            };
            if (_owner isEqualType objNull) then {
                _side = (_entityMap get "owner") getVariable [QGVAR(side), sideUnknown];
            };

            if (_side == sideUnknown) then {
                // reset timer
                _entityMap set ["countdown", _entityMap get "respawn_time"];
                continue;
            };

            if (_entityMap get "initial_spawn") then {
                _entityMap set ["countdown", 0];
                _entityMap set ["initial_spawn", false];
            };

            // skip if there is a currently active vehicle with crew
            private _activeVehicle = _entityMap get "active_vehicle";
            if (!isNull _activeVehicle && alive _activeVehicle && count crew _activeVehicle != 0) then {
                // reset timer
                _entityMap set ["countdown", _entityMap get "respawn_time"];
                continue;
            };

            // delete vehicle if empty
            if (_entityMap get "countdown" <= 0) then {
                if (!isNull _activeVehicle && count crew _activeVehicle == 0) then {
                    deleteVehicle _activeVehicle;
                    _entityMap set ["active_vehicle", objNull];
                };
            };

            //////////////////////
            // Spawn New Vehicle
            //////////////////////
            if (_entityMap get "countdown" <= 0) then {
                // LOG_1("%1::Update | Starting spawn sequence.",(_self get "#type")#0);
                private _position = _entityMap get "position";

                // area check for colliding vehicles and delete them
                private _nearEntities = _position nearEntities 3;
                if (_nearEntities isNotEqualTo []) then {
                    {
                        if (count crew _x != 0) then { continue };
                        deleteVehicle _x;
                    } forEach _nearEntities;
                };

                // clear map of nearby dead things
                private _nearDead = allDead select { _x distance _position <= 10 };
                { deleteVehicle _x } forEach _nearDead;

                // finally spawn vehicle - next frame
                [{
                    params ["_entityMap", "_side"];
                    private _class = _entityMap get _side;
                    private _position = _entityMap get "position";
                    private _dir = _entityMap get "direction";
                    private _vehicle = createVehicle [_class, [0,0,0], [], 0, "NONE"];
                    private _code = _entityMap get "expression";
                    _vehicle setDir _dir;
                    _vehicle setPosASL AGLToASL _position;

                    [_vehicle, _side] call _code;

                    _entityMap set ["active_vehicle", _vehicle];
                }, [_entityMap, _side]] call CBA_fnc_execNextFrame;

                // reset timer
                _entityMap set ["countdown", _entityMap get "respawn_time"];
            };

            // incriment timer
            _entityMap set ["countdown", ((_entityMap get "countdown") - 1) max 0];
        } forEach _entityMaps;
    }],

    //------------------------------------------------------------------------------------------------
    ["Register", {
        params ["_entityMap"];
        
        private _entityMaps = _self get "m_entityMaps";
        
        _entityMaps insert [-1, [_entityMap]];

        LOG_2("%1::Register | EntityMap registered: %2",(_self get "#type")#0,_entityMap);
    }],

    //------------------------------------------------------------------------------------------------
    ["SystemStart", {
        private _handle = [{
            params ["_args", "_handle"];
            _args params ["_self"];

            if (!isMultiplayer && isGamePaused) exitWith {};

            _self call ["Update", []];
        }, _self get "m_updateRate", [_self]] call CBA_fnc_addPerFrameHandler;

        LOG_1("%1::SystemStart | System started.",(_self get "#type")#0);

        _self set ["m_frameSystemHandle", _handle];
    }]
]];