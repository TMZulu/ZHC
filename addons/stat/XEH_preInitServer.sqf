#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREPServer.hpp"
PREP_RECOMPILE_END;

// CBA Settings
#include "initSettings.sqf"


["Initialize", [true]] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework and groups led by a player at mission start will be registered

ADDON = true;
