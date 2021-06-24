#include "script_component.hpp"
/*
 * Author: TMZulu
 * Toggle Debug mode for clients
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 */

if ((!(IS_ADMIN_LOGGED) && !([player] call FUNC(isZeus)) && GVAR(DebugMode) == 2 && GVAR(debugGuids) == "") || GVAR(DebugMode) == 0) exitwith {hint "Debug Unavailable";};

if (GVAR(debugGuids) != "" && !(IS_ADMIN_LOGGED) && !([player] call FUNC(isZeus)) && GVAR(DebugMode) == 2) then {
    private _allowed = false;
    {
        if (_x == getPlayerUID player) then { 
            _allowed = true;
            break 
        };
    } forEach (GVAR(debugGuids) splitString "', ");
    if (!allowed) exitWith {hint "Debug Unavailable";};
};

if (GVAR(Debugging)) then {
    [false] call FUNC(debugDraw);
} else {
    [true] call FUNC(debugDraw);
};
