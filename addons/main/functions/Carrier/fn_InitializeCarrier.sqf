params ["_carrier", "_side"];

if (!isServer) exitWith {};

_carrierData = call CarrierStrike_fnc_CreateNamespace;
_carrier setVariable ["CarrierStrike_CarrierData", _carrierData, true];
_carrierData setVariable ["side", _side, true];

[_carrier] call CarrierStrike_fnc_InitializeTurrets;

// TODO: Me First