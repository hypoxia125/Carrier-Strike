#include "script_component.hpp"
#include "\z\carrierstrike\addons\ui\A3_IDDs.hpp"

params ["_control"];

private _commanders = _commanderData get "commanders";
private _commander = _commanders get (side group player);

if (_commander == -1) then {
    // apply for commander
} else {
    // mutiny commander
};