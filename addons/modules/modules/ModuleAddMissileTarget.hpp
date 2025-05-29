class GVAR(ModuleAddMissileTarget): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Add Missile Target";
    icon = "a3\ui_f\data\gui\cfg\hints\missile_seeking_ca.paa";
    category = QGVAR(carrierstrike_required);

    function = QFUNC(ModuleAddMissileTarget);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class OwnerSide: Combo {
            property = QGVAR(ModuleAddMissileTarget_OwnerSide);
            displayName = "Owner Side";
            tooltip = "This target will be where the opposing teams missile lock and strike.";
            defaultValue = 1;
            typeName = "NUMBER";
            class Values {
                class West {
                    name = "BLUFOR";
                    value = 1;
                };
                class East {
                    name = "OPFOR";
                    value = 0;
                };
            };
        };

        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Creates the target for the opposing team's missiles. This should be placed at the location of the carrier that you want missiles to hit. It needs to be somewhere the missile can collide with something and explode. You can only have 1 of these per side."
        };
        position = 1;
        direction = 0;
    };
};