#include "script_component.hpp"

params ["_player"];

if (!local _player) exitWith {};

// Parachute action
_player addAction [
    "Open Parachute",
    {
        params ["_target", "_caller", "_actionID", "_arguments"];

        private _pos = getPosASL _caller;
        private _parachute = createVehicle ["Steerable_Parachute_F", [0,0,0]];
        _parachute setPosASL _pos;
        _parachute setDir (getDir _caller);
        _caller moveInAny _parachute;
    },
    nil, 0, false, true, "",
    toString {
        isNull objectParent _this && {
            (getPos _this) # 2 >= 5
        }
    }, -1, false, "", ""
];

// Eject action
_player addAction [
    "Eject",
    {
        params ["_target", "_caller", "_actionID", "_arguments"];

        _target moveOut vehicle _target;
    },
    nil, 0, false, true, "",
    toString {
        !isNull objectParent _this && {
            (getPos _this) # 2 >= 10
        }
    }, -1, false, "", ""
];

// Rally Point Creation
_player addAction [
    "Place Rally Point",
    {
        params ["_target", "_caller", "_actionID", "_arguments"];

        [QGVAR(RallyPointCreate), [_caller]] call CBA_fnc_serverEvent;
    },
    nil, 0, false, true, "",
    toString {
        isNull objectParent _this &&
        leader _this isEqualTo _this &&
        (group _this) getVariable [QGVAR(RallyPoint_CanCreate), false]
    }, -1, false, "", ""
];
