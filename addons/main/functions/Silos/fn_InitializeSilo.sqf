#define FNC_NAME    "CarrierStrike::InitializeSilo | "

_this spawn {
    waitUntil {!isNil "CarrierStrike_SiloControlSystem"};

    params [
        ["_silo", objNull, [objNull]],
        ["_siloNumber", -1, [-1]]
    ];

    if !(isServer) exitWith {};

    if (isNull _silo) exitWith {};
    if (_siloNumber <= 0) exitWith {};
    if (_siloNumber > 5) exitWith {};

    // build data
    private _siloData = call CarrierStrike_fnc_CreateNamespace;
    _silo setVariable ["CarrierStrike_SiloData", _siloData, true];
    { _siloData setVariable [_x, _y] } forEach CarrierStrike_Struct_SiloData;
    _siloData setVariable ["silo_number", _siloNumber, true];

    // add to control system
    diag_log format[FNC_NAME + "Adding silo %1 to control system", _siloNumber];
    if (isNil "CarrierStrike_SiloControlSystem") then {
        diag_log format[FNC_NAME + "No control system found!", _siloNumber];
    };
    private _silosControlled = CarrierStrike_SiloControlSystem getVariable "silos";
    _silosControlled insert [-1, [_silo]];
    CarrierStrike_SiloControlSystem setVariable ["silos", _silosControlled];

    // set invuln
    _silo allowDamage false;

    // create crew
    private _group = _siloData getVariable "crew_group";
    _group = createGroup civilian;
    private _crew = units (createVehicleCrew _silo);
    _crew joinSilent _group;
    _siloData setVariable ["crew_group", _group];

    // create and attach platforms
    private _composition = _siloData getVariable "composition";

    {
        private _pos = _silo modelToWorldWorld (_composition get _x);
        private _type = _composition get "platform";

        private _platform = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
        //_platform enableSimulationGlobal false;
        _platform setDir getDir _silo;
        _platform setPosASL _pos;

        _platform setVectorDirAndUp [vectorDir _silo, vectorUp _silo];
        [_silo, _platform] call BIS_fnc_attachToRelative;
    } forEach ["platform_rear", "platform_front"];

    // create and attach neutral light
    private _lights = _siloData getVariable "lights";
    {
        private _pos =  _silo modelToWorldWorld (_composition get _x);
        private _type = _composition get "light_neutral";

        private _light = createVehicle [_type, [0,0,0], [], 0, "NONE"];
        //_light setDir getDir _silo;
        _light setPosASL _pos;

        _light setVectorDirAndUp [vectorDir _silo, vectorUp _silo];
        [_light, _silo] call BIS_fnc_attachToRelative;

        // This is incase you want to disable simulation on the parent platforms.
        // Has to be called a frame later in order for lights to work.
        // [{
        //     params ["_silo", "_light"];

        //     [_light, _silo] call BIS_fnc_attachToRelative;
        // }, [_light, _silo]] call CBA_fnc_execNextFrame;

        _lights insert [-1, [_light]];
    } forEach ["light_r", "light_l"];
    _siloData setVariable ["lights", _lights];

    // remove silo frag rounds
    _silo removeMagazinesTurret ["magazine_Missiles_Cruise_01_Cluster_x18", [0]];

    // start silo loop

    // start silo vehicle loop

    // create actions for MP + JIP
};