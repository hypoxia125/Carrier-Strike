class CommanderWest: RscText {
    idc = IDC_COMMANDER_WEST;

    x = QUOTE(CARRIER_LEFT * GRID_W);
    y = QUOTE(COMMANDERNAME_WEST_Y * GRID_H);
    w = QUOTE(CARRIER_W * GRID_W);
    h = QUOTE(CARRIER_H * GRID_H);

    text = "NO COMMANDER";
    style = ST_LEFT;
};

class CommanderEast: RscText {
    idc = IDC_COMMANDER_EAST;

    x = QUOTE(CARRIER_RIGHT * GRID_W);
    y = QUOTE(COMMANDERNAME_EAST_Y * GRID_H);
    w = QUOTE(CARRIER_W * GRID_W);
    h = QUOTE(CARRIER_H * GRID_H);

    text = "NO COMMANDER";
    style = ST_RIGHT;
};
