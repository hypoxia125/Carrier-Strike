/*
    fn_AddToCarrierInitQueue
    Locality: Server

    Builds all the information needed for post init for carriers
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_carrier", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNil QGVAR(CarrierInitQueue)) then { GVAR(CarrierInitQueue) = [] };

// check class for carrier class
if (!(_carrier isKindOf "Land_Carrier_01_base_F")) exitWith {
    WARNING_2("AddToCarrierInitQueue | Provided carrier is not a valid carrier type! [%1, %2]",typeOf _carrier,"Land_Carrier_01_base_F");
};

// check for valid side
if !(_side in [west, east]) exitWith {
    WARNING_1("AddToCarrierInitQueue | Side needs to be either [west, east]: %1",_side);
};

// check exisiting sides for duplicates
private _sides = GVAR(CarrierInitQueue) apply {_x#1};
if (_side in _sides) exitWith {
    WARNING_1("AddToCarrierInitQueue | There already exists a carrier with the side: %1",_side);
};

// add carrier to the queue
GVAR(CarrierInitQueue) pushBackUnique [_carrier, _side];