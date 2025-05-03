CarrierStrike_Struct_CarrierData = createHashMapFromArray [
    ["side", sideUnknown],
    ["max_hp", CarrierStrike_GameSettings get "Carriers" get "MaxHP"],
    ["reactor_hp", CarrierStrike_GameSettings get "Carriers" get "ReactorHP"],
    ["allow_automated_defenses", CarrierStrike_GameSettings get "Carriers" get "AllowAutomatedDefenses"],
    ["reactors", []],

    ["composition", createHashMapFromArray [
        ["missile_target", [24.9297,66.3911,0]],
        ["turret_class", "B_AAA_System_01_F"],
        ["turret_0", [[47.6841,-0.00439453,18.0834],90.747]],
        ["turret_1", [[25.5493,-114.821,16.6596],89.509]],
        ["turret_2", [[-30.1289,-105.404,17.5575],-89.4105]],
        ["turret_3", [[-39.8408,179.097,19.9095],-42.0321]],
        ["turret_4", [[30.917,175.103,19.6474],60.836]],
        ["turret_5", [[-16.8071,188.767,11.2129],-0.331001]],
        ["explosions", [
            [-35.1406,163.192,23.4817],
            [-1.58936,173.036,23.59],
            [32.2993,151.088,23.5145],
            [-8.19434,30.502,23.5511],
            [-16.2852,130.631,23.5373],
            [-22.3359,5.81689,23.4596],
            [34.1396,74.8433,23.5628],
            [-15.9707,-81.1201,23.5184],
            [19.8208,-40.1528,23.4595],
            [-30.6777,62.7466,23.4832],
            [1.66064,-151.622,23.6522],
            [-27.4341,-39.2256,23.5044],
            [24.6304,11.7412,23.508],
            [7.12061,117.999,23.5175]
        ]],
        ["alarms", [
            [-22.627,111.096,28.4444],
            [45.0649,40.417,24.8704],
            [-34.6914,-81.4736,35.4021]
        ]],
        ["carrier_parts", [
            "Land_Carrier_01_hull_01_F",
            "Land_Carrier_01_hull_02_F",
            "Land_Carrier_01_hull_03_F",
            "Land_Carrier_01_hull_04_F",
            "Land_Carrier_01_hull_05_F",
            "Land_Carrier_01_hull_06_F",
            "Land_Carrier_01_hull_07_F",
            "Land_Carrier_01_hull_08_F",
            "Land_Carrier_01_hull_09_F",
            "Land_Carrier_01_island_01_F",
            "Land_Carrier_01_island_02_F",
            "Land_Carrier_01_island_03_F"
        ]],
        ["camera", [75.4604,282.184,111.056]]
    ]]
];