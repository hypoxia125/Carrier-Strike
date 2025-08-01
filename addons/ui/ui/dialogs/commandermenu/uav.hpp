class UAV : RscButton
{
    idc = IDC_COMMANDERMENU_UAV;
    
    x = QUOTE(COMMANDERMENU_UAV_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_UAV_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_UAV_W * GRID_W);
    h = QUOTE(COMMANDERMENU_UAV_H * GRID_H);

    text = "UAV: WIP";
    colorBackgroundActive[] = USER_GUI_COLORS_ALPHA(0.5);
    colorBackground[] = {0,0,0,0.0};

    onButtonClick = QUOTE(call FUNC(CommanderMenu_OnClickUAV));
    onLoad = QUOTE(call FUNC(CommanderMenu_OnLoadUAV));
};
