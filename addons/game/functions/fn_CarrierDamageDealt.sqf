/*
    fn_CarrierDamageDealt
    Locality: Server

    Handles which team takes carrier damage as well as how much. Also triggers end game event if carrier takes lethal damage
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_side", "_type"];

if (GVAR(Game) getVariable QGVAR(game_state) == "ENDING") exitWith {};

private _carrier = (GVAR(Game) getVariable QGVAR(carriers)) get _side;
private _maxHP = _carrier getVariable QGVAR(max_hp);
private _currentHp = _carrier getVariable QGVAR(current_hp);

private _damage = switch _type do {
    case "missile": { [QGVAR(Settings_SiloMissileDamage)] call CBA_settings_fnc_get };
    case "reactor": { [QGVAR(Settings_ReactorDestroyedDamage)] call CBA_settings_fnc_get };
};

private _newHp = _currentHp - _damage;
_carrier setVariable [QGVAR(current_hp), _newHP, true];

[QEGVAR(ui,HUDUpdateCarrierStatus), [_side, _newHp / _maxHP, 1]] call CBA_fnc_globalEvent;

if (_newHP <= 0) exitWith {
    GVAR(Game) setVariable [QGVAR(game_state), "ENDING", true];
    [QGVAR(ExplosionSequence), [_carrier]] call CBA_fnc_globalEvent;
};