#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {};
private _commanders = _commanderData get "commanders";
private _commander = _commanders get (side group player);

if (missionNamespace getVariable [QGVAR(CommanderVoteInProg), false]) exitWith {
    hintSilent LLSTRING(CommanderVoteInProgress);
};

switch true do {
    case (_commander == "-1"): {
        [QEGVAR(game,CommanderApply), [player]] call CBA_fnc_serverEvent;
    };
    case (_commander == getPlayerID player): {
        [QEGVAR(game,CommanderResign), [player]] call CBA_fnc_serverEvent;
    };
    default {
        [QEGVAR(game,CommanderMutiny), [player]] call CBA_fnc_serverEvent;
    };
};

closeDialog 1;
