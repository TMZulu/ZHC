#include "script_component.hpp"
/*
 * Author: TMZulu
 * Spawns group based on data
 *
 * Arguments:
 * 0: ARRAY - Array of Group Data [side, [vehicle, pos], [[unit, pos, loadout, lead],[unit, pos, loadout, lead]]]
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_directSpawn_fnc_remoteSpawnGrp
 *
 */

private _grpData = _this select 0;
private _grpSide = _grpData select 0;
private _grpVeh = _grpData select 1;
private _grpUnits = _grpData select 2;

private _group = creategroup _grpSide;

private ["_unit", "_pos", "_loadout"];
if ((count _grpVeh) == 0 ) then {
	{
		_unit = _x select 0;
		_pos = _x select 1;
		_loadout = _x select 2;

		_unit createUnit [_pos, _group];

		{
			_x addCuratorEditableObjects [_unit, true];
		} forEach allCurators;
		
	} forEach _grpUnits;

	
} else {
	private _veh = (_grpVeh select 0) createVehicle (_grpVeh select 1);
	createVehicleCrew _veh;
	
	{
		_x addCuratorEditableObjects [_veh, true];
	} forEach allCurators;
};

