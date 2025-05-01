class CfgPatches {
    class ADDON {
        name = "Carrier Strike - Missions";
        authors[] = {
            "Hypoxic"
        };
        url = "https://github.com/hypoxia125/Carrier-Strike";
        is3DENMod = 0;

        requiredVersion = 2.16;
        requiredAddons[] = {
            "A3_Functions_F",
            "cba_main",
            "carrierstrike_main",
            "carrierstrike_common",
            "carrierstrike_game"
        };
        units[] = {};
        weapons[] = {};

        skipWhenMissingDependencies = 1;
    };
};
