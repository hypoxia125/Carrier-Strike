#include "script_component.hpp"

call FUNC(InitGame);
call FUNC(InitSystems);
call FUNC(InitDoQueue);

// Register 3d marker code
GVAR(3DMarkerSystem) call ["Register", compileScript ["\z\carrierstrike\addons\main\scripts\MissileTrack3D.sqf"]];
GVAR(3DMarkerSystem) call ["Register", compileScript ["\z\carrierstrike\addons\main\scripts\Silo3DMarkers.sqf"]];