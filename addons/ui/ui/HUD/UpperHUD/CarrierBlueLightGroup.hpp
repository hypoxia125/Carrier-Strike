class Carrier_Blue_Light_Group: RscControlsGroupNoScrollbars {
    idc = IDC_CARRIER_BLUE_LIGHT_GROUP;

    x = QUOTE(CARRIER_LEFT * GRID_W);
    y = QUOTE(CARRIER_Y * GRID_H);
    w = QUOTE(CARRIER_W * GRID_W);
    h = QUOTE(CARRIER_H * GRID_H);

    class controls {
        class Carrier_Blue_Light: RscPictureKeepAspect {
            idc = IDC_CARRIER_BLUE_LIGHT;

            x = QUOTE(0 * GRID_W);
            y = QUOTE(0 * GRID_H);
            w = QUOTE(CARRIER_W * GRID_W);
            h = QUOTE(CARRIER_H * GRID_H);

            text = QPATHTOF(data\HUD\carriers\CarrierBlueLight.paa);
        };
    };
};