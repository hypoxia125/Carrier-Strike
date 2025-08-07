class Artillery : RscButton
{
    idc = IDC_COMMANDERMENU_ARTILLERY;
    
    x = QUOTE(COMMANDERMENU_ARTILLERY_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_ARTILLERY_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_ARTILLERY_W * GRID_W);
    h = QUOTE(COMMANDERMENU_ARTILLERY_H * GRID_H);

    text = CSTRING(Artillery);
    colorBackgroundActive[] = USER_GUI_COLORS_ALPHA(0.5);
    colorBackground[] = {0,0,0,0.0};

    onButtonClick = QUOTE(call FUNC(CommanderMenu_OnClickArtillery));
    onLoad = QUOTE(call FUNC(CommanderMenu_OnLoadArtillery));
};
