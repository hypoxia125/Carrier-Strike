#include "script_component.hpp"

if (!isServer) exitWith {};

// Wait for mission start for certain inits
[] spawn {
    waitUntil { time > 0 };
    { _x call FUNC(InitSilo) } forEach GVAR(SiloInitQueue);
    { _x call FUNC(InitCarrier) } forEach GVAR(CarrierInitQueue);
    { _x call FUNC(InitReactor) } forEach GVAR(ReactorInitQueue);
    { _x call FUNC(InitTurret) } forEach GVAR(TurretInitQueue);
    { _x call FUNC(InitVehicle) } forEach GVAR(VehicleInitQueue);
};