#include "script_component.hpp"

if (!isServer) exitWith {};

if (!isNil QGVAR(AISystem)) exitWith {};

GVAR(AISystem) = createHashMapObject [[
    ["#type", "AISystem"],
    ["#create", {
        _self call ["SystemStart", []];

        {
            private _side = _x;
            private _groupSize = _self get "m_groupSize";
            private _totalSlots = playableSlotsNumber _side;
            private _totalGroups = ceil (_totalSlots / _groupSize);

            for "_i" from 0 to _totalGroups - 1 do {
                private _AIGroup = createHashMapObject [GVAR(AIGroupBase), [_side, _groupSize]];
                (_self get "m_groups" get _side) pushBack _AIGroup;
            };
        } forEach [west, east, independent];

        private _logString = "AISystem::Constructor | Groups created for each side: [west, %1], [east, %2], [independent, %3]";
        INFO_3(_logString,count (_self get "m_groups" get west),count (_self get "m_groups" get east),count (_self get "m_groups" get independent));
    }],

    ["m_updateRate", 1],
    ["m_frameSystemHandle", -1],

    ["m_groups", createHashMapFromArray [
        [west, []],
        [east, []],
        [independent, []]
    ]],
    ["m_activeUnits", createHashMapFromArray [
        [west, []],
        [east, []],
        [independent, []]
    ]],
    ["m_groupSize", 6],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        {
            private _side = _x;
            private _groups = _y;
            {
                private _group = _x;
                _group call ["Update", [_self get "m_updateRate"]];
            }
        } forEach (_self get "m_groups");
    }],

    //------------------------------------------------------------------------------------------------
    ["SystemStart", {
        private _handle = [{
            params ["_args", "_handle"];
            _args params ["_self"];

            if (!isMultiplayer && isGamePaused) exitWith {};

            _self call ["Update", []];
        }, _self get "m_updateRate", [_self]] call CBA_fnc_addPerFrameHandler;

        LOG_1("%1::SystemStart | System started.",(_self get "#type")#0);

        _self set ["m_frameSystemHandle", _handle];
    }]
]];