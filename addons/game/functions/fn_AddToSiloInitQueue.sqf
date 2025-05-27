/*
    fn_AddToSiloInitQueue
    Locality: Server

    Builds all the information needed for post init for silos
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_silo", objNull, [objNull]],
    ["_siloNumber", -1, [-1]]
];

if (isNil QGVAR(SiloInitQueue)) then { GVAR(SiloInitQueue) = [] };

// check class for silo class
if (!(_silo isKindOf "B_Ship_MRLS_01_F")) exitWith {
    WARNING_2("CarrierStrike::AddToSiloInitQueue | Silo is not a valid silo type! [%1, %2]",typeOf _silo,"B_Ship_MRLS_01_F");
};

// validate number
if (_siloNumber <= 0 || _siloNumber > 5) exitWith {
    WARNING_1("CarrierStrike::AddToSiloInitQueue | Silo number needs to be within 1 to 5: %1",_siloNumber);
};

// check existing silos for duplicates
private _siloNumbers = GVAR(SiloInitQueue) apply {_x#1};
if (_siloNumber in _siloNumbers) exitWith {
    WARNING_1("CarrierStrike::AddToSiloInitQueue | There already exists a silo with the number: %1",_siloNumber);
};

// add silo to the queue
GVAR(SiloInitQueue) pushBackUnique [_silo, _siloNumber];