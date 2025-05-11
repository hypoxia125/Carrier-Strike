#include "script_component.hpp"

if (!isNil QGVAR(MissileTrackingSystem)) exitWith {};

GVAR(MissileTrackingSystem) = createHashMapObject [[
    ["#base", GVAR(GameSystem)],
    ["#type", "MissileTrackingSystem"],
    ["#create", {
        _self call ["SystemStart", []];
    }],

    ["m_updateRate", 0],

    //------------------------------------------------------------------------------------------------
    ["Update", {
        private _missiles = _self get "m_entities";
        {
            private _missile = _x;
            private _side = _missile getVariable [QGVAR(side), sideUnknown];

            private _targets = GVAR(Game) getVariable "missile_targets";
            private _target = _targets get _side;
            if (isNil "_target") exitWith {};
            private _targetSide = _target getVariable [QGVAR(side), sideUnknown];

            if (alive _missile) exitWith {};

            [_targetSide, "missile"] call FUNC(CarrierDamageDealt);
            _self call ["Unregister", [_missile]];
        } forEach _missiles;
    }]
]]