class GVAR(ModuleAddTurret): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Add Turret(s)";
    icon = "a3\3den\data\cfg3den\object\iconturret_ca.paa";
    category = QGVAR(carrierstrike_optional);

    function = QFUNC(ModuleAddTurret);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class Side: Combo {
            property = QGVAR(ModuleAddTurret_Side);
            displayName = "Side";
            tooltip = "Determines which side owns this turret.";
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
                class Independent {
                    name = "RESISTANCE";
                    value = 2;
                };
            };
        };

        class MinTurn: Edit {
            property = QGVAR(ModuleAddTurret_MinTurn);
            displayName = "Min Traverse";
            tooltip = "Minimum degrees of traverse of the turret";
            defaultValue = -180;
            typeName = "NUMBER";
        };

        class MaxTurn: Edit {
            property = QGVAR(ModuleAddTurret_MaxTurn);
            displayName = "Max Traverse";
            tooltip = "Maximum degrees of traverse of the turret";
            defaultValue = 180;
            typeName = "NUMBER";
        };

        class MinElev: Edit {
            property = QGVAR(ModuleAddTurret_MinElev);
            displayName = "Min Elevation";
            tooltip = "Minimum degrees of elevation of the turret";
            defaultValue = -90;
            typeName = "NUMBER";
        };

        class MaxElev: Edit {
            property = QGVAR(ModuleAddTurret_MaxElev);
            displayName = "Max Elevation";
            tooltip = "Maxiumum degrees of elevation of the turret";
            defaultValue = 90;
            typeName = "NUMBER";
        };

        class AIType: Combo {
            property = QGVAR(ModuleAddTurret_AIType);
            displayName = "AI Type";
            tooltip = "Type of CarrierStrike AI to apply to this turret.";
            defaultValue = 0;
            typeName = "NUMBER";
            class Values {
                class AA {
                    name = "Anti Air";
                    value = 0;
                };
            };
        };

        class MaxRange: Edit {
            property = QGVAR(ModuleAddTurret_MaxRange);
            displayName = "Maximum Range (m)";
            tooltip = "Sets the maximum range that the turret can engage. The AI will ignore targets further than this range in its brain loop.";
            defaultValue = 1000;
            typeName = "NUMBER";
        };

        class ModuleAddTurret_DestroyPercent: Edit {
            property = QGVAR(ModuleAddTurret_DestroyPercent);
            displayName = "Destroy Percent";
            tooltip = "Destroys this turret when carrier takes x percent damage (0 to 1). Set to 0 to have it last all game.";
            defaultValue = 0.5;
            typeName = "NUMBER";
        };

        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Adds the synchronized turrets to the turret init system. You can have as many turrets as you like. Turrets will be disabled when carrier hull reaches 50%."
        };
        position = 0;
        direction = 0;
    };
};