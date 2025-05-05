params ["_object"];

// return game data itself if nothing provided
if (isNil "_object") exitWith {
    CarrierStrike_GameData;
};

// return silo control system
if (_object isEqualType "" && {_object == "SiloControlSystem"}) exitWith {
    CarrierStrike_SiloControlSystem;
};

private _data = _object getVariable "CarrierStrike_Data";
if (isNil "_data") exitWith {};

_data;