class SiloCD_1: RscText {
    idc = IDC_SILO_CD_1;

    x = QUOTE((SILO_CENTER - SILO_SPACE_X * 2) * GRID_W);
    y = QUOTE(SILO_CD_Y * GRID_H);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    onLoad = "uiNamespace setVariable ['carrierstrike_main_silo_cd_1', _this select 0]";

    style = ST_CENTER;
    text = "";
    sizeEx = QUOTE(GRID_W * 3.2);
    shadow = 2;
    colorText[] = {0,1,0,1};
};