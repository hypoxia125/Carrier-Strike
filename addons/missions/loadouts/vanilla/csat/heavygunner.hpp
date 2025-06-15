class CSAT_HeavyGunner
{
    side = 0;
    tier = 3;
    displayName = "Heavy Gunner";
    icon = "";
    role = QGVAR(HeavyGunner);
    show = "true";
    uniformClass = "U_O_CombatUniform_ocamo";
    backpack = "";
    weapons[] = {"MMG_01_hex_ARCO_LP_F", "hgun_Rook40_F", "Throw", "Put"};
    magazines[] = {"16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "SmokeShell", "SmokeShellRed", "Chemlight_red", "Chemlight_red", "150Rnd_93x64_Mag", "150Rnd_93x64_Mag", "150Rnd_93x64_Mag", "16Rnd_9x21_Mag"};
    items[] = {"FirstAidKit"};
    linkedItems[] = {"V_HarnessO_brn", "H_HelmetO_ocamo", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio", "NVGoggles_OPFOR", "acc_pointer_IR", "optic_Arco", "bipod_02_F_hex"};
};

class CSAT_HeavyGunner_Urban
{
    side = 0;
    tier = 3;
    displayName = "Heavy Gunner (Urban)";
    icon = "";
    role = QGVAR(HeavyGunner);
    show = "true";
    uniformClass = "U_O_CombatUniform_oucamo";
    backpack = "";
    weapons[] = {"MMG_01_hex_ARCO_LP_F", "hgun_Rook40_F", "Throw", "Put"};
    magazines[] = {"16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "SmokeShell", "SmokeShellRed", "Chemlight_red", "Chemlight_red", "150Rnd_93x64_Mag", "150Rnd_93x64_Mag", "150Rnd_93x64_Mag", "16Rnd_9x21_Mag"};
    items[] = {"FirstAidKit"};
    linkedItems[] = {"V_HarnessO_gry", "H_HelmetO_oucamo", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio", "NVGoggles_OPFOR", "acc_pointer_IR", "optic_Arco", "bipod_02_F_hex"};
};
