#include "script_component.hpp"

if (isMultiplayer && GVAR(Enabled)) then {
    [] call FUNC(initOffload);

} else {
    if (GVAR(Enabled) && GVAR(StrtMsg)) then {
    	//Inform players HC is not running
    	systemChat "Headless Client System(ZHC) not Available in Singleplayer";
    };

};
