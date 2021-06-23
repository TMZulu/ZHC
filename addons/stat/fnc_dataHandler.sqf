#include "script_component.hpp"
/*
 * Author: TMZulu
 * Server's RPT log data handler updates data recieved from HCs
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call mf7_stat_fnc_dataHandler
 *
 */

sleep 2;
GVAR(Stats)= [];
for "_i" from 0 to count EGVAR(offload,HeadlessArray) do {
	GVAR(Stats) pushBack [];
};


QGVAR(Data) addPublicVariableEventHandler {
	params ["_var", "_data", "_target"];
	_index = (_data select 0);
	if (_index > (count GVAR(Stats) - 1)) then {
		GVAR(Stats) pushback (_data select 1);
	}else {
		GVAR(Stats) set [_index, _data select 1];
	};


};
