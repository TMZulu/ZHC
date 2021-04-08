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

if ((!(IS_ADMIN_LOGGED) && !([player] call FUNC(isZeus)) && GVAR(DebugMode) == 2) || GVAR(DebugMode) == 0) exitwith {hint "Debug Unavailable";};

if (GVAR(Debugging)) then {
    [false] call FUNC(debugDraw);
} else {
    [true] call FUNC(debugDraw);
};
