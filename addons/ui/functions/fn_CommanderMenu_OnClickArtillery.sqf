#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
private _cooldown = _commanderData get "artilleryCooldowns" get (side group player);
if (_cooldown != 0) exitWith {
    hintSilent LLSTRING(ArtilleryOnCooldown);
};

openMap false;

hintSilent LLSTRING(SelectArtilleryLocation);

addMissionEventHandler ["Map", {
    params ["_mapIsOpened", "_mapIsForced"];

    if (isNil {missionNamespace getVariable QGVAR(CommanderArtilleryInvalidMarkers)}) then {
        missionNamespace setVariable [QGVAR(CommanderArtilleryInvalidMarkers), []];
    };
    private _markers = missionNamespace getVariable [QGVAR(CommanderArtilleryInvalidMarkers), []];

    if (_mapIsOpened) then {

        private _respawnData = missionNamespace getVariable [QEGVAR(game,respawn_positions), []];
        {
            _x params ["_respawn", "_type", "_area"];

            if (_respawn#0 == independent) then { continue };

            // extend area
            _area set [1, 300];
            _area set [2, 300];

            // create invalid markers
            private _markerName = format["InvalidArty: %1", _area];
            private _marker = createMarkerLocal [_markerName, _area select 0];
            _marker setMarkerShapeLocal "ELLIPSE"; 
            _marker setMarkerBrushLocal "Cross";
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerSizeLocal [_area#1, _area#2];
            _markers pushBack _marker;
        } forEach _respawnData;

        addMissionEventHandler ["MapSingleClick", {
            params ["_units", "_pos", "_alt", "_shift"];

            [_pos, side group player] call EFUNC(game,CommanderArtillery);

            openMap false;

            removeMissionEventHandler [_thisEvent, _thisEventHandler];
        }];
    } else {
        { deleteMarker _x } forEach _markers;
        removeMissionEventHandler [_thisEvent, _thisEventHandler];
    };
}];

closeDialog 1;

openMap true;
mapAnimAdd [0, 0.5, getPosATL player];
mapAnimCommit;
