class SiloBlue_4_Group: RscControlsGroupNoScrollbars {
    idc = IDC_SILO_BLUE_4_GROUP;

    x = QUOTE((SILO_CENTER + SILO_SPACE_X) * GRID_W);
    y = QUOTE(SILO_Y * GRID_H - SILO_H * GRID_H * -1);
    w = QUOTE(SILO_W * GRID_W);
    h = QUOTE(SILO_H * GRID_H);

    onLoad = "uiNamespace setVariable ['carrierstrike_main_siloblue_4_group', _this select 0]";

    class controls {
        class SiloBlue_4: RscPictureKeepAspect {
            idc = IDC_SILO_BLUE_4;

            x = QUOTE(0 * GRID_W);
            y = QUOTE(SILO_H * GRID_H * -1);
            w = QUOTE(SILO_W * GRID_W);
            h = QUOTE(SILO_H * GRID_H);

            onLoad = "uiNamespace setVariable ['carrierstrike_main_siloblue_4', _this select 0]";
            text = QPATHTOF(data\HUD\silos\SiloBlue_4.paa);
        };
    };
};