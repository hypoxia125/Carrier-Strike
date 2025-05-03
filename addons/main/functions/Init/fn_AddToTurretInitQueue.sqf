params [
    ["_turret", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNil "CarrierStrike_TurretInitQueue") then { CarrierStrike_TurretInitQueue = [] };

// TODO: check if class is a UAV class

// check for valid side
if (_side in [sideUnknown, civilian]) exitWith {
    diag_log format["CarrierStrike::AddToTurretInitQueue | Side needs to be either [west, east, independent]: %1", _side];
};

// add turret to the queue
CarrierStrike_TurretInitQueue pushBack [_turret, _side];