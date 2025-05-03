CarrierStrike_SiloControlSystem = call CarrierStrike_fnc_CreateNamespace;
{ CarrierStrike_SiloControlSystem setVariable [_x, _y] } forEach CarrierStrike_Struct_SiloControlSystem;

[{
    params ["_args", "_handle"];

    if (isNil "CarrierStrike_SiloControlSystem") exitWith {};
    // skip if in single player and paused
    if (!isMultiplayer && isGamePaused) exitWith {};
    // TODO: exit and destroy if game ended

    private _silos = CarrierStrike_SiloControlSystem getVariable "silos";
    {
        private _silo = _x;
        private _siloData = _silo call CarrierStrike_fnc_GetData;
        private _countdown = _siloData getVariable "countdown";
        private _isFiring = _siloData getVariable "is_firing";
        private _side = _siloData getVariable "side";

        // TODO: Update UI

        // Fire if at zero
        if (_countdown <= 0) then {
            if (_side isEqualTo sideUnknown) then { continue };

            if (!_isFiring) then {
                [_silo, ["is_firing", true], false] call CarrierStrike_fnc_SetData;
                [_silo] call CarrierStrike_fnc_LaunchMissile;

                [{
                    params ["_silo"];
                    private _siloData = _silo call CarrierStrike_fnc_GetData;
                    
                    private _countdown = _siloData getVariable "countdown";
                    private _countdownTime = _siloData getVariable "countdown_time";

                    [_silo, ["countdown", _countdownTime], true] call CarrierStrike_fnc_SetData;
                    [_silo, ["is_firing", false], false] call CarrierStrike_fnc_SetData;

                }, [_silo], 3] call CBA_fnc_waitAndExecute;
            };
        };

        [_silo] call CarrierStrike_fnc_SiloCountdownWarning;

        // Increment countdown
        _countdown = _countdown - 1;
        [_silo, ["countdown", _countdown], true] call CarrierStrike_fnc_SetData;

        diag_log format["Silo Countdown %1", _countdown];

    } forEach _silos;

}, 1, []] call CBA_fnc_addPerFrameHandler;