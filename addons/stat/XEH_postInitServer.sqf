#include "script_component.hpp"

LOG("Starting mission framework server initialization");
if (GVAR(EnableFPSCounter)) then {
    GVAR(fpsDisplayHandlerId) = ["Server",10] call FUNC(fpsMonitor);
};

if (GVAR(DebugRPT) && EGVAR(offload,Enabled) && isMultiplayer) then  {
	GVAR(fpsRptHandlerId) = [] spawn FUNC(dataHandler);
    ["Server", GVAR(RPTFreq)] call FUNC(fpsLogToRpt);
};


mf7_SERVER_INIT = true;



publicVariable "mf7_SERVER_INIT";

mf7_FULL_SERVER_VERSION = QUOTE(VERSION);

publicVariable "mf7_FULL_SERVER_VERSION";
