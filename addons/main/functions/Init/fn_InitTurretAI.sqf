params ["_turret", "_side"];

private _gameData = call CarrierStrike_fnc_GetData;
private _carriers = _gameData getVariable "carriers";
private _carrier = _carriers get _side;

if (isNull _carrier) exitWith {
    diag_log format["CarrierStrike::InitTurret | No carrier found!"];
};

// create the crew
private _group = createGroup [_side, true];
private _units = units createVehicleCrew _turret;
_units joinSilent _group;

{
    gunner _turret disableAI _x;
} forEach ["AUTOTARGET", "TARGET", "SUPPRESSION", "PATH", "MOVE", "COVER", "RADIOPROTOCOL"];