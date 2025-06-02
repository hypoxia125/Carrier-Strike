#include "script_component.hpp"

params ["_units", "_channel"];

if (!isServer) exitWith {};

_channel radioChannelAdd _units;

private _units = radioChannelInfo _channel param [3, []];
_units = _units select {!alive _x || isNull _x};
_channel radioChannelRemove _units;