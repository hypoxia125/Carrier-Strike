#include "script_component.hpp"

params ["_player"];

_player call FUNC(PlayerActions);
_player call FUNC(PlayerEvents);

#define HEIGHTABOVEWATER_CARRIER    24

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The following are work arounds to the vanilla respawn system. This will be removed once custom respawn system is finished
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Skip this bullshit bohemia adding parachute stuff from respawn system
[{
    params ["_player"];
    !isNull objectParent player;
}, {
    params ["_player"];
    private _veh = vehicle _player;
    if (_veh isKindOf "Steerable_Parachute_F") then {
        _player moveOut _veh;
        deleteVehicle _veh;
        _player switchMove "AmovPercMstpSrasWrflDnon";
    }
}, [_player], 1, {}] call CBA_fnc_waitUntilAndExecute;

// Move player if near the silo during a silo spawn
[{
    params ["_player"];

    private _silos = GVAR(Game) getVariable QGVAR(silos);
    _silos findIf {_x distance2D _player <= 10} != -1;
}, {
    params ["_player"];

    private _silos = GVAR(Game) getVariable QGVAR(silos);
    private _index = _silos findIf {_x distance2D _player <= 10};
    if (_index == -1) exitWith {};

    private _silo = _silos # _index;

    private _maxDistance = [QGVAR(Settings_SiloPlayerSpawnDistance)] call CBA_settings_fnc_get;
    private _pos = getPosASL _silo;
    for "_i" from 0 to 1000 do {
        private _candidate = (getPosASL _silo) getPos [random _maxDistance max 10, random 360];
        _candidate = AGLToASL _candidate;

        private _valid = [_candidate, 7, 7] call FUNC(IsSafePos);
        if (_valid) exitWith {
            _pos = ASLToATL _candidate;
        };
    };
    _pos set [2, 0];
    _player setPosATL _pos;
    _player setDir (getDir _player + (_player getRelDir _silo));
}, [_player], 1, {}] call CBA_fnc_waitUntilAndExecute;