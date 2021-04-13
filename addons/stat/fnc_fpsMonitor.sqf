#include "script_component.hpp"
/*
 * Author: TMZulu 
 * Displays fps of server in the bottom left of the map
 * Inspired by KP Liberation https://github.com/KillahPotatoes/KP-Liberation
 *
 * Arguments:
 * 0: Client Name <STRING>
 * 1: Refresh Delay in seconds <NUMBER><OPTIONAL> (default = 10)
 *
 * Return Value:
 * 0: Handler number <NUMBER*>
 *
 * Example:
 * ["Server",15] call mf7_server_fnc_fpsMonitor
 *
 * Public: No
 */
params ["_clientName",["_refreshDelay",10],["_position",0]];

GVAR(fpsMarker) = createMarker [format ["fpsmarker%1", _clientName], [500, 500 + (500 * _position)]];
GVAR(fpsMarker) setMarkerType "mil_start";
GVAR(fpsMarker) setMarkerSize [0.7, 0.7];
GVAR(clientName) = _clientName;
[{

   private _curfps = diag_fps;
   private _localunits = {local _x} count allUnits;

   GVAR(fpsMarker) setMarkerColor "ColorGREEN";
   if (_curfps < 30) then {GVAR(fpsMarker) setMarkerColor "ColorYELLOW";};
   if (_curfps < 20) then {GVAR(fpsMarker) setMarkerColor "ColorORANGE";};
   if (_curfps < 10) then {GVAR(fpsMarker) setMarkerColor "ColorRED";};

   GVAR(fpsMarker) setMarkerText format ["%1: %2 fps, %3 local units", GVAR(clientName), (round (_curfps * 100.0)) / 100.0, _localunits];
 }, _refreshDelay] call CBA_fnc_addPerFrameHandler;
