params [
    ["_turret", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]],
    ["_turretLimits", [], [[]], 4]
];

if (isNil "CarrierStrike_TurretInitQueue") then { CarrierStrike_TurretInitQueue = [] };

// check if class is a UAV class
private _isUAV = getNumber (configFile >> "CfgVehicles" >> typeOf _turret >> "isUAV") == 1;
if (!_isUAV || !(_turret isKindOf "StaticMGWeapon")) exitWith {
    diag_log format["CarrierStrike::AddToTurretInitQueue | Turret is not a UAV controlled turret! %1", _turret];
};

// check for valid side
if (_side in [sideUnknown, civilian]) exitWith {
    diag_log format["CarrierStrike::AddToTurretInitQueue | Side needs to be either [west, east, independent]: %1", _side];
};

// add turret to the queue
CarrierStrike_TurretInitQueue pushBack [_turret, _side, _turretLimits];