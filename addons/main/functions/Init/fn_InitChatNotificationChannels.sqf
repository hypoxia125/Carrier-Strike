if !(isServer) exitWith {};

// TODO: Add itentities for "announcer"

private _data = call CarrierStrike_fnc_GetData;
private _channelData = _data getVariable "chat_notification_channels";
{
    private _channel = radioChannelCreate [[0,1,0,1], "-Status Update-", "%CHANNEL_LABEL", [], true];
    _channelData set [_x, _channel];
} forEach [west, east, independent];