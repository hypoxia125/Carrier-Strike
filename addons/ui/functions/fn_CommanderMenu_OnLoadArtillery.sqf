#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {
    closeDialog 0;
};

private _artilleryCooldowns = _commanderData get "artilleryCooldowns";
private _artilleryCooldown = _artilleryCooldowns get (side group player);

if (_artilleryCooldown == 0) then {
    _control ctrlEnable true;
} else {
    _control ctrlEnable false;
};
