class GVAR(ModuleEndGameCamera): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - End Game Camera";
    // icon = "";
    category = QGVAR(carrierstrike_optional);

    function = QFUNC(ModuleEndGameCamera);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class Side: Combo {
            property = QGVAR(ModuleEndGameCamera_Side);
            displayName = "Side";
            tooltip = "Camera if the side selected loses.";
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
            "This camera is the camera that is shown during the carrier explosion sequence. The camera target will be the carrier itself. For example, if set to BLUFOR and BLUFOR loses, all players will be shown this camera during the carrier explosion sequence. Get a nice view of your carrier as it explodes."
        };
        position = 1;
        direction = 0;
    };
};