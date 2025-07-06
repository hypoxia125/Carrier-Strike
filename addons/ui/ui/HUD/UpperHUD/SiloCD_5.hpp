class SiloCD_5: RscText {
    idc = IDC_SILO_CD_5;

    x = QUOTE((SILO_CENTER + SILO_SPACE_X * 2) * GRID_W);
    y = QUOTE(SILO_CD_Y * GRID_H);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    style = ST_CENTER;
    text = "";
    sizeEx = QUOTE(GRID_W * 3.2);
    shadow = 2;
    colorText[] = {0,1,0,1};
};
