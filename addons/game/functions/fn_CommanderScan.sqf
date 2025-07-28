#include "script_component.hpp"

if (!canSuspend) exitWith { _this spawn FUNC(CommanderScan) };

#define SCANBARCOLOR    [0.0, 0.75, 1.0]

private _scanBarHeight = worldSize / 2;
private _scanBarCenter = [0, worldSize / 2, 0];
private _scanBarWidth = 100;

private _scanBar = createMarkerLocal [QGVAR(ScanBar), _scanBarCenter];
_scanBar setMarkerBrushLocal "Solid";
_scanBar setMarkerColorLocal SCANBARCOLOR;
_scanBar setMarkerShapeLocal "RECTANGLE";

private _sides = [west, east, independent] - [side group player];
private _spottedMarkers = [];
while { (getMarkerPos _scanBar # 0) < worldSize } do {
    // spot the units
    {
        private _units = units _x;
        private _unitsToAdd = _units inAreaArray (_scanBar call BIS_fnc_getArea);

        {
            private _unit = _x;
            if (!(_unit in _spottedMarkers)) then {
                _spottedMarkers pushBackUnique _unit;

                _unit spawn {
                    private _markerName = format[QGVAR(SpottedMarker_%1), _unit];
                    private _marker = createMarkerLocal [_markerName, getPosATL _unit];
                    _marker setMarkerShapeLocal "ICON";
                    _marker setMarkerTypeLocal "mil_dot";
                    _marker setMarkerColorLocal "ColorRED";

                    private _timeToShow = 10;
                    private _rate = 0.1;
                    while {markerAlpha _marker > 0} do {
                        private _change = _rate / _timeToShow;
                        private _prev = markerAlpha _marker;
                        private _delta = (_prev - _change) max 0;

                        _marker setMarkerAlphaLocal _delta;
                    };

                    deleteMarker _marker;
                };
            };
        } forEach _unitsToAdd;
    } forEach _sides;

    // change position of scan bar
    private _pos = getMarkerPos _scanBar;
    _pos set [0, (_pos#0) + 1];
    _scanBar setMarkerPosLocal _pos;
};