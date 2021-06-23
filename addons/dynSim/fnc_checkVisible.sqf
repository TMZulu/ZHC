#include "script_component.hpp"
/*
 * Author: TMZulu
 * checks if group is visible to player
 *
 * Arguments:
 * 0: GROUP - Group to check
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_dynSim_fnc_checkVisible
 */

params ["_grp"];

{
	_cansee = [objNull, "VIEW"] checkVisibility [eyePos player, eyePos _x];
	if (_cansee == 0) exitwith {true};
} forEach units _grp;

false