class Carrier_Red_Dark: RscPictureKeepAspect {
    idc = IDC_CARRIER_RED_DARK;

    x = QUOTE(CARRIER_RIGHT * GRID_W);
    y = QUOTE(CARRIER_Y * GRID_H);
    w = QUOTE(CARRIER_W * GRID_W);
    h = QUOTE(CARRIER_H * GRID_H);

    onLoad = "uiNamespace setVariable ['carrierstrike_main_carrier_red_dark', _this select 0]";
    text = QPATHTOF(data\HUD\carriers\CarrierRedDark.paa);
};