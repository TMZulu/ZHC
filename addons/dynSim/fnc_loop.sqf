#include "script_component.hpp"
/*
 * Author: TMZulu
 * Primary timing loop for dynamic simulation system
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] spawn zhc_dynSim_fnc_loop
 *
 * Public: No
 */

while {true} do {
	sleep GVAR(CycleDelay);
	[] call FUNC(flagAI);
};