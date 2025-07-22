params ["_unit"];

if (!isServer) exitWith {};

private _playerID = playerID _unit;
if (_playerID == -1) exitWith {};

private _userInfo = getUserInfo _playerID;
private _owner = _userInfo select 1;
private _name = _userInfo select 3;

[QGVAR(CommanderVote), [], units (side group _unit)] call CBA_fnc_targetEvent;

private _commanderVotes = createHashMapFromArray [
    [west, createHashMapFromArray [
        ["yes", 0],
        ["no", 0]
    ]],
    [east, createHashMapFromArray [
        ["yes", 0],
        ["no", 0]
    ]]
];
missionNamespace setVariable [QGVAR(CommanderVotes), _commanderVotes, true];

// TODO: move to client side
addMissionEventHandler ["HandleChatMessage", {
	params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

    private _decision = "UNDECIDED";
    if (_text == "VOTEYES") then {
        GVAR(Commander_VoteYes) = GVAR(Commander_VoteYes) + 1;
        _decision = "YES";
    };
    if (_text == "VOTENO") then {
        GVAR(Commander_VoteNo) == GVAR(Commander_VoteNo) + 1;
        _decision = "NO";
    };

    ["COMMANDER VOTE", format["[%1] has voted %2", _decision]];
}];