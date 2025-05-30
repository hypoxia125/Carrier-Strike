class GVAR(ModuleCarrierSpeaker): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Carrier Speaker";
    icon = "a3\modules_f_curator\data\portraitsound_ca.paa";
    category = QGVAR(carrierstrike_optional);

    function = QFUNC(ModuleCarrierSpeaker);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class Side: Combo {
            property = QGVAR(ModuleCarrierSpeaker_OwnerSide);
            displayName = "Owner Side";
            tooltip = "Side that owns this speaker position.";
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
            "Creates a position that carrier alarms/notifications will be sent from. Use as many of these positions as you like. If you use a very large object, maybe one with rooms, you might want to place lots of these for an authentic experience for players."
        };
        position = 1;
        direction = 0;
    };
};