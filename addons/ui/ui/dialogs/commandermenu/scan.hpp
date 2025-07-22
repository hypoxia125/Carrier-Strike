class Scan : RscButton
{
    idc = IDC_COMMANDERMENU_SCAN;
    
    x = QUOTE(COMMANDERMENU_SCAN_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_SCAN_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_SCAN_W * GRID_W);
    h = QUOTE(COMMANDERMENU_SCAN_H * GRID_H);

    text = "SCAN";
    colorBackgroundActive[] = USER_GUI_COLORS_ALPHA(0.5);
    colorBackground[] = {0,0,0,0.0};

    onButtonClick = QUOTE(call FUNC(CommanderMenu_OnClickScan));
    onLoad = QUOTE(call FUNC(CommanderMenu_OnLoadScan));
};
