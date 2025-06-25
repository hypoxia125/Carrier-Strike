#include "script_component.hpp"

if (cameraView == "Gunner") exitWith {};

{
    private _distance = player distance _x;
    if (_distance > 250) then { continue };

    private _reactorHP = _x getVariable QGVAR(current_hp);
    private _icon = "\a3\modules_f_curator\data\iconlightning_ca.paa";

    private _side = _x getVariable QGVAR(side);
    private _color = switch _side do {
        case west: { [0,0.3,0.6,1] };
        case east: { [0.5,0,0,1] };
        case independent: { [0,0.5,0,1] };
        default { [0.7,0.6,0,1] };
    };

    private _pos = getPosASL _x vectorAdd [0,0,2];
    _pos = ASLToAGL _pos;

    private _textSize = 0.025;
    drawIcon3D [
        _icon,
        _color,
        _pos,
        1,
        1,
        0,
        "HP: " + (str round _reactorHP) + "%",
        2,
        _textSize
    ];
} forEach (missionNamespace getVariable [QGVAR(reactors), []]);