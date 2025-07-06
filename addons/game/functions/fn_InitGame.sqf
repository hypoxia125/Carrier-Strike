#include "script_component.hpp"

if (!isServer) exitWith {};

private _data = createHashMapFromArray [

    ["alerts", createHashMapFromArray [
        ["silotimeremaining", createHashMapFromArray [
            [120, QPATHTOEF(sound,data\sound\VO\betty\missilelaunchcountdown_120s.ogg)],
            [60, QPATHTOEF(sound,data\sound\VO\betty\missilelaunchcountdown_60s.ogg)],
            [30, QPATHTOEF(sound,data\sound\VO\betty\missilelaunchcountdown_30s.ogg)],
            [6, QPATHTOEF(sound,data\sound\VO\betty\missilelaunchcountdown_5s.ogg)]
        ]],
        ["silocapture", createHashMapFromArray [
            [1, QPATHTOEF(sound,data\sound\VO\commander\capturedsilo1.ogg)],
            [2, QPATHTOEF(sound,data\sound\VO\commander\capturedsilo2.ogg)],
            [3, QPATHTOEF(sound,data\sound\VO\commander\capturedsilo3.ogg)],
            [4, QPATHTOEF(sound,data\sound\VO\commander\capturedsilo4.ogg)],
            [5, QPATHTOEF(sound,data\sound\VO\commander\capturedsilo5.ogg)]
        ]],
        ["silolost", createHashMapFromArray [
            [1, QPATHTOEF(sound,data\sound\VO\commander\lostsilo1.ogg)],
            [2, QPATHTOEF(sound,data\sound\VO\commander\lostsilo2.ogg)],
            [3, QPATHTOEF(sound,data\sound\VO\commander\lostsilo3.ogg)],
            [4, QPATHTOEF(sound,data\sound\VO\commander\lostsilo4.ogg)],
            [5, QPATHTOEF(sound,data\sound\VO\commander\lostsilo5.ogg)]
        ]],
        ["hullstatus", createHashMapFromArray [
            ["initial", createHashMapFromArray [
                ["path_friendly", QPATHTOEF(sound,data\sound\VO\commander\friendlycarrierinitialdamage.ogg)],
                ["path_enemy", QPATHTOEF(sound,data\sound\VO\commander\enemycarrierinitialdamage.ogg)],
                ["played", createHashMapFromArray [
                    [west, false],
                    [east, false]
                ]]
            ]],
            ["reactor", createHashMapFromArray [
                ["path_friendly", QPATHTOEF(sound,data\sound\VO\commander\friendlyreactorexposed.ogg)],
                ["path_enemy", QPATHTOEF(sound,data\sound\VO\commander\enemyreactorexposed.ogg)],
                ["played", createHashMapFromArray [
                    [west, false],
                    [east, false]
                ]]
            ]],
            [0.75, createHashMapFromArray [
                ["path_friendly", QPATHTOEF(sound,data\sound\VO\commander\friendlyhull75.ogg)],
                ["path_enemy", QPATHTOEF(sound,data\sound\VO\commander\enemyhull75.ogg)],
                ["played", createHashMapFromArray [
                    [west, false],
                    [east, false]
                ]]
            ]],
            [0.50, createHashMapFromArray [
                ["path_friendly", QPATHTOEF(sound,data\sound\VO\commander\friendlyhull50.ogg)],
                ["path_enemy", QPATHTOEF(sound,data\sound\VO\commander\enemyhull50.ogg)],
                ["played", createHashMapFromArray [
                    [west, false],
                    [east, false]
                ]]
            ]],
            [0.25, createHashMapFromArray [
                ["path_friendly", QPATHTOEF(sound,data\sound\VO\commander\friendlyhull25.ogg)],
                ["path_enemy", QPATHTOEF(sound,data\sound\VO\commander\enemyhull25.ogg)],
                ["played", createHashMapFromArray [
                    [west, false],
                    [east, false]
                ]]
            ]],
            [0, createHashMapFromArray [
                ["path_friendly", QPATHTOEF(sound,data\sound\VO\commander\friendlyhull0.ogg)],
                ["path_enemy", QPATHTOEF(sound,data\sound\VO\commander\enemyhull0.ogg)],
                ["played", createHashMapFromArray [
                    [west, false],
                    [east, false]
                ]]
            ]]
        ]]
    ]]
];

LOG("InitGame | Saving missionNamespace game data...");
{
    missionNamespace setVariable [format[QGVAR(%1),_x], _y, true]
} forEach _data;
LOG("InitGame | Data save complete...");
