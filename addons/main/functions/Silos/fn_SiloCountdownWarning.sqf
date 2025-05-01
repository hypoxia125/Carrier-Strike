params ["_silo"];

private _siloData = _silo getVariable "CarrierStrike_SiloData";
private _countdown = _siloData getVariable "countdown";

switch (_countdown) do {
    case 120: {
        diag_log format["CarrierStrike::SiloCountdownWarning | Silo %1 - Countdown Warning - 2 minutes", _siloData getVariable "silo_number"];
    };
    case 60: {
        diag_log format["CarrierStrike::SiloCountdownWarning | Silo %1 - Countdown Warning - 1 minute", _siloData getVariable "silo_number"];
    };
    case 30: {
        diag_log format["CarrierStrike::SiloCountdownWarning | Silo %1 - Countdown Warning - 30 seconds", _siloData getVariable "silo_number"];
    };
    case 6: {
        diag_log format["CarrierStrike::SiloCountdownWarning | Silo %1 - Countdown Warning - 5 seconds", _siloData getVariable "silo_number"];
    };
}