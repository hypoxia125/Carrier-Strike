#include "script_component.hpp"

params ["_player"];

if (!local _player) exitWith {};
if (!canSuspend) exitWith { _this spawn FUNC(AddTraits) };

sleep 0.5;
private _items = items _player;

if ("Medikit" in _items) then {
    _player setUnitTrait ["medic", true];
};
if ("ToolKit" in _items) then {
    _player setUnitTrait ["engineer", true];
};
if ("MineDetector" in _items) then {
    _player setUnitTrait ["explosiveSpecialist", true];
};
