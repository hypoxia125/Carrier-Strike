#include "script_component.hpp"

if (!isServer) exitWith {};

params [["_group", grpNull], ["_rallyPoint", objNull]];

private _rallyPoint = _group getVariable [QGVAR(RallyPointObject), objNull];

if (!isNull _rallyPoint && !isNull _group) then {
    INFO_1("RallyPointSystem::DestroyRally | Destroying rally for group: %1",_group);

    private _rallyObjects = _rallyPoint getVariable [QGVAR(RallyObjects), []];
    private _respawn = _group getVariable [QGVAR(RallyRespawnPosition), []];
    _respawn call BIS_fnc_removeRespawnPosition;

    { deleteVehicle _x } forEach _rallyObjects;
    deleteVehicle _rallyPoint;
    _group setVariable [QGVAR(RallyPointObject), objNull];

    [QGVAR(HintSilent), ["Rally Point Destroyed"], units _group] call CBA_fnc_targetEvent;
};

if (!isNull _rallyPoint && isNull _group) then {
    INFO("RallyPointSystem::DestroyRally | Destroying rally for group that no longer exists or is empty");

    private _rallyObjects = _rallyPoint getVariable [QGVAR(RallyObjects), []];
    { deleteVehicle _x } forEach _rallyObjects;
    deleteVehicle _rallyPoint;
};