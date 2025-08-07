#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

call EFUNC(game,CommanderScan);

closeDialog 1;
openMap false;
