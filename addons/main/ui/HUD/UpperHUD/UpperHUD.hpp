class UpperHUD: RscControlsGroupNoScrollbars {
    idc = IDC_UPPERHUD;

    x = QUOTE(UPPERHUD_X * GRID_W + CENTER_X);
    y = QUOTE(UPPERHUD_Y * GRID_H + GRID_Y);
    w = QUOTE(UPPERHUD_W * GRID_W);
    h = QUOTE(UPPERHUD_H * GRID_H);

    class controls {
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\Background.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\CarrierBlueDark.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\CarrierBlueLightGroup.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\CarrierRedDark.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\CarrierRedLightGroup.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloGrey_1.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloGrey_2.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloGrey_3.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloGrey_4.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloGrey_5.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloBlueGroup_1.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloBlueGroup_2.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloBlueGroup_3.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloBlueGroup_4.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloBlueGroup_5.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloRedGroup_1.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloRedGroup_2.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloRedGroup_3.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloRedGroup_4.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloRedGroup_5.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloCD_1.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloCD_2.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloCD_3.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloCD_4.hpp"
        #include "\z\carrierstrike\addons\main\ui\HUD\UpperHUD\SiloCD_5.hpp"
    };
};