class Carrier_Blue_Dark: RscPictureKeepAspect {
    idc = IDC_CARRIER_BLUE_DARK;

    x = QUOTE(CARRIER_LEFT * GRID_W);
    y = QUOTE(CARRIER_Y * GRID_H);
    w = QUOTE(CARRIER_W * GRID_W);
    h = QUOTE(CARRIER_H * GRID_H);

    onLoad = "uiNamespace setVariable ['carrierstrike_main_carrier_blue_dark', _this select 0]";
    text = QPATHTOF(data\HUD\carriers\CarrierBlueDark.paa);
};