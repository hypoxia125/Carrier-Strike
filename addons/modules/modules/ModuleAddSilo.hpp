class GVAR(ModuleAddSilo): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Add Silo";
    icon = "a3\ui_f_jets\data\gui\cfg\hints\weaponsmissiles_ca.paa";
    category = QGVAR(carrierstrike_required);

    function = QFUNC(ModuleAddSilo);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class SiloNumber: Combo {
            property = QGVAR(ModuleAddReactor_SiloNumber);
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

        class UnlockCount: Edit {
            property = QGVAR(ModuleAddSilo_UnlockCount);
            displayName = "Unlock @ Player Count";
            tooltip = "Unlocks this silo at a certain player count on server. If player count increases past this amount, the silo is unlocked and registered. This is useful during the seeding of the server.";
            defaultValue = 0;
            typeName = "NUMBER";
        };

        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Adds the synchronized silo to the silo init system. You can only have 5 silos total."
        };
        position = 0;
        direction = 0;
    };
};