class SiloBlue_1_Group: RscControlsGroupNoScrollbars {
    idc = IDC_SILO_BLUE_1_GROUP;

    x = QUOTE((SILO_CENTER - SILO_SPACE_X * 2) * GRID_W);
    y = QUOTE(SILO_Y * GRID_H - SILO_H * GRID_H * -1);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    class controls {
        class SiloBlue_1: RscPictureKeepAspect {
            idc = IDC_SILO_BLUE_1;

            x = QUOTE(0 * GRID_W);
            y = QUOTE(SILO_H * GRID_H * -1);
            w = QUOTE(SILO_W * GRID_W);
            h = QUOTE(SILO_H * GRID_H);

            text = QPATHTOF(data\HUD\silos\SiloBlue_1.paa);
        };
    };
};