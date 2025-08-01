#include "script_component.hpp"

[QGVAR(AlertAddToSystem), {
    call FUNC(AlertAddToSystem);
}] call CBA_fnc_addEventHandler;

[QGVAR(ExplosionSequence), {
    call FUNC(ExplosionSequence);
}] call CBA_fnc_addEventHandler;

[QGVAR(ReactorShotSimInit), {
    call FUNC(ReactorShotSimInit);
}] call CBA_fnc_addEventHandler;

[QGVAR(AddToChatChannel), {
    call FUNC(AddToChatChannel);
}] call CBA_fnc_addEventHandler;

[QGVAR(RallyPointCreate), {
    call FUNC(RallyPointCreate);
}] call CBA_fnc_addEventHandler;

[QGVAR(HintSilent), {
    params ["_txt"];
    hintSilent _txt;
}] call CBA_fnc_addEventHandler;

[QGVAR(SystemChat), {
    params ["_txt"];
    systemChat _txt;
}] call CBA_fnc_addEventHandler;

[QGVAR(CommanderVoteNotification), {
    params [["_name", ""], "_state", ["_isMutiny", false]];

    private _txt = "";

    if (isNil "_state") exitWith {
        private _keybindYes = (["CarrierStrike", "CommanderVoteYes"] call CBA_fnc_getKeybind) select 5;
        _keybindYes = _keybindYes call CBA_fnc_localizeKey;

        private _keybindNo = (["CarrierStrike", "CommanderVoteNo"] call CBA_fnc_getKeybind) select 5;
        _keybindNo = _keybindNo call CBA_fnc_localizeKey;

        if (_isMutiny) then {
            _txt = format["A muntiny has started against %1.\nVote YES with %2.\nVote NO with %3", _name, _keybindYes, _keybindNo];
        } else {
            _txt = format["%1 has applied to be the commander.\nVote YES with %2.\nVote NO with %3", _name, _keybindYes, _keybindNo];
        };
        hintSilent _txt;
    };

    switch _state do {
        case true: {
            if (_isMutiny) then {
                _txt = format["%1 has been removed from the Commander position.", _name];
            } else {
                _txt = format["%1 has been voted into the Commander position.", _name];
            };            
        };
        case false: {
            if (_isMutiny) then {
                _txt = format["%1 has been not been removed from the Commander position.", _name];
            } else {
                _txt = format["%1 was not voted into the Commander position.", _name];
            };
        };
    };

    hintSilent _txt;
}] call CBA_fnc_addEventHandler;

[QGVAR(CommanderVote), {
    params ["_voteState", "_side"];

    if (!isServer) exitWith {};

    private _commanderVotes = missionNamespace getVariable QGVAR(CommanderVotes);
    private _sideVotes = _commanderVotes get _side;
    if (_voteState) then {
        _sideVotes set ["yes", (_sideVotes get "yes") + 1];
    } else {
        _sideVotes set ["no", (_sideVotes get "no") + 1];
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(CommanderApply), {
    LOG("Server Event::CommanderApply | Called");
    _this call FUNC(CommanderApply);
}] call CBA_fnc_addEventHandler;

[QGVAR(CommanderMutiny), {
    LOG("Server Event::CommanderMutiny | Called");
    _this call FUNC(CommanderMutiny);
}] call CBA_fnc_addEventHandler;

[QGVAR(CommanderResetScan), {
    params ["_side"];

    private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
    private _scanCooldowns = _commanderData get "scanCooldowns";
    private _scanCooldown = _scanCooldowns get _side;

    _scanCooldown = GVAR(CommanderTimeoutSystem) get "m_scanCooldownTime";
    _scanCooldowns set [_side, _scanCooldown];

    missionNamespace setVariable [QGVAR(CommanderData), _commanderData, true];
}] call CBA_fnc_addEventHandler;

[QGVAR(CommanderResetArtillery), {
    params ["_side"];

    private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
    private _artilleryCooldowns = _commanderData get "artilleryCooldowns";
    private _artilleryCooldown = _artilleryCooldowns get _side;

    _artilleryCooldown = GVAR(CommanderTimeoutSystem) get "m_artilleryCooldownTime";
    _artilleryCooldowns set [_side, _artilleryCooldown];

    missionNamespace setVariable [QGVAR(CommanderData), _commanderData, true];
}] call CBA_fnc_addEventHandler;
