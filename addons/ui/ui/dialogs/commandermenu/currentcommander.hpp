class CurrentCommander : RscText
{
    idc = IDC_COMMANDERMENU_CURRENTCOMMANDER;

    x = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_W * GRID_W);
    h = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_H * GRID_H);

    text = CSTRING(NoCommander);
    type = CT_STRUCTURED_TEXT;
    colorBackground[] = {1,0,0,0};
    size = QUOTE(2 * GRID_H);

    class Attributes
    {
        align = "center";
        size = QUOTE(2 * GRID_H);
    };

    onLoad = QUOTE(call FUNC(CommanderMenu_OnLoadCommander));
};

class CurrrentCommander_Frame : RscFrame
{
    x = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_W * GRID_W);
    h = QUOTE(COMMANDERMENU_CURRENTCOMMANDER_H * GRID_H);

    colorText[] = USER_GUI_COLORS;
};
