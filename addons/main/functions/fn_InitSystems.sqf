#include "script_component.hpp"

if (isServer) then {
    call compileScript ["\z\carrierstrike\addons\main\systems\SiloControlSystem.sqf"];
    call compileScript ["\z\carrierstrike\addons\main\systems\MissileTrackingSystem.sqf"];
    call compileScript ["\z\carrierstrike\addons\main\systems\VehicleRespawnSystem.sqf"];
};

if (hasInterface) then {
    call compileScript ["\z\carrierstrike\addons\main\systems\3DMarkerSystem.sqf"];
    call compileScript ["\z\carrierstrike\addons\main\systems\AlertQueueSystem.sqf"];
};