#include "script_component.hpp"
/*
 * Author: TMZulu
 * Tell HCs to sync needed data
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_syncHCs
 */

 //OBSOLETE

  
if (isServer || hasInterface) exitWith {};//Run on HC only

private _hcIndex = GVAR(DataIndex);
private _unitCount = {local _x} count allUnits;
sleep (random 1);

[true] remoteExecCall [QFUNC(syncData), 2];//Grab data from server

//(GVAR(HeadlessLocalCounts) select _hcIndex) = _unitCount;
GVAR(HeadlessLocalCounts) set [_hcIndex, _unitCount];

publicVariableServer QGVAR(HeadlessLocalCounts);
//[] call FUNC(syncData);
