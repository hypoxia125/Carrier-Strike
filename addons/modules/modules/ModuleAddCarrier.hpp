class GVAR(ModuleAddCarrier): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Add Carrier";
    // icon = "";
    category = QGVAR(CarrierStrike);

    function = QFUNC(ModuleAddCarrier);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class Side: Combo {
            property = QGVAR(ModuleAddCarrier_Side);
            displayName = "Side";
            tooltip = "Determines which side owns this carrier. Can only have one carrier per game.";
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
            "Adds the synchronized carrier to the carrier init system. Only BLUFOR and OPFOR can have a carrier and they can have only one!"
        };
        position = 0;
        direction = 0;
    };
};