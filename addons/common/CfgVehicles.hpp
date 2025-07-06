class CfgVehicles {
    class B_Soldier_F;

    class CarrierStrike_AISoldier: B_Soldier_F {
        displayName = "AI Soldier";
        respawnItems[] = {};
        respawnLinkedItems[] = {};
        respawnMagazines[] = {};
        respawnWeapons[] = {};
        weapons[] = { "Throw", "Put" };
        linkedItems[] = {};
        magazines[] = {};
        uniform = "";
        backpack = "";
    };

    class I_APC_tracked_03_cannon_F;
    class CarrierStrike_O_APC_tracked_03_cannon_F: I_APC_tracked_03_cannon_F {
        displayName = "FV-720 Mora (CSAT)";
        faction = "OPF_F";
        hiddenSelectionsTextures[] = {
            "\z\carrierstrike\addons\common\data\textures\I_APC_tracked_03_cannon_F\apc_tracked_03_ext_opfor_co.paa",
            "\z\carrierstrike\addons\common\data\textures\I_APC_tracked_03_cannon_F\apc_tracked_03_ext2_opfor_co.paa",
            "\z\carrierstrike\addons\common\data\textures\camonet_CSAT_CO.paa",
            "\z\carrierstrike\addons\common\data\textures\cage_csat_co.paa"
        };
        side = 0;
        typicalCargo[] = {"O_Soldier_F"};
    };

    class B_Heli_Light_01_F;
    class CarrierStrike_O_Heli_Light_01_F: B_Heli_Light_01_F {
        displayName = "MH-9 Hummingbird (CSAT)";
        faction = "OPF_F";
        hiddenSelectionsTextures[] = {
            "\z\carrierstrike\addons\common\data\textures\B_Heli_Light_01_F\Heli_Light_01_ext_Opfor_CO.paa"
        };
        side = 0;
        typicalCargo[] = {"O_HeliPilot_F"};
    };
};
