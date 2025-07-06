#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_loser"];

private _victor = ([west, east] - [_loser]) # 0;

[format["Win_%1", _victor], true, true, false, true] remoteExec ["BIS_fnc_endMission"];
