#define USER_GUI_COLORS {\
    QUOTE(profileNamespace getVariable [ARR_2('GUI_BCG_RGB_R',0.77)]),\
    QUOTE(profileNamespace getVariable [ARR_2('GUI_BCG_RGB_G',0.51)]),\
    QUOTE(profileNamespace getVariable [ARR_2('GUI_BCG_RGB_B',0.08)])\
}

#define USER_GUI_COLORS_ALPHA(ALPHA) {\
    QUOTE(profileNamespace getVariable [ARR_2('GUI_BCG_RGB_R',0.77)]),\
    QUOTE(profileNamespace getVariable [ARR_2('GUI_BCG_RGB_G',0.51)]),\
    QUOTE(profileNamespace getVariable [ARR_2('GUI_BCG_RGB_B',0.08)]),\
    ALPHA\
}

//--------------------------------------------------------------------------------------------------

#define IDD_CARRIERHUD                  8000

#define IDC_UPPERHUD                    8001

#define IDC_CARRIER_BLUE_DARK           8010
#define IDC_CARRIER_BLUE_LIGHT_GROUP    IDC_CARRIER_BLUE_DARK + 1
#define IDC_CARRIER_BLUE_LIGHT          IDC_CARRIER_BLUE_DARK + 2
#define IDC_CARRIER_RED_DARK            IDC_CARRIER_BLUE_DARK + 3
#define IDC_CARRIER_RED_LIGHT_GROUP     IDC_CARRIER_BLUE_DARK + 4
#define IDC_CARRIER_RED_LIGHT           IDC_CARRIER_BLUE_DARK + 5

#define IDC_SILO_GREY_1                 8020
#define IDC_SILO_RED_1_GROUP            IDC_SILO_GREY_1 + 1
#define IDC_SILO_RED_1                  IDC_SILO_GREY_1 + 2
#define IDC_SILO_BLUE_1_GROUP           IDC_SILO_GREY_1 + 3
#define IDC_SILO_BLUE_1                 IDC_SILO_GREY_1 + 4

#define IDC_SILO_GREY_2                 8030
#define IDC_SILO_RED_2_GROUP            IDC_SILO_GREY_2 + 1
#define IDC_SILO_RED_2                  IDC_SILO_GREY_2 + 2
#define IDC_SILO_BLUE_2_GROUP           IDC_SILO_GREY_2 + 3
#define IDC_SILO_BLUE_2                 IDC_SILO_GREY_2 + 4

#define IDC_SILO_GREY_3                 8040
#define IDC_SILO_RED_3_GROUP            IDC_SILO_GREY_3 + 1
#define IDC_SILO_RED_3                  IDC_SILO_GREY_3 + 2
#define IDC_SILO_BLUE_3_GROUP           IDC_SILO_GREY_3 + 3
#define IDC_SILO_BLUE_3                 IDC_SILO_GREY_3 + 4

#define IDC_SILO_GREY_4                 8050
#define IDC_SILO_RED_4_GROUP            IDC_SILO_GREY_4 + 1
#define IDC_SILO_RED_4                  IDC_SILO_GREY_4 + 2
#define IDC_SILO_BLUE_4_GROUP           IDC_SILO_GREY_4 + 3
#define IDC_SILO_BLUE_4                 IDC_SILO_GREY_4 + 4

#define IDC_SILO_GREY_5                 8060
#define IDC_SILO_RED_5_GROUP            IDC_SILO_GREY_5 + 1
#define IDC_SILO_RED_5                  IDC_SILO_GREY_5 + 2
#define IDC_SILO_BLUE_5_GROUP           IDC_SILO_GREY_5 + 3
#define IDC_SILO_BLUE_5                 IDC_SILO_GREY_5 + 4

#define IDC_SILO_CD_1                   8070
#define IDC_SILO_CD_2                   IDC_SILO_CD_1 + 1
#define IDC_SILO_CD_3                   IDC_SILO_CD_1 + 2
#define IDC_SILO_CD_4                   IDC_SILO_CD_1 + 3
#define IDC_SILO_CD_5                   IDC_SILO_CD_1 + 4

#define IDC_COMMANDER_WEST              8080
#define IDC_COMMANDER_EAST              8081

//--------------------------------------------------------------------------------------------------

#define UPPERHUD_W                          75
#define UPPERHUD_X                          -(UPPERHUD_W / 2)
#define UPPERHUD_Y                          3
#define UPPERHUD_H                          10

#define CARRIER_W                           22
#define CARRIER_H                           (CARRIER_W / 2)
#define CARRIER_Y                           -2
#define CARRIER_RIGHT                       (UPPERHUD_W - CARRIER_W)
#define CARRIER_LEFT                        (UPPERHUD_X - UPPERHUD_X)

#define SILO_Y                              1
#define SILO_W                              5
#define SILO_H                              5
#define SILO_SPACE_X                        6
#define SILO_CENTER                         (UPPERHUD_W / 2 - SILO_W / 2)
#define SILO_CD_Y                           (SILO_H)

#define RESPAWNMENU_MAINPANEL_W              180
#define RESPAWNMENU_MAINPANEL_H             100
#define RESPAWNMENU_MAINPANEL_X              -(RESPAWNMENU_MAINPANEL_W / 2)
#define RESPAWNMENU_MAINPANEL_Y              -(RESPAWNMENU_MAINPANEL_H / 2)

#define COMMANDERNAME_WEST_Y                (CARRIER_Y + 4)
#define COMMANDERNAME_EAST_Y                (CARRIER_Y + 4)

//--------------------------------------------------------------------------------------------------

#define IDD_COMMANDERMENU                    9000

#define IDC_COMMANDERMENU_CURRENTCOMMANDER  (IDD_COMMANDERMENU + 1)
#define IDC_COMMANDERMENU_SCAN              (IDD_COMMANDERMENU + 2)
#define IDC_COMMANDERMENU_UAV               (IDD_COMMANDERMENU + 3)
#define IDC_COMMANDERMENU_ARTILLERY         (IDD_COMMANDERMENU + 4)
#define IDC_COMMANDERMENU_APPLYIORMUTINY    (IDD_COMMANDERMENU + 5)
#define IDC_COMMANDERMENU_BACKGROUND        (IDD_COMMANDERMENU + 6)
#define IDC_COMMANDERMENU_BORDERS           (IDD_COMMANDERMENU + 7)

#define COMMANDERMENU_W                     75/2
#define COMMANDERMENU_X                     -(COMMANDERMENU_W / 2)
#define COMMANDERMENU_Y                     -(COMMANDERMENU_H / 2)
#define COMMANDERMENU_H                     40

#define COMMANDERMENU_TITLEBAR_W            COMMANDERMENU_W
#define COMMANDERMENU_TITLEBAR_X            (COMMANDERMENU_X)
#define COMMANDERMENU_TITLEBAR_Y            (COMMANDERMENU_Y - 2)
#define COMMANDERMENU_TITLEBAR_H            2

#define COMMANDERMENU_CURRENTCOMMANDER_W    (COMMANDERMENU_W - 4)
#define COMMANDERMENU_CURRENTCOMMANDER_X    (COMMANDERMENU_X + 2)
#define COMMANDERMENU_CURRENTCOMMANDER_Y    (COMMANDERMENU_Y + 2)
#define COMMANDERMENU_CURRENTCOMMANDER_H    4

#define COMMANDERMENU_APPLY_W               (COMMANDERMENU_W - 4)
#define COMMANDERMENU_APPLY_X               (COMMANDERMENU_X + 2)
#define COMMANDERMENU_APPLY_Y               (COMMANDERMENU_Y + 8)
#define COMMANDERMENU_APPLY_H               4

#define COMMANDERMENU_SCAN_W                (COMMANDERMENU_W - 4)
#define COMMANDERMENU_SCAN_X                (COMMANDERMENU_X + 2)
#define COMMANDERMENU_SCAN_Y                (COMMANDERMENU_Y + 14)
#define COMMANDERMENU_SCAN_H                4

#define COMMANDERMENU_UAV_W                 (COMMANDERMENU_W - 4)
#define COMMANDERMENU_UAV_X                 (COMMANDERMENU_X + 2)
#define COMMANDERMENU_UAV_Y                 (COMMANDERMENU_Y + 20)
#define COMMANDERMENU_UAV_H                 4

#define COMMANDERMENU_ARTILLERY_W           (COMMANDERMENU_W - 4)
#define COMMANDERMENU_ARTILLERY_X           (COMMANDERMENU_X + 2)
#define COMMANDERMENU_ARTILLERY_Y           (COMMANDERMENU_Y + 26)
#define COMMANDERMENU_ARTILLERY_H           4
