class GVAR(ModuleAddVehicle): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Add Vehicle";
    icon = "a3\data_f_tank\logos\arma3_tank_icon_ca.paa";
    category = QGVAR(carrierstrike_optional);

    function = QFUNC(ModuleAddVehicle);
    functionPriority = 1;
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class Owner: Combo {
            property = QGVAR(ModuleAddVehicle_Owner);
            displayName = "Owner";
            tooltip = "Determines which side or entity 'owns' this vehicle. For silos, this means that they will spawn depending on the current owner of silo.";
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
                class Silo_1 {
                    name = "SILO 1";
                    value = 3;
                };
                class Silo_2 {
                    name = "SILO 2";
                    value = 4;
                };
                class Silo_3 {
                    name = "SILO 3";
                    value = 5;
                };
                class Silo_4 {
                    name = "SILO 4";
                    value = 6;
                };
                class Silo_5 {
                    name = "SILO 5";
                    value = 7;
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
                class Silo {
                    name = "SILO";
                    value = 2;
                };
            };
        };
        class WestType: Edit {
            property = QGVAR(ModuleAddVehicle_WestType);
            displayName = "BLUFOR Owner Vehicle Class";
            tooltip = "Vehicle to spawn if BLUFOR currently owns the position.";
            defaultValue = "''";
            typeName = "STRING";
        };
        class EastType: Edit {
            property = QGVAR(ModuleAddVehicle_EastType);
            displayName = "OPFOR Owner Vehicle Class";
            tooltip = "Vehicle to spawn if OPFOR currently owns the position.";
            defaultValue = "''";
            typeName = "STRING";
        };
        class IndependentType: Edit {
            property = QGVAR(ModuleAddVehicle_IndependentType);
            displayName = "RESISTANCE Owner Vehicle Class";
            tooltip = "Vehicle to spawn if RESISTANCE currently owns the position.";
            defaultValue = "''";
            typeName = "STRING";
        };
        class Dir: Edit {
            property = QGVAR(ModuleAddVehicle_Dir);
            displayName = "Direction";
            tooltip = "Vehicle direction. Place down a vehicle and copy its direction for ease of use.";
            defaultValue = 0;
            typeName = "NUMBER";
        };
        class RespawnTime: Edit {
            property = QGVAR(ModuleAddVehicle_RespawnTime);
            displayName = "Respawn Time";
            tooltip = "Respawn time (s) before current vehicle is checked to see if active. If not, it will be deleted and a new one will spawn at this position.";
            defaultValue = 30;
            typeName = "NUMBER";
        };

        class Expression: Edit {
            control = QUOTE(EditCodeMulti5);
            property = QGVAR(ModuleAddVehicle_Expression);
            displayName = "Post Init Expression";
            tooltip = "Code to execute after spawning the vehicle. Passed arguments: [<newVehicle>, <side>]";
            defaultValue = """true""";
            typeName = "STRING";
            validate = "EXPRESSION";
        };

        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Adds a vehicle to the vehicle respawn system. Do not sync anything to this module in its current state. It can be easier to place an editor object for space checking, just be sure to delete it on game init."
        };
        position = 0;
        direction = 0;
    };
};