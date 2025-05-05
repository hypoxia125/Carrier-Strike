call CarrierStrike_fnc_InitSettings;
call CarrierStrike_fnc_InitStructs;

// Initialize Game Data
CarrierStrike_GameData = call CarrierStrike_fnc_CreateNamespace;
{ CarrierStrike_GameData setVariable [_x, _y] } forEach CarrierStrike_Struct_GameData;

call CarrierStrike_fnc_InitSiloControlSystem;

// Initialize init queue
call CarrierStrike_fnc_InitQueue;

call CarrierStrike_fnc_InitChatNotificationChannels;
