params ["_turret", "_carrier", ["_turretLimits", [], [[]], 4]];

private _carrierData = _carrier call CarrierStrike_fnc_GetData;
_turret allowDamage false;

if (!isNil "_turretLimits") then {
    _turretLimits params ["_minTurn", "_maxTurn", "_minElev", "_maxElev"];
    _turret setTurretLimits [[0], _minTurn, _maxTurn, _minElev, _maxElev];
};

//TODO: Add turret crew and AI

// Add turret to carrierData
private _turrets = _carrierData getVariable "turrets";
_turrets insert [-1, [_turret]];

[_carrier, ["turrets", _turrets], false] call CarrierStrike_fnc_SetData;
