/*
    fn_CarrierDamageDealt
    Locality: Server

    Handles which team takes carrier damage as well as how much. Also triggers end game event if carrier takes lethal damage
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_side", "_type"];

if (missionNamespace getVariable QGVAR(game_state) in [GAME_STATE_ENDING, GAME_STATE_ENDED]) exitWith {};

////////////////////////////////////////////////////////////////////////////////////////////////
// Modify Carrier HP
////////////////////////////////////////////////////////////////////////////////////////////////
private _carrier = (missionNamespace getVariable QGVAR(carriers)) get _side;
private _maxHP = _carrier getVariable QGVAR(max_hp);
private _currentHp = _carrier getVariable QGVAR(current_hp);

private _damage = switch _type do {
    case "missile": { [QGVAR(Settings_SiloMissileDamage)] call CBA_settings_fnc_get };
    case "reactor": { [QGVAR(Settings_ReactorDestroyedDamage)] call CBA_settings_fnc };
};

private _newHp = _currentHp - _damage;
_carrier setVariable [QGVAR(current_hp), _newHP, true];

private _percentHP = _newHP / _maxHP;

// Update UI
[QEGVAR(ui,UpdateCarrierStatus), [_side, _percentHP, 1]] call CBA_fnc_globalEvent;

////////////////////////////////////////////////////////////////////////////////////////////////
// Alerts
////////////////////////////////////////////////////////////////////////////////////////////////
private _alerts = missionNamespace getVariable QGVAR(alerts);
private _hullstatus = _alerts get "hullstatus";
private _enemy = ([west, east] - [_side]) select 0;
private _friendlyUnits = units _side select { isPlayer _x };
private _enemyUnits = units _enemy select { isPlayer _x };

private _fnc_triggerAlert = {
    params ["_key", "_percent"];

    private _played = _hullstatus get _key get "played" get _side;
    if (_percentHP <= _percent && !_played) then {
        private _alertPathFriendly = _hullstatus get _key get "path_friendly";
        private _alertPathEnemy = _hullstatus get _key get "path_enemy";

        [QGVAR(AlertAddToSystem), [_alertPathFriendly], _friendlyUnits] call CBA_fnc_targetEvent;
        [QGVAR(AlertAddToSystem), [_alertPathEnemy], _enemyUnits] call CBA_fnc_targetEvent;
    };
};

// Check thresholds
["initial", 1] call _fnc_triggerAlert;
[0.75, 0.75] call _fnc_triggerAlert;
[0.50, 0.50] call _fnc_triggerAlert;
[0.25, 0.25] call _fnc_triggerAlert;
[0, 0] call _fnc_triggerAlert;

// Handle reactor
if (_percentHP <= 0.50 && (_hullstatus get "reactor" get "played" get _side)) then {
    private _vunerabilites = missionNamespace getVariable QGVAR(reactor_vulnerabilites);
    _vunerabilites set [_side, true];
    missionNamespace setVariable [QGVAR(reactor_vulnerabilites), true];

    private _alertPathFriendly = _hullstatus get "reactor" get "path_friendly";
    private _alertPathEnemy = _hullstatus get "reactor" get "path_enemy";

    [QGVAR(AlertAddToSystem), [_alertPathFriendly], _friendlyUnits] call CBA_fnc_targetEvent;
    [QGVAR(AlertAddToSystem), [_alertPathEnemy], _enemyUnits] call CBA_fnc_targetEvent;
};

////////////////////////////////////////////////////////////////////////////////////////////////
// Loadout Unlocking
////////////////////////////////////////////////////////////////////////////////////////////////
private _unlockHash = missionNamespace getVariable QGVAR(unlocked_loadouts);
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

////////////////////////////////////////////////////////////////////////////////////////////////
// Game Ending
////////////////////////////////////////////////////////////////////////////////////////////////
if (_percentHP <= 0) exitWith {
    missionNamespace setVariable [QGVAR(game_state), GAME_STATE_ENDING, true];
    [QGVAR(ExplosionSequence), [_carrier]] call CBA_fnc_globalEvent;
};