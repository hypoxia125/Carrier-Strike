#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {
    closeDialog 0;
};

private _uavCooldowns = _commanderData get "uavCooldowns";
private _uavCooldown = _uavCooldowns get (side group player);

// _control ctrlSetText format[LLSTRING(UAVCooldown),[_uavCooldown, LLSTRING(Ready)] select (_uavCooldown == 0)];

// if (_uavCooldown == 0 && [player] call EFUNC(game,UnitIsCommander)) then {
//     _control ctrlEnable true;
// } else {
//     _control ctrlEnable false;
// };
_control ctrlEnable false;
