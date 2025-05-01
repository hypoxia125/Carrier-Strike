params ["_silo", "_var", "_value", "_broadcast"];

private _siloData = _silo getVariable "CarrierStrike_SiloData";
if (isNil "_siloData") exitWith {};

_siloData setVariable [_var, _value, _broadcast];