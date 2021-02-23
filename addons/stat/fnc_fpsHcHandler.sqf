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
 * Public: No
 */
params [["_refreshDelay",10]];

if (hasInterface) exitwith {};

private _position = EGVAR(offload,DataIndex) + 1;//use HC array index
private _sourcestr = format["HC%1", _position];


// if (!isServer) then {
//     if (!isNil "HC1") then {
//         if (!isNull HC1) then {
//             if (local HC1) then {
//                 _sourcestr = "HC1";
//                 _position = 1
//              };
//          };
//      };

//     if (!isNil "HC2") then {
//          if (!isNull HC2) then {
//              if (local HC2) then {
//                 _sourcestr = "HC2";
//                 _position = 2;
//              };
//          };
//      };
//      if (!isNil "HC3") then {
//          if (!isNull HC3) then {
//              if (local HC3) then {
//                 _sourcestr = "HC3";
//                 _position = 3;
//              };
//          };
//      };
//     if (!isNil "HC4") then {
//          if (!isNull HC4) then {
//              if (local HC4) then {
//                 _sourcestr = "HC4";
//                 _position = 4;
//              };
//          };
//      };
//     if (!isNil "HC5") then {
//          if (!isNull HC5) then {
//              if (local HC5) then {
//                 _sourcestr = "HC5";
//                 _position = 5;
//              };
//          };
//      };
// };

GVAR(fpsDisplayHandlerId) = [_sourcestr, _refreshDelay, _position] call FUNC(fpsMonitor);
