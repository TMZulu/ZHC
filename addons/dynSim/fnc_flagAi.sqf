#include "script_component.hpp"
/*
 * Author: TMZulu
 * AI flagging loop
 *
 * Arguments:
 * 0: NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_dynSim_fnc_flagAi
 */
private ["_excluded"];
private _grpList = allGroups select {! _x getVariable [QGVAR(DynSet), false] };

{
	_excluded = [_x] call EFUNC(offload,checkBad);
	if (!_exluded) then {
		_x enableDynamicSimulation;
		_x setVariable [QGVAR(DynSet), true];
	} else {
		_x setVariable [QGVAR(DynSet), true];
	};
	
} forEach _grpList;