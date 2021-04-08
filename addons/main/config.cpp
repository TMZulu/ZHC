#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {

            "A3_Data_F_Mod_Loadorder",
            // CBA
            "cba_main",
            "cba_xeh"
        };
        author = CSTRING(Author);
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

class CfgMods {
    class zhc {
        dir = "@zhc";
        //picture = "m\zhc\addons\main\700th_logo_fancy.paa";
        action = "https://github.com/TMZulu/ZHC";
        hideName = 0;
        hidePicture = 0;
        name = "ZHC";
    };
};

#include "CfgSettings.hpp"

#include "CfgEventHandlers.hpp"
