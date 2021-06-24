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
private ["_excluded","_visible"];
private _grpList = allGroups select {! (_x getVariable [QGVAR(DynSet), false]) };

{
	_excluded = [_x] call EFUNC(offload,checkBad);
	if (!_excluded) then {
		
		_visible = [_x] call FUNC(checkVisible);
		if (_visible) then {
			_x setVariable [QGVAR(DynSet), false];
			continue
		};

		_x enableDynamicSimulation true;
		_x setVariable [QGVAR(DynSet), true];

		
	} else {
		_x setVariable [QGVAR(DynSet), true];
	};
	
} forEach _grpList;