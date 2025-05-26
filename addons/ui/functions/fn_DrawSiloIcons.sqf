#include "script_component.hpp"

if (!hasInterface) exitWith {};
if (!canSuspend) exitWith { _this spawn FUNC(DrawSiloIcons) };

waitUntil {
    !isNull findDisplay 46 &&
    !isNull (findDisplay 12 displayCtrl 51)
};

(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
    params ["_ctrl"];

    {
        private _countdownTime = _x getVariable QEGVAR(game,countdown_time);
        private _currentCountdown = _x getVariable QEGVAR(game,countdown);
        private _side = _x getVariable QEGVAR(game,side);
        private _siloNumber = _x getVariable QEGVAR(game,silo_number);

        private _iconData = _x getVariable QEGVAR(game,icons);

        // Get the proper icon
        private _frameIndex = 0;
        private _siloIcon = _iconData get sideUnknown get _siloNumber;
        if (_side in [west, east]) then {
            _frameIndex = round (((_countdownTime - _currentCountdown) / (_countdownTime / 21)) max 1 min 21);
            _siloIcon = _iconData get _side get _siloNumber get _frameIndex;
        };
        if (isNil "_siloIcon") exitWith {};

        _ctrl drawIcon [
            _siloIcon,
            [1,1,1,1],
            getPosATL _x,
            32,
            32,
            0
        ];
    } forEach (EGVAR(game,Game) getVariable [QEGVAR(game,silos), []]);
}];