#define MAINPREFIX z
#define PREFIX carrierstrike

#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

// #define DISABLE_COMPILE_CACHE

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fn,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fn,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

// Remote String Send for Localization
#define RSTRING(var1)           TRIPLES(STR,ADDON,var1)
#define ERSTRING(var1,var2)     TRIPLES(STR,DOUBLES(PREFIX,var1),var2)

// Enums
#define GAME_STATE_PREINIT      0
#define GAME_STATE_INIT         1
#define GAME_STATE_POSTINIT     2
#define GAME_STATE_PLAYING      3
#define GAME_STATE_ENDING       4
#define GAME_STATE_ENDED        5

#define AI_PERSONALITY_NEUTRAL      0
#define AI_PERSONALITY_OFFENSIVE    1
#define AI_PERSONALITY_DEFENSIVE    2
#define AI_PERSONALITY_CHAOTIC      3

// weapon types
#define TYPE_WEAPON_PRIMARY 1
#define TYPE_WEAPON_HANDGUN 2
#define TYPE_WEAPON_SECONDARY 4
// magazine types
#define TYPE_MAGAZINE_HANDGUN_AND_GL 16 // mainly
#define TYPE_MAGAZINE_PRIMARY_AND_THROW 256
#define TYPE_MAGAZINE_SECONDARY_AND_PUT 512 // mainly
#define TYPE_MAGAZINE_MISSILE 768
// more types
#define TYPE_BINOCULAR_AND_NVG 4096
#define TYPE_WEAPON_VEHICLE 65536
#define TYPE_ITEM 131072
// item types
#define TYPE_DEFAULT 0
#define TYPE_MUZZLE 101
#define TYPE_OPTICS 201
#define TYPE_FLASHLIGHT 301
#define TYPE_BIPOD 302
#define TYPE_FIRST_AID_KIT 401
#define TYPE_FINS 501 // not implemented
#define TYPE_BREATHING_BOMB 601 // not implemented
#define TYPE_NVG 602
#define TYPE_GOGGLE 603
#define TYPE_SCUBA 604 // not implemented
#define TYPE_HEADGEAR 605
#define TYPE_FACTOR 607
#define TYPE_MAP 608
#define TYPE_COMPASS 609
#define TYPE_WATCH 610
#define TYPE_RADIO 611
#define TYPE_GPS 612
#define TYPE_HMD 616
#define TYPE_BINOCULAR 617
#define TYPE_MEDIKIT 619
#define TYPE_TOOLKIT 620
#define TYPE_UAV_TERMINAL 621
#define TYPE_VEST 701
#define TYPE_UNIFORM 801
#define TYPE_BACKPACK 901