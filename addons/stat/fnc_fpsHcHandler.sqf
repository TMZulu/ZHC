#include "script_component.hpp"
/*
 * Author: TMZulu
 * Handles the fps display for headless clients
 *
 * Arguments:
 * 0: Refresh Delay in seconds <NUMBER><OPTIONAL> (default = 10)
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [10] call mf7_stat_fnc_fpsHcHandler
 *
 */
params [["_refreshDelay",10]];

if (hasInterface||isServer) exitwith {};

private _position = EGVAR(offload,DataIndex) + 1;//use HC array index
private _sourcestr = format["HC%1", _position];
if (GVAR(EnableFPSCounter)) then  {
	GVAR(fpsDisplayHandlerId) = [_sourcestr, _refreshDelay, _position] call FUNC(fpsMonitor);
};
if (GVAR(DebugRPT) && EGVAR(offload,Enabled)) then  {
	[_sourcestr] call FUNC(syncData);
};