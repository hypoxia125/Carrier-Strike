#include "script_component.hpp"

#ifndef MISSION_NAME
    #define MISSION_NAME            "Carrier Strike"
#endif
#ifndef MISSION_DESCRIPTION
    #define MISSION_DESCRIPTION     "Two teams battle over control of Anti-Carrier Missile Silos, aiming for the destruction of the opposing team's carrier. Beware, a rebellion has formed to disrupt the battlefield."
#endif
#ifndef LOADSCREEN
    #define LOADSCREEN              "\z\carrierstrike\addons\common\data\img\loadingscreen.jpg"
#endif
#ifndef OVERVIEWPICTURE
    #define OVERVIEWPICTURE         "\z\carrierstrike\addons\common\data\img\loadingscreen.jpg"
#endif

#ifndef LOADOUT_TIERS
    #define LOADOUT_TIERS     3
#endif
loadout_tiers = LOADOUT_TIERS;

class CfgRoles {
    #ifdef LOADOUT_PRESET_VANILLA
        #include "\z\carrierstrike\addons\missions\loadouts\vanilla\CfgRoles.hpp"
    #endif

    #ifdef LOADOUT_PRESET_CUP
        #include "\z\carrierstrike\addons\missions\loadouts\cup\CfgRoles.hpp"
    #endif
};

class CfgRespawnInventory {
    #ifdef LOADOUT_PRESET_VANILLA
        #include "\z\carrierstrike\addons\missions\loadouts\vanilla\CfgRespawnInventory.hpp"
    #endif

    #ifdef LOADOUT_PRESET_CUP
        #include "\z\carrierstrike\addons\missions\loadouts\cup\CfgRespawnInventory.hpp"
    #endif
};

author = "Hypoxic";
onLoadName = MISSION_NAME;
onLoadMission = MISSION_DESCRIPTION;
briefingName = MISSION_NAME;
loadScreen = LOADSCREEN;
overviewPicture = OVERVIEWPICTURE;
overviewText = MISSION_DESCRIPTION;

class Header {
    gameType = "CarrierStrike";
    minPlayers = 1;
    maxPlayers = 120;
};

respawn = "BASE";
respawnDelay = 15;
respawnDialog = 0;
respawnTemplates[] = {"MenuPosition", "MenuInventory"};
respawnOnStart = 1;

aiKills = 1;
briefing = 0;
debriefing = 1;
disabledAI = 1;
enableDebugConsole = 1;
joinUnassigned = 0;
saving = 0;
skipLobby = 0;

corpseManagerMode = 1;
corpseLimit = 15;
corpseRemovalMinTime = 10;
corpseRemovalMaxTime = 3600;
disposalCheckPeriod = 10;
minPlayerDistance = 50;

weaponholderManagerMode = 1;
weaponholderLimit = 50;
weaponholderRemovalMinTime = 60;
weaponholderRemovalMaxTime = 3600;

wreckManagerMode = 1;
wreckLimit = 15;
wreckRemovalMinTime = 10;
wreckRemovalMaxTime = 3600;

class CfgDebriefing {
	class Win {
        title = "Victory!";
        description = "This is just a placeholder until I get the end game menus created...";
        picture = "";
    };
	class Win_West: Win {
		title = "Blufor Victory!";
		picture = "Flag_NATO";
	};

    class Win_East: Win {
        title = "Opfor Victory!";
        picture = "Flag_CSAT";
    };
};

#include "Params.hpp"
