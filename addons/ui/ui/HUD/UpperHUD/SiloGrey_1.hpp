class SiloGrey_1: RscPictureKeepAspect {
    idc = IDC_SILO_GREY_1;

    x = QUOTE((SILO_CENTER - SILO_SPACE_X * 2) * GRID_W);
    y = QUOTE(SILO_Y * GRID_H);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    text = QPATHTOF(data\HUD\silos\SiloGrey_1.paa);
};