#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
private _cooldown = _commanderData get "artilleryCooldowns" get (side group player);
if (_cooldown != 0) exitWith {
    hintSilent "Artillery Is On Cooldown";
};

openMap false;

hintSilent "Select Location For Artillery\nHold Right Click: Move Map\nLeft Click: Activate";

addMissionEventHandler ["Map", {
    params ["_mapIsOpened", "_mapIsForced"];

    if (_mapIsOpened) then {
        addMissionEventHandler ["MapSingleClick", {
            params ["_units", "_pos", "_alt", "_shift"];

            [_pos, side group player] call EFUNC(game,CommanderArtillery);

            openMap false;

            removeMissionEventHandler [_thisEvent, _thisEventHandler];
        }];
    } else {
        removeMissionEventHandler [_thisEvent, _thisEventHandler];
    };
}];

closeDialog 1;
openMap true;
