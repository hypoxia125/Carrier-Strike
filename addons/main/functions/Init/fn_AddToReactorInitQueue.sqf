params [
    ["_reactor", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNil "CarrierStrike_ReactorInitQueue") then { CarrierStrike_ReactorInitQueue = [] };

// check for valid side
if (_side in [sideUnknown, civilian]) exitWith {
    diag_log format["CarrierStrike::AddToReactorInitQueue | Side needs to be either [west, east, independent]: %1", _side];
};

// add reactor to the queue
CarrierStrike_ReactorInitQueue pushBack [_reactor, _side];