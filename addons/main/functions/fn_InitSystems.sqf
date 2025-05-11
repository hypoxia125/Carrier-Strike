#include "script_component.hpp"

if (!isServer) exitWith {};

call compileScript ["\z\carrierstrike\addons\main\systems\GameSystem.sqf"];
call compileScript ["\z\carrierstrike\addons\main\systems\SiloControlSystem.sqf"];
call compileScript ["\z\carrierstrike\addons\main\systems\MissileTrackingSystem.sqf"];