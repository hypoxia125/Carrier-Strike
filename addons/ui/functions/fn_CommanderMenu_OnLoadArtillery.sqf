#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {
    closeDialog 0;
};

private _artilleryCooldowns = _commanderData get "artilleryCooldowns";
private _artilleryCooldown = _artilleryCooldowns get (side group player);

_control ctrlSetText format[LLSTRING(ArtilleryCooldown),[_artilleryCooldown, LLSTRING(Ready)] select (_artilleryCooldown == 0)];

if (_artilleryCooldown == 0 && [player] call EFUNC(game,UnitIsCommander)) then {
    _control ctrlEnable true;
} else {
    _control ctrlEnable false;
};
