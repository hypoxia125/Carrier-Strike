class SiloRed_4_Group: RscControlsGroupNoScrollbars {
    idc = IDC_SILO_RED_4_GROUP;

    x = QUOTE((SILO_CENTER + SILO_SPACE_X) * GRID_W);
    y = QUOTE(SILO_Y * GRID_H - SILO_H * GRID_H * -1);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    class controls {
        class SiloRed_4: RscPictureKeepAspect {
            idc = IDC_SILO_RED_4;

            x = QUOTE(0 * GRID_W);
            y = QUOTE(SILO_H * GRID_H * -1);
            w = QUOTE(SILO_W * GRID_W);
            h = QUOTE(SILO_H * GRID_H);

            text = QPATHTOF(data\HUD\silos\SiloRed_4.paa);
        };
    };
};