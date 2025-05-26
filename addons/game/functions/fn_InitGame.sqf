#include "script_component.hpp"

if (!isServer) exitWith {};

GVAR(Game) = true call CBA_fnc_CreateNamespace;
publicVariable QGVAR(Game);

private _data = createHashMapFromArray [
    ["silos", []],
    ["missiles", []],
    ["game_state", ""],
    ["reactors", []],
    ["reactor_vulnerabilities", createHashMapFromArray [
        [west, false],
        [east, false]
    ]],

    ["chatHeadquarterLogic", createHashMapFromArray [
        [west, objNull],
        [east, objNull],
        [independent, objNull]
    ]],
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
    ["alert_vars", createHashMapFromArray [
        [west, createHashMapFromArray [
            ["initial", false],
            ["reactor", false],
            [0.75, false],
            [0.50, false],
            [0.25, false],
            [0.15, false]
        ]],
        [east, createHashMapFromArray [
            ["initial", false],
            ["reactor", false],
            [0.75, false],
            [0.50, false],
            [0.25, false],
            [0.15, false]
        ]]
    ]],
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
        ["friendlyhull", createHashMapFromArray [
            ["initial", QPATHTOEF(sound,data\sound\VO\commander\friendlycarrierinitialdamage.ogg)],
            ["reactor", QPATHTOEF(sound,data\sound\VO\commander\friendlyreactorexposed.ogg)],
            [0.75, QPATHTOEF(sound,data\sound\VO\commander\friendlyhull75.ogg)],
            [0.50, QPATHTOEF(sound,data\sound\VO\commander\friendlyhull50.ogg)],
            [0.25, QPATHTOEF(sound,data\sound\VO\commander\friendlyhull25.ogg)],
            [0.15, QPATHTOEF(sound,data\sound\VO\commander\friendlyhull15.ogg)],
            [0.0, QPATHTOEF(sound,data\sound\VO\commander\friendlyhull0.ogg)]
        ]],
        ["enemyhull", createHashMapFromArray [
            //["initial", QPATHTOEF(sound,data\sound\VO\commander\enemycarrierinitialdamage.ogg)],
            ["reactor", QPATHTOEF(sound,data\sound\VO\commander\enemyreactorexposed.ogg)],
            [0.75, QPATHTOEF(sound,data\sound\VO\commander\enemyhull75.ogg)],
            [0.50, QPATHTOEF(sound,data\sound\VO\commander\enemyhull50.ogg)],
            [0.25, QPATHTOEF(sound,data\sound\VO\commander\enemyhull25.ogg)],
            [0.15, QPATHTOEF(sound,data\sound\VO\commander\enemyhull15.ogg)],
            [0.0, QPATHTOEF(sound,data\sound\VO\commander\enemyhull0.ogg)]
        ]]
    ]],

    ["respawn_positions", []],
    
    ["unlocked_loadouts", createHashMapFromArray [
        [1, false],
        [2, false],
        [3, false]
    ]]
];

{
    GVAR(Game) setVariable [format[QGVAR(%1),_x], _y, true]
} forEach _data;