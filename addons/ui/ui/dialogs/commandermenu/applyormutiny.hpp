class ApplyOrMutiny : RscButton
{
    idc = IDC_COMMANDERMENU_APPLYIORMUTINY;

    x = QUOTE(COMMANDERMENU_APPLY_X * GRID_W + CENTER_X);
    y = QUOTE(COMMANDERMENU_APPLY_Y * GRID_H + CENTER_Y);
    w = QUOTE(COMMANDERMENU_APPLY_W * GRID_W);
    h = QUOTE(COMMANDERMENU_APPLY_H * GRID_H);

    text = "APPLY | MUTINY";
    colorBackgroundActive[] = USER_GUI_COLORS_ALPHA(0.5);
    colorBackground[] = {0,0,0,0.0};

    onButtonClick = QUOTE(call FUNC(CommanderMenu_OnClickApply));
};
