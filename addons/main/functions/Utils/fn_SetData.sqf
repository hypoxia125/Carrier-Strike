params ["_object", "_dataValue", ["_broadcast", false]];
_dataValue params ["_key", "_value"];

if (isNil "_object") then {
    _data = call CarrierStrike_fnc_GetData;
} else {
    private _data = _object call CarrierStrike_fnc_GetData;
};

if (isNil "_data") exitWith {};

_data setVariable [_key, _value, _broadcast];