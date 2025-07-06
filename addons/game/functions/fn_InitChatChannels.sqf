#include "script_component.hpp"

if (!isServer) exitWith {};

private _channels = createHashMapFromArray [
    //! Global chat channel, used for status updates
    ["notification", createHashMapFromArray [
        ["channel_ids", createHashMapFromArray [
            [west, -1],
            [east, -1],
            [independent, -1]
        ]],
        ["channel_units", createHashMapFromArray [
            [west, objNull],
            [east, objNull],
            [independent, objNull]
        ]]
    ]]
];

{
    // Dummy object
    private _group = createGroup civilian;
    private _logic = _group createUnit ["logic", [-1000,-1000,0], [], 0, "NONE"];
    [_logic] joinSilent _group;

    private _channel = radioChannelCreate [
        [1,0.5,0,1],
        "-Status Update-",
        "%CHANNEL_LABEL",
        [_logic],
        true
    ];

    _channels get "notification" get "channel_ids" set [_x, _channel];
    _channels get "notification" get "channel_units" set [_x, _logic];
} forEach [west, east, independent];

missionNamespace setVariable [QGVAR(chat_channels), _channels, true];
