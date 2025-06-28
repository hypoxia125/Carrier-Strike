# Alpha Version v0.9.1

- Increased range of 3D markers for reactors
- Move seeding notification to server
- Moved Silo UI Enable check to client
- Added Vanilla version of Porto
- Added custom textures for CSAT version of Mora and Littlebird

# Hotfix v0.9.0.1

- AI: Fixed issue where silo priority was not being sorted

# Alpha Version v0.9.0

- Added map: CarrierStrike_Porto_CUP
    - Requires CUP Terrains
- Optimized AI system, now 60% faster on heavy frame
- Added ability to name respawn positions
- Changed default code for AddVehicle module as an example of how to access params
- Default UI when seeding now shows silos as blocked, then unblocked
- Moved seeding notifications from client to server
- Added a fix to a bug in BI's respawn menu (thx charles_b._punchington)
- Silo array is now automatically sorted when added to the silo control system
- Updated Malden maps
    - Now uses the name Monte, which is where the battlefield is located
- Updated Stratis maps
    - Now uses the name Marina Bay, which is where the battlefield is located
- Removed Altis map
    - Needs to be reevaluated based on size of battlefield
- If using description_shared.ext, you now have to use the macros LOADSCREEN and OVERVIEWPICTURE to define the loading image


# Alpha Version v0.8.0

- Added AI Systems
    - AI will now fill player slots (still keep AI disabled in description.ext)
    - Each group has their own personality (Neutral, Offensive, Defensive, Chaotic)
    - AI will sort silo locations by priority algorithm
    - AI will use vehicles nearby (independent AI can steal your vehicles so beware!)

# Alpha Version v0.7.5

- Added CUP Versions of Maps:
    - Malden (Small)
    - Altis (Medium)
    - Stratis (Small)
Note: These will only show if CUP vehicles is loaded (which in turn requires CUP Units, etc). In the future, CUP terrains will also be required for CUP map implimentation

- Fixed wrong side attribute for some vehicles on all maps

# Alpha Version v0.7.4

- Changed Respawn Loadout System
    - Now can have up to 100 tiers
        - Needs a description definition defining how many tiers
            - #define LOADOUT_TIERS 3
    - Tiers unlocked evenly as carriers take damage
        - For instance, 3 tiers, unlocks happen at 66% hp and 33% hp
    - When defining respawn inventories, you now need a side property and a tier property. No longer functions off of classname
        - side = 0; // 0: Opfor, 1: Blufor, 2: GUER
        - tier = 1; // Tiers up to 100
- ModuleAddTurret: Fixed issue with destroy percent property

# Alpha Version v0.7.3

- Added Map: Stratis Small
- Added Map: Altis Medium
- Made carrier escape sequence longer (60s)
- Modified + extended default loadouts
- Kills units/vehicles within initial missile path out of silo before missile can early detonate

# Alpha Version v0.7.2

- Fixed issues with pre-creating large game data hashmap instead of handling them locally
  - Should fix issues with west carrier module not registering data
  - Should fix west carrier vehicles spawning correctly

# Alpha Version v0.7.1

- Added disabled silo icons to top row

# Alpha Version v0.7.0

- Changed Add Vehicle Module
    - Module now functions by syncing the vehicle to grab the position and direction. Module will handle deleting this object from the mission so do not delete the editor vehicle via init attribute.
- Added Seeding Mode
    - Silos will initially be disabled and enable based on the current player count of the match. Once enabled, they will not be disabled, even in the event of a mass leave. This is to funnel players into one spot while the server is seeding. You can customize this player count on a per silo bases via the add silo module.
- Removed extra small version of malden layer now that seeding mode is implimented

# Alpha Version v0.6.3

- Adds NVG to Tier 3 loadouts
- Adds flashlights to all tier loadouts
- Fixed issue that tier 3 was being unlocked before tier 2
- Fixed issue with carrier status update voice lines

# Alpha Version v0.6.2

- Allows HUD to adapt to how many silos are present in the layer
- Added Extra Small Map Layer (Has only 3 silos)

# Alpha Version v0.6.1

- Increased Player Counts to 48/48/24 (120)
- Increased height of spawning aircraft by 0.2m

# Alpha Version v0.6.0

- Adds Rally Point System
    - Placed by squad leaders
    - Requires big enough group (3 players by default)
    - Cooldown between placement
    - Deletes old rally point on creation of new one
    - Deletes rally points if enemy units get nearby (50m by default)
    - Plays a "Beeping" sound that can help enemy units find the rally

# Alpha Version v0.5.0

- Adds weather randomization system
    - Max Humidity + Humidity Overrides allow for realistic levels of overcast, rain, lightning combinations
    - Night chance allows for night games
    - Toggle system to allow rain or fog
    - Ability to change the timescale of the game

# Alpha Version v0.4.4

- Due to major bug with "Roadway" LOD Bounding Boxes, there are large areas of the carrier that you can fall through. Until there is an engine fix, I have added fallthrough panels on the carrier to prevent falling through (they are ugly)
- Added a tank to each main base
- Fixed "Incoming Missile" on missile tracker
- Changed default missile damage from 5 to 2 which will extend the length of the game

# Alpha Version v0.4.3

- Fixed initialization order of modules on dedicated server

# Alpha Version v0.4.2

- Added notification channels for future
- Removed the game namespace, replaced with missionNamespace
- Added player counts and cba help back into diary
- Fixed issues with helis spawning on carrier

# Alpha Version v0.4.1

- Changed: Initialization process
- Added: Init Game Module

# Alpha Version v0.4.0

- Added: End Game Camera Module
- Added: Carrier Speaker Module
- Added: Silo Speaker Module
- Updated: CBA Settings
- Updated: CarrierStrike_Malden_Small.Malden

# Alpha Version v0.3.0

- Added: Add Missile Target Module
- Updated: CarrierStrike_Malden_Small.Malden

# Alpha Version v0.2.0

- Added: Eject Action
- Added: Parachute Action

# Alpha Version v0.1.0

- Initial Release!