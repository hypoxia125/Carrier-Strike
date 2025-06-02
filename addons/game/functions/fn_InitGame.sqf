#include "script_component.hpp"

if (!isServer) exitWith {};

private _data = createHashMapFromArray [
    //! All silos registered in the game
    ["silos", [/* silo object */]],

    //! All missiles registered in the game
    ["missiles", [/* missile projectile */]],

    //! Current enum state of the game
    //! States can be found in addons\main\script_mod.hpp
    ["game_state", -1],

    //! All reactors registered in the game
    ["reactors", [/* reactor object */]],

    //! Lists which team's reactors are allowed to take damage
    ["reactor_vulnerabilites", createHashMapFromArray [
        [west, false],
        [east, false]
    ]],

    //! All chat channels and related information
    ["chat_channels", createHashMapFromArray [
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
    ]],

    //! Missile targets for each side
    ["missile_targets", createHashMapFromArray [
        [west, objNull],
        [east, objNull]
    ]],

    //! Carriers registered to each side
    ["carriers", createHashMapFromArray [
        [west, objNull],
        [east, objNull]
    ]],

    //! All respawn position info
    ["respawn_positions", [/* [<respawnID, <respawnType>, <respawnArea>] */]],

    //! Contains which tiers of equipment are currently allowed
    ["unlocked_loadouts", createHashMapFromArray [
        [1, false],
        [2, false],
        [3, false]
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

{
    missionNamespace setVariable [format[QGVAR(%1),_x], _y, true]
} forEach _data;