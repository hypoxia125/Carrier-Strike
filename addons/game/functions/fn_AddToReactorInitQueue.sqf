/*
    fn_AddToReactorInitQueue
    Locality: Server

    Builds all the information needed for post init for carrier reactors
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_reactor", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if (isNil QGVAR(ReactorInitQueue)) then { GVAR(ReactorInitQueue) = [] };

// check for valid side
if (_side in [sideUnknown, civilian]) exitWith {
    diag_log format["CarrierStrike::AddToReactorInitQueue | Side needs to be either [west, east, independent]: %1", _side];
};

// add reactor to the queue
GVAR(ReactorInitQueue) pushBack [_reactor, _side];