CarrierStrike_SiloControlSystem = call CarrierStrike_fnc_CreateNamespace;
{ CarrierStrike_SiloControlSystem setVariable [_x, _y] } forEach CarrierStrike_Struct_SiloControlSystem;

diag_log "CarrierStrike::InitializeSiloControlSystem | Starting Silo Control System";
[{
    params ["_args", "_handle"];

    if (isNil "CarrierStrike_SiloControlSystem") exitWith {};
    // skip if in single player and paused
    if (!isMultiplayer && isGamePaused) exitWith {};
    // TODO: exit and destroy if game ended

    private _silos = CarrierStrike_SiloControlSystem getVariable "silos";
    {
        private _silo = _x;
        private _siloData = _silo getVariable "CarrierStrike_SiloData";

        // TODO: Update UI

        // Fire if at zero
        if (_siloData getVariable "countdown" <= 0) then {
            if ((_siloData getVariable "side") isEqualTo sideUnknown) then { continue };

            if (!(_siloData getVariable "is_firing")) then {
                _siloData setVariable ["is_firing", true];
                [_silo] call CarrierStrike_fnc_LaunchMissile;

                [{
                    params ["_silo"];
                    private _siloData = _silo getVariable "CarrierStrike_SiloData";
                    
                    _siloData setVariable ["countdown", _siloData getVariable "countdown_time", true];
                    _siloData setVariable ["is_firing", false];
                }, [_silo], 3] call CBA_fnc_waitAndExecute;
            };
        };

        [_silo] call CarrierStrike_fnc_SiloCountdownWarning;

        // Increment countdown
        _siloData setVariable ["countdown", (_siloData getVariable "countdown") - 1, true];
        diag_log format["Silo Countdown %1", _siloData getVariable "countdown"];

    } forEach _silos;

}, 1, []] call CBA_fnc_addPerFrameHandler;