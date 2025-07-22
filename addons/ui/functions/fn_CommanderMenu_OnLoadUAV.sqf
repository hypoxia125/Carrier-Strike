#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {
    closeDialog 0;
};

private _uavCooldowns = _commanderData get "uavCooldowns";
private _uavCooldown = _uavCooldowns get (side group player);

if (_uavCooldown == 0) then {
    _control ctrlEnable true;
} else {
    _control ctrlEnable false;
};
