class CSAT_Antitank
{
    side = 0;
    tier = 1;
    displayName = "Anti Tank";
    icon = "";
    role = QGVAR(AntiTank);
    show = "true";
    uniformClass = "U_O_CombatUniform_ocamo";
    backpack = "B_FieldPack_cbr_LAT";
    weapons[] = {"arifle_Katiba_ACO_F", "launch_RPG32_F", "hgun_Rook40_F", "Throw", "Put"};
    magazines[] = {"30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "SmokeShell", "SmokeShellRed", "Chemlight_red", "Chemlight_red", "RPG32_F", "RPG32_F", "RPG32_HE_F", "RPG32_HE_F", "30Rnd_65x39_caseless_green", "RPG32_F", "16Rnd_9x21_Mag"};
    items[] = {"FirstAidKit"};
    linkedItems[] = {"V_TacVest_khk", "H_HelmetO_ocamo", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio", "NVGoggles_OPFOR", "optic_ACO_grn"};
};

class CSAT_Antitank_Urban
{
    side = 0;
    tier = 1;
    displayName = "Anti Tank (Urban)";
    icon = "";
    role = QGVAR(AntiTank);
    show = "true";
    uniformClass = "U_O_CombatUniform_oucamo";
    backpack = "B_FieldPack_oucamo_LAT";
    weapons[] = {"arifle_Katiba_ACO_pointer_F", "launch_RPG32_F", "hgun_Rook40_F", "Throw", "Put"};
    magazines[] = {"30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "SmokeShell", "SmokeShellRed", "Chemlight_red", "Chemlight_red", "RPG32_F", "RPG32_F", "RPG32_HE_F", "RPG32_HE_F", "30Rnd_65x39_caseless_green", "RPG32_F", "16Rnd_9x21_Mag"};
    items[] = {"FirstAidKit"};
    linkedItems[] = {"V_TacVest_blk", "H_HelmetO_oucamo", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio", "NVGoggles_OPFOR", "acc_pointer_IR", "optic_ACO_grn"};
};

class CSAT_Antitank_Pacific
{
    side = 0;
    tier = 1;
    displayName = "Anti Tank (Pacific)";
    icon = "";
    role = QGVAR(AntiTank);
    show = "true";
    uniformClass = "U_O_T_Soldier_F";
    backpack = "B_FieldPack_ghex_OTLAT_F";
    weapons[] = {"arifle_CTAR_blk_ACO_F", "launch_RPG32_ghex_F", "hgun_Rook40_F", "Throw", "Put"};
    magazines[] = {"30Rnd_580x42_Mag_F", "30Rnd_580x42_Mag_F", "30Rnd_580x42_Mag_F", "SmokeShell", "30Rnd_580x42_Mag_F", "30Rnd_580x42_Mag_F", "16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "SmokeShellRed", "Chemlight_red", "Chemlight_red", "RPG32_F", "RPG32_F", "RPG32_HE_F", "RPG32_HE_F", "30Rnd_580x42_Mag_F", "RPG32_F", "16Rnd_9x21_Mag"};
    items[] = {"FirstAidKit"};
    linkedItems[] = {"V_TacVest_oli", "H_HelmetO_ghex_F", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio", "O_NVGoggles_ghex_F", "optic_ACO_grn"};
};
