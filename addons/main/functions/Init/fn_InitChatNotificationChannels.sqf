if !(isServer) exitWith {};

private _data = call CarrierStrike_fnc_GetData;
private _channelData = _data getVariable "chat_notification_channels";
{
    private _channel = radioChannelCreate [[0,1,0,1], "-Status Update-", "%CHANNEL_LABEL", [], true];
    _channelData set [_x, _channel];

    // create identity
    private _group = createGroup [_x, true];
    private _dummy = _group createUnit ["logic", [-1000, -1000, 0], [], 0, "NONE"];
    [_dummy] joinSilent _group;
    _group setGroupId ["-Status Update-"];
    _dummy setIdentity "Male01PER";
} forEach [west, east, independent];