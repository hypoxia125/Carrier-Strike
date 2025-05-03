params [
    ["_carrier", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNil "CarrierStrike_CarrierInitQueue") then { CarrierStrike_CarrierInitQueue = [] };

// TODO: check class for carrier class

// check for valid side
if (_side in [sideUnknown, civilian]) exitWith {
    diag_log format["CarrierStrike::AddToCarrierInitQueue | Side needs to be either [west, east, independent]: %1", _side];
};

// check exisiting sides for duplicates
private _sides = CarrierStrike_CarrierInitQueue apply {_x#1};
if (_side in _sides) exitWith {
    diag_log format["CarrierStrike::AddToCarrierInitQueue | There already exists a carrier with the side: %1", _side];
};

// add carrier to the queue
CarrierStrike_CarrierInitQueue pushBack [_carrier, _side];