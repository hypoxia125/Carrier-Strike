params ["_carrier"];

private _carrierData = _carrier getVariable "CarrierStrike_CarrierData";
private _turrets = _carrierData getVariable "turrets";
private _composition = _carrierData getVariable "composition";

while {_i = _i + 1; !isNil {_composition get format["turret_%1", _1]}} do {
    (_data get format["turret_%1", _i]) params ["_pos", "_dir"];

    _pos = _carrier modelToWorldWorld _pos;

    private _class = _data get "turret_class";
    private _turret = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];

    _turret allowDamage false;
    _turret setDir (getDir _carrier + _dir);
    _turret setPosASL _pos;

    // set turret limits
    if (_i in [0,2,5]) then {
        _turret setTurretLimits [[0], -180, 180, 0, 90];
    };

    _turrets insert [-1, [_turret]];

    // TODO: Add turret crew and AI
};

_carrierData setVariable ["turrets", _turrets];