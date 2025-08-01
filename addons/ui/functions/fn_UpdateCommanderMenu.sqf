#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\defines.hpp"

disableSerialization;

if (!hasInterface) exitWith {};
if (!alive player) exitWith { closeDialog 0 };

private _display = findDisplay IDD_COMMANDERMENU;
if (isNull _display) exitWith {};

private _ctrlCommander = _display displayCtrl IDC_COMMANDERMENU_CURRENTCOMMANDER;
private _ctrlScan = _display displayCtrl IDC_COMMANDERMENU_SCAN;
private _ctrlUAV = _display displayCtrl IDC_COMMANDERMENU_UAV;
private _ctrlArtillery = _display displayCtrl IDC_COMMANDERMENU_ARTILLERY;

// get or set the hash
private _commanderData = missionNamespace getVariable QEGVAR(game,CommanderData);
if (isNil "_commanderData") exitWith {
    closeDialog 0;
};

// update commander
private _commanders = _commanderData get "commanders";
private _commander = _commanders get (side group player);
private _commanderNames = _commanderData get "commanderNames";
private _commanderName = _commanderNames get (side group player);

_ctrlCommander ctrlSetText ([_commanderName, "NO COMMANDER"] select (_commanderName == ""));

// update scan
private _scanCooldowns = _commanderData get "scanCooldowns";
private _scanCooldown = _scanCooldowns get (side group player);

private _text = format["Scan: %1", [_scanCooldown, "Ready"] select (_scanCooldown == 0)];
_ctrlScan ctrlSetText _text;

// update uav
// private _UAVCooldowns = _commanderData get "uavCooldowns";
// private _UAVCooldown = _UAVCooldowns get (side group player);

// private _text = format["UAV: %1", [_UAVCooldown, "Ready"] select (_UAVCooldown == 0)];
// _ctrlUAV ctrlSetText _text;

// update artillery
private _artilleryCooldowns = _commanderData get "artilleryCooldowns";
private _artilleryCooldown = _artilleryCooldowns get (side group player);

private _text = format["Artillery: %1", [_artilleryCooldown, "Ready"] select (_artilleryCooldown == 0)];
_ctrlArtillery ctrlSetText _text;

// Enable or Disable Controls
if (_commander == getPlayerID player) then {
    if (_scanCooldown == 0) then {
        _ctrlScan ctrlEnable true;
    } else {
        _ctrlScan ctrlEnable false;
    };

    // if (_UAVCooldown == 0) then {
    //     _ctrlUAV ctrlEnable true;
    // } else {
    //     _ctrlUAV ctrlEnable false;
    // };

    if (_artilleryCooldown == 0) then {
        _ctrlArtillery ctrlEnable true;
    } else {
        _ctrlArtillery ctrlEnable false;
    };
} else {
    {
        _x ctrlEnable false;
    } forEach [_ctrlScan, _ctrlUAV, _ctrlArtillery];
};
