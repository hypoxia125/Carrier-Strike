#include "script_component.hpp"

if (isServer) then {
    call compileScript [QPATHTOF(systems\SiloControlSystem.sqf)];
    call compileScript [QPATHTOF(systems\MissileTrackingSystem.sqf)];
    call compileScript [QPATHTOF(systems\VehicleRespawnSystem.sqf)];
};

if (hasInterface) then {
    call compileScript [QPATHTOF(systems\3DMarkerSystem.sqf)];
    call compileScript [QPATHTOF(systems\AlertQueueSystem.sqf)];
};