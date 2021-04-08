#include "script_component.hpp"
/*
 * Author: TMZulu
 * Handles user disconnect
 *
 * Arguments:
 * 0: OBJECT - User Controlled Units
 * 1: NUMBER - User Client ID
 * 2: STRING - User UID
 * 3: STRING - User Name
 *
 * Return Value:
 * NONE
 *
 */

params ["_unit", "_id", "_uid", "_name","_group","_owner"];
private _index = -1;
private _dumpGroup = [];
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };

if (_unit in GVAR(HeadlessArray)) exitWith {
    _index = GVAR(HeadlessArray) find _unit;
    GVAR(HeadlessLocalCounts) deleteAt _index;
    GVAR(HeadlessArray) deleteAt _index;
    GVAR(HeadlessIds) deleteAt _index;

    {
        _group = _x select 0;
        _owner = _x select 1;
        if (_owner == _unit) then {
            _dumpGroup pushBackUnique _group;
            if (_debugEnabled) then {
                _group setVariable [QGVAR(OwningClient), "None",true];
            } else {
                _group setVariable [QGVAR(OwningClient), "None"];
            };
            BROADCAST_WARN_1("System Dumped: %1", str _group);
        };
    } forEach GVAR(HeadlessGrpData);

    if (!(_dumpGroup isEqualTo [])) then {
        [_dumpGroup, true] spawn FUNC(emergencyDump);
    };
};


if (_unit in GVAR(ZeusArray)) exitWith {
    _index = GVAR(ZeusArray) find _unit;
    GVAR(ZeusHeldUnitCounts) deleteAt _index;
    GVAR(ZeusArray) deleteAt _index;
    GVAR(ZeusIds) deleteAt _index;

    {
        _group = _x select 0;
        _owner = _x select 1;
        if (_owner == _unit) then {
            _dumpGroup pushBackUnique _group;
            if (_debugEnabled) then {
                _group setVariable [QGVAR(OwningClient), "None",true];
            } else {
                _group setVariable [QGVAR(OwningClient), "None"];
            };
            BROADCAST_WARN_1("System Dumped: %1", str _group);
        };
    } forEach GVAR(ZeusGrpData);

    if (!(_dumpGroup isEqualTo [])) then {
        [_dumpGroup, false] spawn FUNC(emergencyDump);
    };
};
