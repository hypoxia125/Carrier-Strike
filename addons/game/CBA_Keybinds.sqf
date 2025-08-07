#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\z\carrierstrike\addons\ui\defines.hpp"

/*
Parameters
_addon	Name of the registering mod + optional sub-category <STRING, ARRAY>
_action	Id of the key action.  STRING
_title	Pretty name, or an array of pretty name and tooltip STRING
_downCode	Code for down event, empty string for no code.  <CODE>
_upCode	Code for up event, empty string for no code.  <CODE>
Optional
_defaultKeybind	The keybinding data in the format [DIK, [shift, ctrl, alt]] ARRAY
_holdKey	Will the key fire every frame while down <BOOLEAN>
_holdDelay	How long after keydown will the key event fire, in seconds.  <NUMBER>
_overwrite	Overwrite any previously stored default keybind <BOOLEAN>
*/

["CarrierStrike", "CommanderMenuOpen", "Open CommanderMenu", {
    if (!isNull findDisplay IDD_COMMANDERMENU) exitWith {};
    if (side group player == independent) exitWith {};
    if (!alive player) exitWith {};
    createDialog QEGVAR(ui,CommanderMenu);
}, {}, [DIK_Y], false, 0, true] call CBA_fnc_addKeybind;

["CarrierStrike", "CommanderVoteYes", "Vote Yes", {
    private _voteInProg = missionNamespace getVariable [QGVAR(CommanderVoteInProg), false];
    private _alreadyVoted = missionNamespace getVariable [QGVAR(CommanderVoteSubmitted), false];
    TRACE_2("Keybinds::CommanderVoteYes",_voteInProg,_alreadyVoted);
    if (_voteInProg && !_alreadyVoted) then {
        hintSilent "You voted 'Yes'";
        [QGVAR(CommanderVote), [true, side group player]] call CBA_fnc_serverEvent;
        missionNamespace setVariable [QGVAR(CommanderVoteSubmitted), true];
    } else {
        LOG("Keybinds::CommanderVoteYes | Not the right time to vote...");
    };
}, {}, [DIK_PRIOR], false, 0, true] call CBA_fnc_addKeybind;

["CarrierStrike", "CommanderVoteNo", "Vote No", {
    private _voteInProg = missionNamespace getVariable [QGVAR(CommanderVoteInProg), false];
    private _alreadyVoted = missionNamespace getVariable [QGVAR(CommanderVoteSubmitted), false];
    TRACE_2("Keybinds::CommanderVoteNo",_voteInProg,_alreadyVoted);
    if (_voteInProg && !_alreadyVoted) then {
        hintSilent "You voted 'No'";
        [QGVAR(CommanderVote), [false, side group player]] call CBA_fnc_serverEvent;
        missionNamespace setVariable [QGVAR(CommanderVoteSubmitted), true];
    } else {
        LOG("Keybinds::CommanderVoteNo | Not the right time to vote...");
    };
}, {}, [DIK_NEXT], false, 0, true] call CBA_fnc_addKeybind;
