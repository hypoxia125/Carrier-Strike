class GVAR(ModuleAddReactor): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Add Reactor(s)";
    icon = "a3\modules_f_curator\data\portraitlightning_ca.paa";
    category = QGVAR(carrierstrike_optional);

    function = QFUNC(ModuleAddReactor);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class Side: Combo {
            property = QGVAR(ModuleAddReactor_Side);
            displayName = "Side";
            tooltip = "Determines which side owns this reactor. Can only have one reactor per game.";
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
            "Adds the synchronized reactor to the reactor init system. Only BLUFOR and OPFOR can have reactors and you can have as many as you like!"
        };
        position = 0;
        direction = 0;
    };
};
