#include "script_component.hpp"

if (!isServer) exitWith {};

// Wait for mission start for certain inits
[] spawn {
    waitUntil { time > 0 };

    if (!isNil QGVAR(SiloInitQueue)) then {
        { _x call FUNC(InitSilo) } forEach GVAR(SiloInitQueue)
    };
    if (!isNil QGVAR(CarrierInitQueue)) then {
        { _x call FUNC(InitCarrier) } forEach GVAR(CarrierInitQueue)
    };
    if (!isNil QGVAR(ReactorInitQueue)) then {
        { _x call FUNC(InitReactor) } forEach GVAR(ReactorInitQueue)
    };
    if (!isNil QGVAR(TurretInitQueue)) then {
        { _x call FUNC(InitTurret) } forEach GVAR(TurretInitQueue)
    };
    if (!isNil QGVAR(VehicleInitQueue)) then {
        { _x call FUNC(InitVehicle) } forEach GVAR(VehicleInitQueue)
    };
};