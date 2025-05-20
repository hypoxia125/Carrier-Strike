class GVAR(ModuleRespawnPosition): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Respawn Position";
    // icon = "";
    category = QGVAR(CarrierStrike);

    function = QFUNC(ModuleRespawnPosition);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    canSetArea = 1;
    canSetAreaShape = 0;
    // canSetAreaHeight = 1;
    class AttributeValues {
        size3[] = {10, 10, 10};
        isRectangle = 0;
    };

    class Attributes: AttributesBase {
        class Side: Combo {
            property = QGVAR(ModuleRespawnPosition_Side);
            displayName = "Side";
            tooltip = "Side respawn position belongs to. Independents CANNOT have carrier spawns.";
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

        class Type: Combo {
            property = QGVAR(ModuleRespawnPosition_Type);
            displayName = "Type";
            tooltip = "Type of respawn position. Independents CANNOT have carrier spawns.";
            defaultValue = 0;
            typeName = "NUMBER";
            class Values {
                class Base {
                    name = "BASE";
                    value = 0;
                };
                class Carrier {
                    name = "CARRIER";
                    value = 1;
                };
            };
        };

        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Creates a respawn area for the side with the given type. For now, until custom respawn system is implimented, radius will be locked at 10 meters. Custom scripting on backend will change this."
        };
        position = 1;
        direction = 1;
    };
};