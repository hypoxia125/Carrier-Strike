#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {
    closeDialog 0;
};

private _scanCooldowns = _commanderData get "scanCooldowns";
private _scanCooldown = _scanCooldowns get (side group player);

if (_scanCooldown == 0) then {
    _control ctrlEnable true;
} else {
    _control ctrlEnable false;
};
