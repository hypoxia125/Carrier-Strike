class Carrier_Red_Light_Group: RscControlsGroupNoScrollbars {
    idc = IDC_CARRIER_RED_LIGHT_GROUP;

    x = QUOTE(CARRIER_RIGHT * GRID_W);
    y = QUOTE(CARRIER_Y * GRID_H);
    w = QUOTE(CARRIER_W * GRID_W);
    h = QUOTE(CARRIER_H * GRID_H);

    class controls {
        class Carrier_Red_Light: RscPictureKeepAspect {
            idc = IDC_CARRIER_RED_LIGHT;

            x = QUOTE(0 * GRID_W);
            y = QUOTE(0 * GRID_H);
            w = QUOTE(CARRIER_W * GRID_W);
            h = QUOTE(CARRIER_H * GRID_H);

            text = QPATHTOF(data\HUD\carriers\CarrierRedLight.paa);
        };
    };
};