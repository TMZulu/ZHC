// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX m
#define PREFIX zhc

#include "\m\zhc\addons\main\script_version.hpp"

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION_PLUGIN MAJOR.MINOR.PATCHLVL.BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.94
#define REQUIRED_CBA_VERSION {3,11,1}

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(ZHC - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(ZHC - COMPONENT)
#endif
