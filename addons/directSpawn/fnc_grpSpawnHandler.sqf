#include "script_component.hpp"
/*
 * Author: TMZulu
 * Short Description
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_directSpawn_fnc_grpSpawnHandler
 *
 */

{
	_x addEventHandler ["CuratorGroupPlaced", {
		params ["_curator", "_group"];
		private _grpData = [];

		if ((vehicle (leader _group)) != (leader _group)) then {
			private _side = side (leader _group);
			private _veh = vehicle (leader _group);
			private _pos - position _veh;
			_grpData = [_side, [typeOf _veh, _pos], []];
			[_grpData] remoteExecCall [QFUNC(handleGroupSpawn), 2];
			
			_group deleteGroupWhenEmpty true;
			{_veh deleteVehicleCrew _x} forEach crew _veh;
			deleteVehicle _veh;
			

		} else {

			private ["_pos","_unit"];
			
			private _side = side (leader _group);
			private _unitData = [];
			{
				_pos = position _x;
				_unit = typeOf _x;
				_unitData pushBack [_unit, _pos, "", (_x == leader _group)];

			} forEach units _group;

			_group deleteGroupWhenEmpty true;
			{
				deleteVehicle _x;
			} forEach units _group;

			_grpData = [_side, [], _unitData];
			[_grpData] remoteExecCall [QFUNC(handleGroupSpawn), 2];

		};

	}];

} forEach allCurators;

