class GVAR(ModuleInitGame): GVAR(ModuleBase) {
    scope = 2;
    displayName = "Carrier Strike - Init Game";
    // icon = "";
    category = QGVAR(carrierstrike_required);

    function = QFUNC(ModuleInitGame);
    functionPriority = 1;
    isGlobal = 2;
    isTriggerActivated = 0;
    isDisposable = 1;
    is3DEN = 1;

    class Attributes: AttributesBase{
        class ModuleDescription: ModuleDescription {};
    };

    class ModuleDescription: ModuleDescription {
        description[] = {
            "Initializes the Carrier Strike Gamemode"
        };
        position = 0;
        direction = 0;
    };
};