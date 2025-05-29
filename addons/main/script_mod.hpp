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

// Enums
#define GAME_STATE_PREINIT      0
#define GAME_STATE_INIT         1
#define GAME_STATE_POSTINIT     2
#define GAME_STATE_PLAYING      3
#define GAME_STATE_ENDING       4
#define GAME_STATE_ENDED        5