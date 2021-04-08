#include "script_component.hpp"
/*
 * Author: TMZulu
 * Regarrisons AI in a group
 *
 * Arguments:
 * 0: OBJECT - Group
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [group1] call zhc_offload_fnc_reGarrison
 */
private _group = _this select 0;

{
    _x forceSpeed 0;
} forEach units _groupMoving;
