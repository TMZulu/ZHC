#include "script_component.hpp"
/*
 * Author: TMZulu
 * Get groups for offload
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_getGroups
 */
private ["_owner","_excluded","_checkGroup"];
{
    _checkGroup = _x;
    _excluded = [_x] call FUNC(checkBad);

    if ((GVAR(HeadlessGrpData) findIf {_x select 0 == _checkGroup} == -1) && (GVAR(ZeusGrpData) findIf {_x select 0 == _checkGroup} == -1) && !_excluded) then {
        GVAR(TransferQueue) pushBackUnique _x;
    };
} forEach allGroups;
