#include "script_component.hpp"

// Server Event Handlers
if (isServer) then {
    // Handle commander leaving
    addMissionEventHandler ["OnUserDisconnected", {
        params ["_networkId", "_clientStateNumber", "_clientState"];

        private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
        private _commanders = _commanderData get "commanders";
        private _commanderNames = _commanderData get "commanderNames";

        {
            private _side = _x;
            private _netId = _y;

            if (_networkId == _netId) then {
                _commanders set [_side, "-1"];
                private _commanderName = _commanderNames get _side;
                [QGVAR(HintSilent), [format["Commander %1 has left the game.", _commanderName]]] call CBA_fnc_globalEvent;
                _commanderNames set [_side, ""];
                [QEGVAR(ui,UpdateCommanderNameTopBar), ["", _side], QEGVAR(ui,CommanderNameTopBar)] call CBA_fnc_globalEventJIP;
            };
        } forEach _commanders;

        [QEGVAR(ui,UpdateCommanderMenu)] call CBA_fnc_globalEvent;
    }];

    // Handle commander changing teams
    addMissionEventHandler ["OnUserSelectedPlayer", {
        params ["_networkId", "_playerObject", "_attempts"];

        private _commanderData = missionNamespace getVariable QGVAR(CommanderData);
        private _commanders = _commanderData get "commanders";
        private _commanderNames = _commanderData get "commanderNames";

        {
            private _side = _x;
            private _netId = _y;

            if (_networkId == _netId) then {
                _commanders set [_side, "-1"];
                private _commanderName = _commanderNames get _side;
                [QGVAR(HintSilent), [format["Commander %1 has changed teams.", _commanderName]]] call CBA_fnc_globalEvent;
                _commanderNames set [_side, ""];
                [QEGVAR(ui,UpdateCommanderNameTopBar), ["", _side], QEGVAR(ui,CommanderNameTopBar)] call CBA_fnc_globalEventJIP;
            };
        } forEach _commanders;

        [QEGVAR(ui,UpdateCommanderMenu)] call CBA_fnc_globalEvent;
    }];
};
