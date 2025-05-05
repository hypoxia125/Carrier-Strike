params ["_turret", "_side", ["_turretLimits", [], [[]], 4]];

private _gameData = call CarrierStrike_fnc_GetData;
private _carriers = _gameData getVariable "carriers";
private _carrier = _carriers get _side;

if (isNull _carrier) exitWith {
    diag_log format["CarrierStrike::InitTurret | No carrier found!"];
};

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
