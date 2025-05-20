#include "Grids.hpp"

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

#define IDD_CARRIERHUD                      8000
#define IDC_UPPERHUD                        8001

#define IDC_CARRIER_BLUE_DARK               8002
#define IDC_CARRIER_BLUE_LIGHT_GROUP        8003
#define IDC_CARRIER_BLUE_LIGHT              8004
#define IDC_CARRIER_RED_DARK                8006
#define IDC_CARRIER_RED_LIGHT_GROUP         8007
#define IDC_CARRIER_RED_LIGHT               8008

#define IDC_SILO_GREY_1                     8010
#define IDC_SILO_RED_1_GROUP                8011
#define IDC_SILO_RED_1                      8012
#define IDC_SILO_BLUE_1_GROUP               8013
#define IDC_SILO_BLUE_1                     8014

#define IDC_SILO_GREY_2                     8020
#define IDC_SILO_RED_2_GROUP                8021
#define IDC_SILO_RED_2                      8022
#define IDC_SILO_BLUE_2_GROUP               8023
#define IDC_SILO_BLUE_2                     8024

#define IDC_SILO_GREY_3                     8030
#define IDC_SILO_RED_3_GROUP                8031
#define IDC_SILO_RED_3                      8032
#define IDC_SILO_BLUE_3_GROUP               8033
#define IDC_SILO_BLUE_3                     8034

#define IDC_SILO_GREY_4                     8040
#define IDC_SILO_RED_4_GROUP                8041
#define IDC_SILO_RED_4                      8042
#define IDC_SILO_BLUE_4_GROUP               8043
#define IDC_SILO_BLUE_4                     8044

#define IDC_SILO_GREY_5                     8050
#define IDC_SILO_RED_5_GROUP                8051
#define IDC_SILO_RED_5                      8052
#define IDC_SILO_BLUE_5_GROUP               8053
#define IDC_SILO_BLUE_5                     8054

#define IDC_SILO_CD_1                       8060
#define IDC_SILO_CD_2                       8061
#define IDC_SILO_CD_3                       8062
#define IDC_SILO_CD_4                       8063
#define IDC_SILO_CD_5                       8064