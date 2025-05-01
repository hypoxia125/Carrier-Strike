/*
// DO NOT REFERENCE!
// MAKE A COPY!
// IF CHANGES TO THIS HAPPEN, IT WILL FUCK UP THE GAME INSTANCE

// WRONG private _myWrongCopy = CarrierStrike_Structs_SiloData;
// CORRECT: private _myCopy = +CarrierStrike_Structs_SiloData;
*/

CarrierStrike_Struct_SiloData = createHashMapFromArray [
    ["side", sideUnknown],
    ["lights", []],
    ["silo_number", -1],
    ["crew_group", grpNull],

    ["composition", createHashMapFromArray [
        ["light_neutral", "PortableHelipadLight_01_yellow_F"],
        ["light_west", "PortableHelipadLight_01_blue_F"],
        ["light_east", "PortableHelipadLight_01_red_F"],
        ["light_independent", "PortableHelipadLight_01_green_F"],
        ["light_civilian", "Land_PortableHelipadLight_01_F"],
        ["platform", "BlockConcrete_F"],
        ["light_r", [4.08691,2.9585,-1.1]],
        ["light_l", [-4.16309,2.93945,-1.1]],
        ["platform_rear", [0.0258789,-1.08105,-3.34349]],
        ["platform_front", [0.0263672,0.800293,-3.34282]]
    ]],

    // launch system variables
    ["countdown_time", CarrierStrike_GameSettings get "Silos" get "MissileLaunchCooldown"],
    ["countdown", CarrierStrike_GameSettings get "Silos" get "MissileLaunchCooldown"],
    ["is_firing", false],

    // alerts
    ["alerts", createHashMapFromArray [
        ["120s", "data\sound\VO\betty\missilelaunchcountdown_120s.ogg"],
        ["60s", "data\sound\VO\betty\missilelaunchcountdown_60s.ogg"],
        ["30s", "data\sound\VO\betty\missilelaunchcountdown_30s.ogg"],
        ["5s", "data\sound\VO\betty\missilelaunchcountdown_5s.ogg"]
    ]],

    // event handles
    ["event_handles", createHashMapFromArray [
    ]]
];