class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase;
        class ModuleDescription;
    };
    class GVAR(ModuleBase): Module_F {
        author = "Hypoxic";
        scope = 0;
        scopeCurator = 0;
        is3DEN = 0;
        isGlobal = 0;
        isTriggerActivated = 1;
        curatorCanAttach = 0;

        class AttributesBase: AttributesBase {
            class Default;
            class Edit;
            class EditCodeMulti5;
            class EditMulti3;
            class EditMulti5;
            class Combo;
            class Checkbox;
            class CheckboxNumber;
            class ModuleDescription;
            class Units;
        };

        class ModuleDescription: ModuleDescription {
            duplicate = 0;
            duplicateEnabled = "";
            duplicateDisabled = "";
        };
    };

    #include "\z\carrierstrike\addons\modules\modules\ModuleAddCarrier.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleAddMissileTarget.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleAddReactor.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleAddSilo.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleAddTurret.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleAddVehicle.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleCarrierSpeakerPosition.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleEndGameCamera.hpp"
    #include "\z\carrierstrike\addons\modules\modules\ModuleRespawnPosition.hpp"
};