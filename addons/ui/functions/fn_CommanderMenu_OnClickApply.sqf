#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith { LOG("CommanderMenu_OnClickApply | This isn't supposed to happen. Line 7") };
private _commanders = _commanderData get "commanders";
private _commander = _commanders get (side group player);

if (missionNamespace getVariable [QGVAR(CommanderVoteInProg), false]) exitWith {
    hintSilent "Commander vote in progress.\nWait for next round of voting.";
};

switch true do {
    case (_commander == "-1"): {
        LOG("CommanderMenu_OnClickApply | No commander - applying...");
        [QEGVAR(game,CommanderApply), [player]] call CBA_fnc_serverEvent;
    };
    case (_commander == getPlayerID player): {
        LOG("CommanderMenu_OnClickApply | You are commander - resigning...");
        [QEGVAR(game,CommanderResign), [player]] call CBA_fnc_serverEvent;
    };
    default {
        LOG("CommanderMenu_OnClickApply | Already a commander - mutiny...");
        [QEGVAR(game,CommanderMutiny), [player]] call CBA_fnc_serverEvent;
    };
};

closeDialog 1;
