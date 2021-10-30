#include "script_component.hpp"
/*
 * Author: TMZulu
 * Returns least loaded HC
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: NUM - Least Loaded HC Index
 *
 * Example:
 * [] call zhc_offload_fnc_getLeastLoaded
 *
 * Public: Yes
 */

private ["_HCid"];

//update AI counts
{
	_HCid = _x;
	GVAR(HeadlessLocalCounts) set [_forEachIndex, (count (allUnits select { owner _x == _HCid }))];
} forEach GVAR(HeadlessIds);

private _hcIndex = 0;
private _prevCount = 0;
{
	if (_forEachIndex == 0 || _x < _prevCount) then {
		_hcIndex = _forEachIndex;
		_prevCount = _x;
	};
} forEach GVAR(HeadlessLocalCounts);

_hcIndex