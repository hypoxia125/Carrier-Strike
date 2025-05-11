#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_carrier", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNil QGVAR(CarrierInitQueue)) then { GVAR(CarrierInitQueue) = [] };

// check class for carrier class
if (!(_carrier isKindOf "Land_Carrier_01_base_F")) exitWith {
    diag_log format["CarrierStrike::AddToCarrierInitQueue | Provided carrier is not a valid carrier type! [%1, %2]", typeOf _carrier, "Land_Carrier_01_base_F"];
};

// check for valid side
if (_side in [sideUnknown, civilian]) exitWith {
    diag_log format["CarrierStrike::AddToCarrierInitQueue | Side needs to be either [west, east, independent]: %1", _side];
};

// check exisiting sides for duplicates
private _sides = GVAR(CarrierInitQueue) apply {_x#1};
if (_side in _sides) exitWith {
    diag_log format["CarrierStrike::AddToCarrierInitQueue | There already exists a carrier with the side: %1", _side];
};

// add carrier to the queue
GVAR(CarrierInitQueue) pushBack [_carrier, _side];