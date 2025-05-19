/*
    fn_CarrierDamageDealt
    Locality: Server

    Handles which team takes carrier damage as well as how much. Also triggers end game event if carrier takes lethal damage
*/

#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_side", "_type"];

private _carrier = (GVAR(Game) getVariable QGVAR(carriers)) get _side;

private _currentHp = _carrier getVariable QGVAR(current_hp);

private _damage = switch _type do {
    case "missile": { [QGVAR(Settings_SiloMissileDamage)] call CBA_settings_fnc_get };
    case "reactor": { [QGVAR(Settings_ReactorDestroyedDamage)] call CBA_settings_fnc_get };
};

private _newHp = _currentHp - _damage;
_carrier setVariable [QGVAR(current_hp), _newHP, true];

// TODO: Update UI

if (_newHP <= 0) exitWith {
    // TODO: End Game Sequence
};