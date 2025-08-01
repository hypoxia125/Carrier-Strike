#include "script_component.hpp"

if (!canSuspend) exitWith { _this spawn FUNC(CommanderScan) };

openMap true;
mapAnimAdd [0, 1, [worldSize / 2, worldSize / 2]];
mapAnimCommit;

#define SCANBARCOLOR	"#(0.0, 0.75, 1.0)"

private _scanBarHeight = worldSize / 2;
private _scanBarWidth = 100;
private _scanTime = 3;
private _tickRate = 0.01;

private _xPerSecond = worldSize / _scanTime;
private _xPerTick = _xPerSecond * _tickRate;

private _scanBarCenter = [0 + (_scanBarWidth / 2), worldSize / 2, 0];
private _scanBar = createMarkerLocal [QGVAR(ScanBar), _scanBarCenter];
_scanBar setMarkerBrushLocal "Solid";
_scanBar setMarkerColorLocal SCANBARCOLOR;
_scanBar setMarkerShapeLocal "RECTANGLE";
_scanBar setMarkerSizeLocal [_scanBarWidth, worldSize / 2];

private _sides = [west, east, independent] - [side group player];
private _markers = [];
private _scanning = true;

private _units = [];
{
    private _side = _x;
    {
        private _unit = _x;
        if (!(unitIsUAV _unit)) then {
            _units pushBack _unit;
        };
    } forEach units _side;
} forEach _sides;

[_markers, _tickRate, _scanBar] spawn {
	params ["_markers", "_tickRate", "_scanBar"];

	private _showTime = 5;
	private _alphaPerTick = _tickRate / _showTime;

	waitUntil { _markers isNotEqualTo [] };
	while { !(getMarkerPos _scanBar isEqualTo [0,0,0] && _markers isEqualTo []) } do {
		// decrease alpha of markers
		{
			private _marker = _x;
			private _currAlpha = markerAlpha _marker;
			if (_currAlpha <= 0) then {
				deleteMarkerLocal _marker;
				_markers deleteAt _forEachIndex;
				continue;
			};
			_marker setMarkerAlphaLocal (_currAlpha - _alphaPerTick);
		} forEachReversed _markers;

		sleep _tickRate;
	};
};

[_scanBar, _units, _markers, _tickRate] spawn {
    params ["_scanBar", "_units", "_markers", "_tickRate"];

    private _spotted = [];

    while { getMarkerPos _scanBar isNotEqualTo [0,0,0] } do {
        // spot the units
        private _unitsToAdd = _units inAreaArray (_scanBar call BIS_fnc_getArea);

        {
            private _unit = _x;
            
            if (!(_unit in _spotted)) then {
                _spotted pushBack _unit;

                private _markerName = format[QGVAR(SpottedMarker_%1), _unit];
                private _marker = createMarkerLocal [_markerName, getPosATL _unit];
                _marker setMarkerShapeLocal "ICON";
                _marker setMarkerTypeLocal "mil_dot";
                _marker setMarkerColorLocal "ColorRED";
                _marker setMarkerAlphaLocal 1;
                _markers pushBack _marker;
            };
        } forEach _unitsToAdd;

        sleep _tickRate;
    };
};

// Move marker unscheduled
[{
    params ["_args", "_handle"];
    _args params ["_scanBar", "_xPerTick", "_scanBarWidth"];

    private _pos = getMarkerPos _scanBar;

    if (_pos isEqualTo [0,0,0]) exitWith { _handle call CBA_fnc_removePerFrameHandler };

    if (_pos select 0 >= (worldSize - (_scanBarWidth / 2))) exitWith {
        deleteMarkerLocal _scanBar;
        _handle call CBA_fnc_removePerFrameHandler
    };

	_pos set [0, (_pos#0) + _xPerTick];
	_scanBar setMarkerPosLocal _pos;

}, _tickRate, [_scanBar, _xPerTick, _scanBarWidth]] call CBA_fnc_addPerFrameHandler;

[QGVAR(CommanderResetScan), [side group player]] call CBA_fnc_serverEvent;
