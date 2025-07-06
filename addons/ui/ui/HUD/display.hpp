class GVAR(CarrierHUD) {
    idd = IDD_CARRIERHUD;

    duration = 1e11;
    fadeIn = 3;

    onLoad = QUOTE(localNamespace setVariable [ARR_2(QQGVAR(carrierHUD),_this#0)]);
    onUnload = QUOTE(localNamespace setVariable [ARR_2(QQGVAR(carrierHUD),displayNull)]);
    
    class Controls {
        #include "\z\carrierstrike\addons\ui\ui\HUD\UpperHUD\UpperHUD.hpp"
    };
};
