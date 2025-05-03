params ["_carrier", "_side"];

if (!isServer) exitWith {};

_carrierData = call CarrierStrike_fnc_CreateNamespace;
{ _carrierData setVariable [_x, _y] } forEach CarrierStrike_Struct_CarrierData;
_carrier setVariable ["CarrierStrike_CarrierData", _carrierData, true];
[_carrier, ["side", _side], true] call CarrierStrike_fnc_SetData;

[_carrier] call CarrierStrike_fnc_InitializeTurrets;
[_carrier] call CarrierStrike_fnc_InitializeReactors;