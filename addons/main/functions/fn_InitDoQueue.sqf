#include "script_component.hpp"

if (!isServer) exitWith {};

// Validate queues
private _error = false;
if (isNil QGVAR(SiloInitQueue) || {count GVAR(SiloInitQueue) == 0}) then {
    diag_log format["CarrierStrike::InitQueue | No data in the silo init queue!"];
    _error = true;
};
if (isNil QGVAR(CarrierInitQueue) || {count GVAR(CarrierInitQueue) == 0}) then {
    diag_log format["CarrierStrike::InitQueue | No data in the carrier init queue!"];
    _error = true;
};
// if (isNil QGVAR(ReactorInitQueue) || {count GVAR(ReactorInitQueue) == 0}) then {
//     diag_log format["CarrierStrike::InitQueue | No data in the reactor init queue!"];
//     _error = true;
// };
if (_error) exitWith {};

{ _x call FUNC(InitSilo) } forEach GVAR(SiloInitQueue);
{ _x call FUNC(InitCarrier) } forEach GVAR(CarrierInitQueue);
// { _x call FUNC(InitReactor) } forEach GVAR(ReactorInitQueue);
{ _x call FUNC(InitTurret) } forEach GVAR(TurretInitQueue);