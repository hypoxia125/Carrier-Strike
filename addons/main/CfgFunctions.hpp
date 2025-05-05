class CfgFunctions
{
    class CarrierStrike
    {
        class Game
        {
            file = "\carrierstrike\addons\main\functions\Game";
            class RandomizeWeather {};
        };

        class Init
        {
            file = "\carrierstrike\addons\main\functions\Init";
            class AddToCarrierInitQueue {};
            class AddToReactorInitQueue {};
            class AddToSiloInitQueue {};
            class AddToTurretInitQueue {};
            class InitCarrier {};
            class InitChatNotificationChannels {};
            class InitGame {};
            class InitQueue {};
            class InitReactor {};
            class InitSettings {};
            class InitSilo {};
            class InitSiloControlSystem {};
            class InitStructs {};
            class InitTurret {};
        };

        class Missiles
        {
            file = "\carrierstrike\addons\main\functions\Missiles";
            class InitMissileTarget {};
        };

        class Silo
        {
            file = "carrierstrike\addons\main\functions\Silos";
            class SiloCountdownWarning {};
        };

        class Utils
        {
            file = "carrierstrike\addons\main\functions\Utils";
            class CreateNamespace {};
            class GetData {};
            class SetData {};
        };
    };
};