#include "script_component.hpp"

if (!isServer) exitWith {};

private _hqhash = GVAR(Game) getVariable QGVAR(chatHeadquarterLogic);
private _channelHash = GVAR(Game) getVariable QGVAR(chatNotificationChannels);

// Dummy objects
{
    private _group = createGroup _x;
    private _logic = _group createUnit ["logic", [-1000,-1000,0], [], 0, "NONE"];
    [_logic] joinSilent _group;

    _hqhash set [side _group, _logic];
} forEach [west, east, independent];

// Channels
private _westMsg = radioChannelCreate [
    [0,1,0,1],
    "-Status Update-",
    "%CHANNEL_LABEL",
    [_hqhash get west],
    true
];
_channelHash set [west, _westMsg];

private _eastMsg = radioChannelCreate [
    [0,1,0,1],
    "-Status Update-",
    "%CHANNEL_LABEL",
    [_hqhash get east],
    true
];
_channelHash set [east, _westMsg];

private _independentMsg = radioChannelCreate [
    [0,1,0,1],
    "-Status Update-",
    "%CHANNEL_LABEL",
    [_hqhash get independent],
    true
];
_channelHash set [independent, _westMsg];

GVAR(Game) setVariable [QGVAR(chatHeadquarterLogic), _hqhash, true];
GVAR(Game) setVariable [QGVAR(chatNotificationChannels), _channelHash, true];