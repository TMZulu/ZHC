#include "script_component.hpp"
/*
	 * Author: TMZulu
	 * Waits until ai group is local and then regarrisons
	 *
	 * Arguments:
	 * 0: OBJECT - group
	 *
	 * Return Value:
	 * NONE
	 *
	 * Example:
	 * [group1] call zhc_offload_fnc_reGarrison
 */
private _group = _this select 0;

private _timeout = time + GVAR(GarrisonTimeout);

waitUntil {
	sleep 0.5;
	isNull _group || local _group || time >= _timeout
};

if (time >= _timeout) exitWith {
	INFO("Regarrisoning group timed out");
}

if (isNull _group || !local _group) exitWith {};

{
	_x disableAI "PATH";
	_x forceSpeed 0;
} forEach units _group;
