class SiloGrey_4: RscPictureKeepAspect {
    idc = IDC_SILO_GREY_4;

    x = QUOTE((SILO_CENTER + SILO_SPACE_X) * GRID_W);
    y = QUOTE(SILO_Y * GRID_H);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    onLoad = "uiNamespace setVariable ['carrierstrike_main_silogrey_4', _this select 0]";
    text = QPATHTOF(data\HUD\silos\SiloGrey_4.paa);
};