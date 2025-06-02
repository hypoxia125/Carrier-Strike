#include "script_component.hpp"

params ["_carrier"];

// Stop respawns
setPlayerRespawnTime 30;

private _side = _carrier getVariable QGVAR(side);

// Alarm
if (isServer) then {
    [{
        params ["_args", "_handle"];
        _args params ["_carrier"];

        if (missionNamespace getVariable QGVAR(game_state) == GAME_STATE_ENDED) exitWith {
            _handle call CBA_fnc_removePerFrameHandler;
        };
        if (!isMultiplayer && isGamePaused) exitWith {};

        private _positions = _carrier getVariable QGVAR(speaker_positions);
        {
            playSound3D ["\A3\Sounds_F\sfx\alarm.wss", _carrier, false, _x, 5, 1, 500];
        } forEach _positions;
    }, 1, [_carrier]] call CBA_fnc_addPerFrameHandler;
};

// Explosions
if (isServer) then {
    [_carrier] spawn {
        while { missionNamespace getVariable QGVAR(game_state) != GAME_STATE_ENDED } do {
            params ["_carrier"];

            // spawn explosion
            private _modelPositions = _carrier getVariable QGVAR(composition) get "explosion_posAGL";
            private _positions = _modelPositions apply { _carrier modelToWorld _x };
            private _pos = selectRandom _positions;
            _pos = AGLToASL _pos;

            private _bomb = createVehicle ["Bo_GBU12_LGB", _pos, [], 0, "CAN_COLLIDE"];
            _bomb hideObjectGlobal true;
            triggerAmmo _bomb;

            sleep (random 1 max 0.25);
        };
    };
};

// Start timer for game end
if (isServer) then {
    [_side] spawn {
        params ["_side"];
        private _time = time;
        waitUntil { time >= _time + 20};
        missionNamespace setVariable [QGVAR(game_state), GAME_STATE_ENDED, true];
        [_side] call FUNC(EndGame);
    };
};

// Build camera for clients
if (hasInterface) then {
    [_carrier] spawn {
        params ["_carrier"];
        private _time = time;
        waitUntil { time >= _time + 12 };

        private _position = _carrier getVariable [QGVAR(endGameCameraPosition), []];
        if (_position isEqualTo []) exitWith {};

        private _camera = "camera" camCreate _position;

        showCinemaBorder false;
        _camera cameraEffect ["External", "BACK"];
        _camera camSetTarget _carrier;
        _camera camCommit 0;
    };
};