#include "script_component.hpp"

call FUNC(InitGame);
call FUNC(InitSystems);

missionNamespace setVariable [QGVAR(game_state), GAME_STATE_INIT, true];

if (hasInterface) then {
    // Register 3d marker code
    GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\MissileTrack3D.sqf)]];
    GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\Silo3DMarkers.sqf)]];
    GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\Reactor3DMarkers.sqf)]];

    // Initialize HUD
    call EFUNC(ui,InitHUD);
    call EFUNC(ui,DrawSiloIcons);
};

// Weather
call FUNC(SetWeather);

// Chat channels
call FUNC(InitChatChannels);

// Initialize Diary
call FUNC(InitDiary);

// Player stuff
call FUNC(PlayerInit);

// Dynamic groups
if (isServer) then {
    ["Initialize"] call BIS_fnc_dynamicGroups;
};
if (hasInterface) then {
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
    private _newGroup = createGroup [side group player, true];
    [player] joinSilent _newGroup;
};

// Loadouts
[1] call FUNC(UnlockLoadouts);

[{
    missionNamespace setVariable [QGVAR(game_state), GAME_STATE_POSTINIT, true];
}] call CBA_fnc_execNextFrame;

[] spawn {
    waitUntil { time > 0 };
    missionNamespace setVariable [QGVAR(game_state), GAME_STATE_PLAYING, true];
};