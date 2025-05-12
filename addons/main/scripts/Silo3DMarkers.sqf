#include "script_component.hpp"

if (cameraView == "Gunner") exitWith {};

{
    private _distance = player distance _x;
    if (_distance <= 10) then { continue };

    private _countdownTime = _x getVariable QGVAR(countdown_time);
    private _currentCountdown = _x getVariable QGVAR(countdown);
    private _side = _x getVariable QGVAR(side);
    private _siloNumber = _x getVariable QGVAR(silo_number);

    private _iconData = _x getVariable QGVAR(icons);

    // Get the proper icon
    private _frameIndex = 0;
    private _siloIcon = _iconData get sideUnknown get _siloNumber;
    if (_side in [west, east]) then {
        _frameIndex = round (((_countdownTime - _currentCountdown) / (_countdownTime / 21)) max 1 min 21);
        _siloIcon = _iconData get _side get _siloNumber get _frameIndex;
    };
    if (isNil "_siloIcon") exitWith {};

    private _pos = ASLToAGL (getPosASL _x vectorAdd [0, 0, (1000 / _distance) min 10]);
    private _iconSize = linearConversion [10, 500, _distance, 0.5, 0.5/2, true];
    _iconSize = _iconSize / (getResolution#5);
    private _textSize = linearConversion [10, 500, _distance, 0.05/2, 0.03/2, true];
    _textSize = _textSize / (getResolution#5);

    drawIcon3D [
        _siloIcon,
        [1, 1, 1, 1],
        _pos,
        _iconSize,
        _iconSize,
        0,
        (str round _distance) + " m",
        0,
        _textSize
    ];
} forEach (GVAR(Game) getVariable [QGVAR(silos), []]);