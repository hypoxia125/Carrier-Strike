/*
    fn_CarrierDamageDealt
    Locality: Server

    Handles which team takes carrier damage as well as how much. Also triggers end game event if carrier takes lethal damage
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_side", "_type"];

if (GVAR(Game) getVariable QGVAR(game_state) in [GAME_STATE_ENDING, GAME_STATE_ENDED]) exitWith {};

private _carrier = (GVAR(Game) getVariable QGVAR(carriers)) get _side;
private _maxHP = _carrier getVariable QGVAR(max_hp);
private _currentHp = _carrier getVariable QGVAR(current_hp);

private _damage = switch _type do {
    case "missile": { [QGVAR(Settings_SiloMissileDamage)] call CBA_settings_fnc_get };
    case "reactor": { [QGVAR(Settings_ReactorDestroyedDamage)] call CBA_settings_fnc_get };
};

private _newHp = _currentHp - _damage;
_carrier setVariable [QGVAR(current_hp), _newHP, true];

private _percentHP = _newHP / _maxHP;
private _alerts = GVAR(Game) getVariable QGVAR(alerts);
private _enemy = ([west, east] - [_side]) select 0;
private _alertVars = GVAR(Game) getVariable QGVAR(alert_vars);

// Update UI
[QEGVAR(ui,UpdateCarrierStatus), [_side, _percentHP, 1]] call CBA_fnc_globalEvent;

// initial damage alert
if (_percentHP < 1) then {
    if !((_alertVars get _side) get "initial") then {
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get "initial"], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set ["initial", true];
    };
};
// 75% damage alert
if (_percentHP <= 0.75) then {
    if !((_alertVars get _side) get 0.75) then {
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get 0.75], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [(_alerts get "enemyhull") get 0.75], units _enemy select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set [0.75, true];
    };
};
// 50% damage alert
if (_percentHP <= 0.50) then {
    if !((_alertVars get _side) get 0.50) then {
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get 0.50], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [(_alerts get "enemyhull") get 0.50], units _enemy select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set [0.50, true];
    };

    // alert reactors exposed
    if !((_alertVars get _side) get "reactor") then {
        private _reactorVulnerabilities = GVAR(Game) getVariable QGVAR(reactor_vulnerabilities);
        _reactorVulnerabilities set [_side, true];
        GVAR(Game) setVariable [QGVAR(reactor_vulnerabilities), _reactorVulnerabilities, true];
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get "reactor"], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [(_alerts get "enemyhull") get "reactor"], units _enemy select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set ["reactor", true];
    }
};
// 25% damage alert
if (_percentHP <= 0.25) then {
    if !((_alertVars get _side) get 0.25) then {
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get 0.25], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [(_alerts get "enemyhull") get 0.25], units _enemy select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set [0.25, true];
    };
};
// 15% damage alert
if (_percentHP <= 0.15) then {
    if !((_alertVars get _side) get 0.15) then {
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get 0.15], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [(_alerts get "enemyhull") get 0.15], units _enemy select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set [0.15, true];
    };
};
// 0% damage alert
if (_percentHP <= 0.0) then {
    if !((_alertVars get _side) get 0.0) then {
        [QGVAR(AlertAddToSystem), [(_alerts get "friendlyhull") get 0.0], units _side select { isPlayer _x }] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [(_alerts get "enemyhull") get 0.0], units _enemy select { isPlayer _x }] call CBA_fnc_targetEvent;
        (_alertVars get _side) set [0.0, true];
    };
};

// Loadout Unlocking
private _unlockHash = GVAR(Game) getVariable QGVAR(unlocked_loadouts);
if (_percentHP <= 1/3) then {
    if !(_unlockHash get 2) then {
        [2] call FUNC(UnlockLoadouts);
        _unlockHash set [2, true];
    };
};
if (_percentHP <= 2/3) then {
    if !(_unlockHash get 3) then {
        [3] call FUNC(UnlockLoadouts);
        _unlockHash set [3, true];
    };
};

if (_percentHP <= 0) exitWith {
    GVAR(Game) setVariable [QGVAR(game_state), GAME_STATE_ENDING, true];
    [QGVAR(ExplosionSequence), [_carrier]] call CBA_fnc_globalEvent;
};