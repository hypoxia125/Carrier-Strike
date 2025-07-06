class SiloCD_3: RscText {
    idc = IDC_SILO_CD_3;

    x = QUOTE(SILO_CENTER * GRID_W);
    y = QUOTE(SILO_CD_Y * GRID_H);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    style = ST_CENTER;
    text = "";
    sizeEx = QUOTE(GRID_W * 3.2);
    shadow = 2;
    colorText[] = {0,1,0,1};
};
