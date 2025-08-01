#include "script_component.hpp"

if (!isServer) exitWith {};
if (!canSuspend) exitWith { _this spawn FUNC(CommanderMutiny) };

params ["_unit"];

private _side = side group _unit;
private _name = name _unit;

LOG_1("CommanderMutiny | Mutiny against %1",_name);

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

[QGVAR(CommanderVoteNotification), [_name, nil, true], units _side] call CBA_fnc_targetEvent;

missionNamespace setVariable [QGVAR(CommanderVoteInProg), true, true];
missionNamespace setVariable [QGVAR(CommanderVoteSubmitted), false, true];

sleep 10;

private _votesYes = _commanderVotes get _side get "yes";
private _votesNo = _commanderVotes get _side get "no";

if (_votesYes > _votesNo) then {
    LOG("CommanderApply | Commander mutiny succeeded");
    [_side] call FUNC(CommanderUnassign);
    [QGVAR(CommanderVoteNotification), [_name, true, true], units _side] call CBA_fnc_targetEvent;
} else {
    LOG("CommanderApply | Commander mutiny failed");
    [QGVAR(CommanderVoteNotification), [_name, false, true], units _side] call CBA_fnc_targetEvent;
};

missionNamespace setVariable [QGVAR(CommanderVoteInProg), false, true];
