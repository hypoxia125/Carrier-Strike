if !(isServer) exitWith {};

private _channelData = CarrierStrike_GameData getVariable "chat_notification_channels";
{
    private _channel = radioChannelCreate [[0,1,0,1], "-Status Update-", "%CHANNEL_LABEL", [], true];
    _channelData set [_x, _channel];
} forEach [west, east, independent];