params [
    ["_silo", objNull, [objNull]],
    ["_siloNumber", -1, [-1]]
];

if (isNil "CarrierStrike_SiloInitQueue") then { CarrierStrike_SiloInitQueue = [] };

// check class for silo class
if (!(_silo isKindOf "B_Ship_MRLS_01_F")) exitWith {
    diag_log format["CarrierStrike::AddToSiloInitQueue | Silo is not a valid silo type! [%1, %2]", typeOf _silo, "B_Ship_MRLS_01_F"];
};

// validate number
if (_siloNumber <= 0 || _siloNumber > 5) exitWith {
    diag_log format["CarrierStrike::AddToSiloInitQueue | Silo number needs to be within 1 to 5: %1", _siloNumber];
};

// check existing silos for duplicates
private _siloNumbers = CarrierStrike_SiloInitQueue apply {_x#1};
if (_siloNumber in _siloNumbers) exitWith {
    diag_log format["CarrierStrike::AddToSiloInitQueue | There already exists a silo with the number: %1", _siloNumber];
};

// add silo to the queue
CarrierStrike_SiloInitQueue pushBack [_silo, _siloNumber];