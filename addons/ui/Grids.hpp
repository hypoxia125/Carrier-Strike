#include "\a3\ui_f\hpp\defineCommonGrids.inc"

#define pixelScale          0.5
#define GRID_X              safezoneX
#define GRID_Y              safezoneY
#define GRID_W              (pixelW * pixelGridNoUIScale * pixelScale)
#define GRID_H              (pixelH * pixelGridNoUIScale * pixelScale)
#define CENTER_X	        ((getResolution select 2) * pixelScale * pixelW)
#define CENTER_Y	        ((getResolution select 3) * pixelScale * pixelH)
