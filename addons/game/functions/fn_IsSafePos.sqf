#include "script_component.hpp"

params ["_candidate", "_nearTerrainRadius", "_nearObjectRadius"];

private _isNearTerrainObject = nearestTerrainObjects [_candidate, [], _nearTerrainRadius] isNotEqualTo [];
private _isNearObjects = nearestObjects [_candidate, [], _nearObjectRadius] isNotEqualTo [];
private _isUnderSurface = lineIntersectsSurfaces [AGLToASL _candidate, AGLToASL _candidate vectorAdd [0,0,100], player, objNull, false, 1, "VIEW"] isNotEqualTo [];
private _isWater = surfaceIsWater _candidate;

if (!_isNearTerrainObject && !_isNearObjects && !_isUnderSurface && !_isWater) exitWith {
    true
};

false