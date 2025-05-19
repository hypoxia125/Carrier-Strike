#include "script_component.hpp"

setViewDistance 1200;
setObjectViewDistance 1200;
setShadowDistance 100;

call FUNC(InitGame);
call FUNC(InitSystems);
call FUNC(InitDoQueue);

// Register 3d marker code
GVAR(3DMarkerSystem) call ["Register", compileScript ["\z\carrierstrike\addons\main\scripts\MissileTrack3D.sqf"]];
GVAR(3DMarkerSystem) call ["Register", compileScript ["\z\carrierstrike\addons\main\scripts\Silo3DMarkers.sqf"]];

// Initialize HUD
call FUNC(InitHUD);

// Initialize Diary
call FUNC(InitDiary);