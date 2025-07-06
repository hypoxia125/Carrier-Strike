#include "script_component.hpp"

// NEEDS POS ASL
params ["_candidate", "_nearTerrainRadius", "_nearObjectRadius"];

// AGL
private _isNearTerrainObject = nearestTerrainObjects [ASLToAGL _candidate, [], _nearTerrainRadius] isNotEqualTo [];

// AGL
private _isNearObjects = nearestObjects [ASLToAGL _candidate, [], _nearObjectRadius] isNotEqualTo [];

// ASL
private _isUnderSurface = lineIntersectsSurfaces [_candidate, _candidate vectorAdd [0,0,100], player, objNull, false, 1, "VIEW"] isNotEqualTo [];

private _isWater = surfaceIsWater _candidate;

if (!_isNearTerrainObject && !_isNearObjects && !_isUnderSurface && !_isWater) exitWith {
    true
};

false
