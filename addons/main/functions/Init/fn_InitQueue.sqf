// Validate queues
private _error = false;
if (isNil "CarrierStrike_SiloInitQueue" || {count CarrierStrike_SiloInitQueue == 0}) then {
    diag_log format["CarrierStrike::InitQueue | No data in the silo init queue!"];
    _error = true;
};
if (isNil "CarrierStrike_CarrierInitQueue" || {count CarrierStrike_CarrierInitQueue == 0}) then {
    diag_log format["CarrierStrike::InitQueue | No data in the carrier init queue!"];
    _error = true;
};
if (isNil "CarrierStrike_ReactorInitQueue" || {count CarrierStrike_ReactorInitQueue == 0}) then {
    diag_log format["CarrierStrike::InitQueue | No data in the reactor init queue!"];
    _error = true;
};
if (_error) exitWith {};

{ _x call CarrierStrike_fnc_InitSilo } forEach CarrierStrike_SiloInitQueue;
{ _x call CarrierStrike_fnc_InitCarrier } forEach CarrierStrike_CarrierInitQueue;
{ _x call CarrierStrike_fnc_InitReactor } forEach CarrierStrike_ReactorInitQueue;
{ _x call CarrierStrike_fnc_InitTurret } forEach CarrierStrike_TurretInitQueue;