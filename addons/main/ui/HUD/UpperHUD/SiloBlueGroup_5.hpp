class SiloBlue_5_Group: RscControlsGroupNoScrollbars {
    idc = IDC_SILO_BLUE_5_GROUP;

    x = QUOTE((SILO_CENTER + SILO_SPACE_X * 2) * GRID_W);
    y = QUOTE(SILO_Y * GRID_H - SILO_H * GRID_H * -1);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    onLoad = "uiNamespace setVariable ['carrierstrike_main_siloblue_5_group', _this select 0]";

    class controls {
        class SiloBlue_5: RscPictureKeepAspect {
            idc = IDC_SILO_BLUE_5;

            x = QUOTE(0 * GRID_W);
            y = QUOTE(SILO_H * GRID_H * -1);
            w = QUOTE(SILO_W * GRID_W);
            h = QUOTE(SILO_H * GRID_H);

            onLoad = "uiNamespace setVariable ['carrierstrike_main_siloblue_5', _this select 0]";
            text = QPATHTOF(data\HUD\silos\SiloBlue_5.paa);
        };
    };
};