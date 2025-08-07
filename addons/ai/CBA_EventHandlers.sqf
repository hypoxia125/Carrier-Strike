#include "script_component.hpp"

[QGVAR(AISettingsWarning), {
    private _westEnabled = [QEGVAR(game,Settings_AllowWestFactionAI)] call CBA_settings_fnc_get;
    private _eastEnabled = [QEGVAR(game,Settings_AllowEastFactionAI)] call CBA_settings_fnc_get;
    private _independentEnabled = [QEGVAR(game,Settings_AllowIndependentFactionAI)] call CBA_settings_fnc_get;

    hintSilent format[LLSTRING(AISettingsWarning), _westEnabled, _eastEnabled, _independentEnabled];
}] call CBA_fnc_addEventHandler;
