class Titlebar : RscText
{
    x = QUOTE(COMMANDERMENU_TITLEBAR_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_TITLEBAR_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_TITLEBAR_W * GRID_W);
    h = QUOTE(COMMANDERMENU_TITLEBAR_H * GRID_H);

    colorBackground[] = USER_GUI_COLORS;
    text = "Commander Menu";
    style = ST_CENTER;
};
