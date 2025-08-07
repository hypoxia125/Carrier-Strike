#include "script_component.hpp"

params ["_unit"];

if (!isServer) exitWith {};
if (!canSuspend) exitWith { _this spawn FUNC(CommanderApply) };

LOG_1("CommanderApply | %1 is applying for commander",name _unit);

private _playerID = getPlayerID _unit;
if (_playerID == "-1") exitWith {};

private _userInfo = getUserInfo _playerID;
private _owner = _userInfo select 1;
private _name = _userInfo select 3;
private _side = side group _unit;

TRACE_3("CommanderApply | Post User Info",_owner,_name,_side);

private _commanderVotes = missionNamespace getVariable QGVAR(CommanderVotes);
if (isNil "_commanderVotes") then {
    _commanderVotes = createHashMapFromArray [
        [west, createHashMapFromArray [
            ["yes", 0],
            ["no", 0]
        ]],
        [east, createHashMapFromArray [
            ["yes", 0],
            ["no", 0]
        ]]
    ];

    missionNamespace setVariable [QGVAR(CommanderVotes), _commanderVotes];
};

_commanderVotes get _side set ["yes", 0];
_commanderVotes get _side set ["no", 0];

[QGVAR(CommanderVoteNotification), [_name], units _side] call CBA_fnc_targetEvent;

missionNamespace setVariable [QGVAR(CommanderVoteInProg), true, true];
missionNamespace setVariable [QGVAR(CommanderVoteSubmitted), false, true];

sleep 10;

private _votesYes = _commanderVotes get _side get "yes";
private _votesNo = _commanderVotes get _side get "no";

if (_votesYes > _votesNo) then {
    LOG("CommanderApply | Commander vote succeeded");
    [_playerID] call FUNC(CommanderAssign);
    [QGVAR(CommanderVoteNotification), [_name, true], units _side] call CBA_fnc_targetEvent;
} else {
    LOG("CommanderApply | Commander vote failed");
    [QGVAR(CommanderVoteNotification), [_name, false], units _side] call CBA_fnc_targetEvent;
};

missionNamespace setVariable [QGVAR(CommanderVoteInProg), false, true];
