#include "script_component.hpp"
/*
 * Author: TMZulu
 * Short Description
 *
 * Arguments:
 * 0: ARRAY - Array of Group Data
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_directSpawn_fnc_handleGroupSpawn
 *
 */

private _grpData = _this select 0;
private _leastLoaded = [] call EFUNC(offload,getLeastLoaded);
private _hcID = EGVAR(offload,HeadlessIds) select _leastLoaded;

[_grpData] remoteExecCall [QFUNC(remoteSpawnGrp), _hcID, false];
