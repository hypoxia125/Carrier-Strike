#include "script_component.hpp"

if (!isMultiplayer) exitWith {
    ERROR_WITH_TITLE(LLSTRING(MultiplayerOnly),LLSTRING(SinglePlayerError));
};

missionNamespace setVariable [QGVAR(game_state), -1, true];

call FUNC(InitGame);
call FUNC(InitSystems);

if (isServer) then {
    missionNamespace setVariable [QGVAR(game_state), GAME_STATE_INIT, true];

    call FUNC(SetWeather);
    call FUNC(InitChatChannels);
    [1, 1] call FUNC(UnlockLoadouts);

    [] spawn compileScript [QPATHTOF(scripts\SeedingNotification.sqf)];

    ["Initialize"] call BIS_fnc_dynamicGroups;

    [{
        missionNamespace setVariable [QGVAR(game_state), GAME_STATE_POSTINIT, true];
    }] call CBA_fnc_execNextFrame;

    [] spawn {
        waitUntil { time > 0 };
        missionNamespace setVariable [QGVAR(game_state), GAME_STATE_PLAYING, true];
    };
};

if (hasInterface) then {
    // Register 3d marker code
    GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\MissileTrack3D.sqf)]];
    GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\Silo3DMarkers.sqf)]];
    GVAR(3DMarkerSystem) call ["Register", compileScript [QPATHTOF(scripts\Reactor3DMarkers.sqf)]];

    // Initialize HUD
    call EFUNC(ui,InitHUD);
    call EFUNC(ui,DrawSiloIcons);

    call FUNC(InitDiary);
    call FUNC(PlayerInit);

    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
    private _newGroup = createGroup [side group player, true];
    [player] joinSilent _newGroup;
};

// Event Handlers
call compileScript ["\z\carrierstrike\addons\game\MissionEventHandlers.sqf"];
