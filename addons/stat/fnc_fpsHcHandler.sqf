#include "script_component.hpp"
/*
 * Author: TMZulu
 * Handles the fps display for headless clients (5 max)
 *
 * Arguments:
 * 0: Refresh Delay in seconds <NUMBER><OPTIONAL> (default = 10)
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [10] call mf7_server_fnc_fpsHcHandler
 *
 */
params [["_refreshDelay",10]];

if (hasInterface) exitwith {};

private _position = EGVAR(offload,DataIndex) + 1;//use HC array index
private _sourcestr = format["HC%1", _position];

GVAR(fpsDisplayHandlerId) = [_sourcestr, _refreshDelay, _position] call FUNC(fpsMonitor);
