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

if (_commander == "-1") then {
    LOG("CommanderMenu_OnClickApply | No commander - applying...");
    [QEGVAR(game,CommanderApply), [player]] call CBA_fnc_serverEvent;
} else {
    LOG("CommanderMenu_OnClickApply | Already a commander - mutiny...");
    [QEGVAR(game,CommanderMutiny), [player]] call CBA_fnc_serverEvent;
};

closeDialog 1;
