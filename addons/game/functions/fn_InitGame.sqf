#include "script_component.hpp"

GVAR(Game) = true call CBA_fnc_CreateNamespace;

private _data = createHashMapFromArray [
    ["silos", []],
    ["missiles", []],
    ["game_state", ""],

    ["chatNotificationChannels", createHashMapFromArray [
        [west, -1],
        [east, -1],
        [independent, -1]
    ]],

    ["missile_targets", createHashMapFromArray [
        [west, objNull],
        [east, objNull],
        [independent, objNull]
    ]],

    ["carriers", createHashMapFromArray [
        [west, objNull],
        [east, objNull]
    ]],
    
    ["eventHandles", createHashMapFromArray [
    ]],

    // Alerts
    ["alerts", createHashMapFromArray [
        ["silotimeremaining", createHashMapFromArray [
            [120, QPATHTOEF(common,data\sound\VO\betty\missilelaunchcountdown_120s.ogg)],
            [60, QPATHTOEF(common,data\sound\VO\betty\missilelaunchcountdown_60s.ogg)],
            [30, QPATHTOEF(common,data\sound\VO\betty\missilelaunchcountdown_30s.ogg)],
            [6, QPATHTOEF(common,data\sound\VO\betty\missilelaunchcountdown_5s.ogg)]
        ]],
        ["silocapture", createHashMapFromArray [
            [1, QPATHTOEF(common,data\sound\VO\commander\capturedsilo1.ogg)],
            [2, QPATHTOEF(common,data\sound\VO\commander\capturedsilo2.ogg)],
            [3, QPATHTOEF(common,data\sound\VO\commander\capturedsilo3.ogg)],
            [4, QPATHTOEF(common,data\sound\VO\commander\capturedsilo4.ogg)],
            [5, QPATHTOEF(common,data\sound\VO\commander\capturedsilo5.ogg)]
        ]],
        ["silolost", createHashMapFromArray [
            [1, QPATHTOEF(common,data\sound\VO\commander\lostsilo1.ogg)],
            [2, QPATHTOEF(common,data\sound\VO\commander\lostsilo2.ogg)],
            [3, QPATHTOEF(common,data\sound\VO\commander\lostsilo3.ogg)],
            [4, QPATHTOEF(common,data\sound\VO\commander\lostsilo4.ogg)],
            [5, QPATHTOEF(common,data\sound\VO\commander\lostsilo5.ogg)]
        ]]
    ]],

    ["respawn_positions", []]
];

{
    GVAR(Game) setVariable [format[QGVAR(%1),_x], _y]
} forEach _data;