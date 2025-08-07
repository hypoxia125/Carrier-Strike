class GVAR(CommanderMenu) {
    idd = IDD_COMMANDERMENU;
    
    onLoad = QUOTE(call FUNC(UpdateCommanderMenu));

    class Controls {
        #include "\z\carrierstrike\addons\ui\ui\dialogs\commandermenu\commandermenu.hpp"
    };
};
