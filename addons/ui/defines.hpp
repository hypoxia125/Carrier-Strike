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

//////////////////////////////////////////////////////////////////////////////////////////////////

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