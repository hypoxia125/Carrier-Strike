class CfgMissions {
    class MPMissions {
        class CarrierStrike_Malden_Small
        {
            briefingName = "Carrier Strike - Malden";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Malden_Small.Malden";
        };
        class CarrierStrike_Stratis_Small
        {
            briefingName = "Carrier Strike - Stratis";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Stratis_Small.Stratis";
        };
        class CarrierStrike_Altis_Medium
        {
            briefingName = "Carrier Strike - Altis";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Altis_Medium.Altis";
        };

#if __has_include("\CUP\Vehicles\CUP_Vehicles_Core\stringtable.xml")
        class CarrierStrike_Malden_Small_CUP
        {
            briefingName = "Carrier Strike - Malden (CUP)";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Malden_Small_CUP.Malden";
        };
        class CarrierStrike_Stratis_Small_CUP
        {
            briefingName = "Carrier Strike - Stratis (CUP)";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Stratis_Small_CUP.Stratis";
        };
        class CarrierStrike_Altis_Medium_CUP
        {
            briefingName = "Carrier Strike - Altis (CUP)";
            directory = "z\carrierstrike\addons\missions\mpmissions\CarrierStrike_Altis_Medium_CUP.Altis";
        };
#endif
    };
};