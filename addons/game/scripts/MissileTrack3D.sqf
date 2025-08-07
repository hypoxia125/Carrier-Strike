#include "script_component.hpp"

{
    if (!alive _x) then { continue };
    if (cameraView == "Gunner") then { continue };
    private _distance = player distance _x;
    if (_distance <= 50) then { continue };

    private _pos = _x modelToWorldVisual [0,0,0];
    private _side = _x getVariable QGVAR(side);
    private _color = switch (_side) do {
        case west: { [QGVAR(Settings_SiloMissileTrackingColorWest)] call CBA_settings_fnc_get };
        case east: { [QGVAR(Settings_SiloMissileTrackingColorEast)] call CBA_settings_fnc_get };
        case independent: { [QGVAR(Settings_SiloMissileTrackingColorIndependent)] call CBA_settings_fnc_get };
    };

    // draw hex icon
    drawIcon3D [
        "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
        _color + [1],
        _pos,
        1 * (300 / _distance),
        1 * (300 / _distance),
        0
    ];

    // draw alert text
    private _startTime = _x getVariable QGVAR(MissileTrackStartTime);
    if (isNil "_startTime") then {
        _x setVariable [QGVAR(MissileTrackStartTime), time];
    };
    
    private _elapsedTime = time - _startTime;

    if (_side isEqualTo side group player) then { continue };

    if (_elapsedTime >= 0.5 && _elapsedTime <= 1) then {
        drawIcon3D [
            [1,1,1,0] call BIS_fnc_colorRGBAtoTexture,
            _color + [1],
            _pos vectorAdd [0, 0, -(1 * (1000 / _distance))],
            1,
            0.25,
            0,
            LLSTRING(IncomingMissile),
            0,
            0.027
        ];
    };

    if (_elapsedTime > 1) then {
        _x setVariable [QGVAR(MissileTrackStartTime), time];
    };
} forEach (missionNamespace getVariable [QGVAR(missiles), []]);
