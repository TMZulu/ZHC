#include "script_component.hpp"
/*
 * Author: TMZulu
 * Tell Zeus to sync data
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_syncZeus
 */

 //OBSOLETE

  
if (isServer || !hasInterface) exitWith {};//Run on Player only

private _index = GVAR(DataIndex);
private _unitCount = {local _x} count allUnits;

[owner player,false] remoteExecCall [FUNC(syncData), 2];//Grab data from server

//(GVAR(ZeusHeldUnitCounts) select _index) = _unitCount;
GVAR(ZeusHeldUnitCounts) set [_index, _unitCount];

publicVariableServer QGVAR(ZeusHeldUnitCounts);
//[] call FUNC(syncData);
