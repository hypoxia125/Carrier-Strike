class CfgMissions {
    class MPMissions {
        class CarrierStrike_Malden_Monte
        {
            briefingName = "Carrier Strike - Monte";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Malden_Monte.Malden";
        };
        class CarrierStrike_Stratis_MarinaBay
        {
            briefingName = "Carrier Strike - Marina Bay";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Stratis_MarinaBay.Stratis";
        };

#if __has_include("\CUP\Vehicles\CUP_Vehicles_Core\stringtable.xml")
        class CarrierStrike_Malden_Monte_CUP
        {
            briefingName = "Carrier Strike - Monte (CUP)";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Malden_Monte_CUP.Malden";
        };
        class CarrierStrike_Stratis_MarinaBay_CUP
        {
            briefingName = "Carrier Strike - Marina Bay (CUP)";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Stratis_MarinaBay_CUP.Stratis";
        };
#endif
    };
};