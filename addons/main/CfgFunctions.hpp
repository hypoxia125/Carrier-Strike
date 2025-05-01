class CfgFunctions
{
    class CarrierStrike
    {
        class Init
        {
            file = "\carrierstrike\addons\main\functions\Init";
            class InitializeGame { postInit = 1; };
            class InitializeSettings {};
            class InitializeStructs {};

            class InitializeGameInstance {};
            class InitializeChatNotificationChannels {};
        };

        class Game
        {
            file = "\carrierstrike\addons\main\functions\Game";
            class RandomizeWeather {};
        };

        class Silo
        {
            file = "carrierstrike\addons\main\functions\Silos";
            class InitializeSilo {};
            class InitializeSiloControlSystem {};
            class SiloCountdownWarning {};
        };

        class Utils
        {
            file = "carrierstrike\addons\main\functions\Utils";
            class CreateNamespace {};
        };
    };
};