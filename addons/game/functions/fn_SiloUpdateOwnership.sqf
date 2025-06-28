#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_silo", "_newSide"];

private _oldSide = _silo getVariable [QGVAR(side), sideUnknown];
if (_oldSide == _newSide) exitWith {};

_silo setVariable [QGVAR(side), _newSide, true];

// Update light color
private _compositionData = _silo getVariable QGVAR(composition);
private _newLightClass = _compositionData get (toLowerANSI format["light_%1", _newSide]);
if (isNil "_newLightClass") exitWith {
    LOG("SiloUpdateOwnership | Something went wrong...");
};

private _prevLamps = _silo getVariable [QGVAR(lights), []];
{ deleteVehicle _x } forEach _prevLamps;

private _lights = [];
{
    private _pos = _silo modelToWorldWorld (_compositionData get _x);
    private _light = createVehicle [_newLightClass, _pos, [], 0, "CAN_COLLIDE"];
    _light setDir getDir _silo;
    _light setPosASL _pos;

    _light setVectorDirAndUp [vectorDir _silo, vectorUp _silo];
    [_light, _silo] call BIS_fnc_attachToRelative;
} forEach ["light_r", "light_l"];
_silo setVariable [QGVAR(lights), _lights, true];

// Update respawn
private _siloNumber = _silo getVariable QGVAR(silo_number);
private _respawn = _silo getVariable [QGVAR(respawn), []];
switch true do {
    case (_newSide == sideUnknown): {
        if (count _respawn == 2) then {
            _respawn call BIS_fnc_removeRespawnPosition;
        };        
        _respawn = nil;
    };
    case (_newSide != sideUnknown): {
        _respawn = [_newSide, getPosATL _silo, format["Silo: %1", _siloNumber]] call BIS_fnc_addRespawnPosition;
    };
};
_silo setVariable [QGVAR(respawn), _respawn];

// Alerts
private _alerts = missionNamespace getVariable QGVAR(alerts);
private _newOwnerPlayers = units _newSide select { isPlayer _x };
private _oldOwnerPlayers = units _oldSide select { isPlayer _x };

private _alert = _alerts get "silocapture" get _siloNumber;
[QGVAR(AlertAddToSystem), [_alert], _newOwnerPlayers] call CBA_fnc_targetEvent;

private _alert = _alerts get "silolost" get _siloNumber;
[QGVAR(AlertAddToSystem), [_alert], _oldOwnerPlayers] call CBA_fnc_targetEvent;