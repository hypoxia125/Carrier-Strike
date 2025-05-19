class CarrierHUD {
    idd = IDD_CARRIERHUD;

    duration = 1e11;

    onLoad = "uiNamespace setVariable ['carrierstrike_main_carrierHUD', _this select 0]";
    onUnload = "uiNamespace getVariable ['carrierstrike_main_carrierHUD', displayNull]";
    
    class Controls {
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\UpperHUD.hpp"
    };
};