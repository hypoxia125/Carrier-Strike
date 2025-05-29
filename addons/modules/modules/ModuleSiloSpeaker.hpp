class GVAR(ModuleSiloSpeaker): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Silo Speaker";
    icon = "a3\modules_f_curator\data\portraitsound_ca.paa";
    category = QGVAR(carrierstrike_optional);

    function = QFUNC(ModuleSiloSpeaker);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class SiloNumber: Combo {
            property = QGVAR(ModuleSiloSpeaker_SiloNumber);
            displayName = "Silo Number";
            tooltip = "Determines the number of the silo.";
            defaultValue = 1;
            typeName = "NUMBER";
            class Values {
                class One {
                    name = "1";
                    value = 1;
                };
                class Two {
                    name = "2";
                    value = 2;
                };
                class Three {
                    name = "3";
                    value = 3;
                };
                class Four {
                    name = "4";
                    value = 4;
                };
                class Five {
                    name = "5";
                    value = 5;
                };
            };
        };

        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Creates a position that silo alarms/notifications will be sent from. The silo itself is automatically included as a position, so these are extra. Use as many of these positions as you like."
        };
        position = 1;
        direction = 0;
    };
};