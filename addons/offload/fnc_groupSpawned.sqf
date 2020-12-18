#include "script_component.hpp"
/*
 * Author: TMZulu
 * runs on every group spawned by Zeus
 *
 * Arguments:
 * 1: CURATOR - Zeus placing
 * 1: GROUP - Group to Check
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call mf7_offload_fnc_groupSpawned
 */

//OBSOLETE


private _curator = _this select 0;
private _group = _this select 1;
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };

if (_debugEnabled) then {
    _group setVariable [QGVAR(OwningClient), "None", true];
} else {
    _group setVariable [QGVAR(OwningClient), "None"];
};

GVAR(TransferQueue) pushback _group;
