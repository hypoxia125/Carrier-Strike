#include "script_component.hpp"

call FUNC(InitGame);
call FUNC(InitSystems);

GVAR(Game) setVariable [QGVAR(game_state), GAME_STATE_INIT, true];

// Register 3d marker code
GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\MissileTrack3D.sqf)]];
GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\Silo3DMarkers.sqf)]];
GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\Reactor3DMarkers.sqf)]];

// Initialize HUD
call EFUNC(ui,InitHUD);
call EFUNC(ui,DrawSiloIcons);

// Initialize Diary
call FUNC(InitDiary);

// Player stuff
call FUNC(PlayerInitEvents);

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

GVAR(Game) setVariable [QGVAR(game_state), GAME_STATE_POSTINIT, true];
GVAR(Game) setVariable [QGVAR(game_state), GAME_STATE_PLAYING, true];