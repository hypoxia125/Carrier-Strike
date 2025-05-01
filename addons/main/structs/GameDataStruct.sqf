CarrierStrike_Struct_GameData = createHashMapFromArray [
    ["all_silos", []],
    ["game_state", ""],

    ["chat_notification_channels", createHashMapFromArray [
        [west, -1],
        [east, -1],
        [independent, -1]
    ]],

    ["missile_targets", createHashMapFromArray [
        [west, objNull],
        [east, objNull]
    ]],

    ["carriers", createHashMapFromArray [
        [west, objNull],
        [east, objNull]
    ]],
    
    ["event_handles", createHashMapFromArray [
        ["silo_3dmarkers", -1]
    ]]
];