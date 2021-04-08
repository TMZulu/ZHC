#include "script_component.hpp"
/*
 * Author: TMZulu
 * Clean up empty groups and clean data arrays
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 */

private ["_delete","_checkGroup","_dataIndex"];

//clean up groups
{
    //_delete = false;
    _checkGroup = _x;

    //check if groups are empty
    if (units _checkGroup isEqualTo []) then
    {
        deleteGroup _x;
        //_delete = true;

        //clean from Data arrays
        _dataIndex = GVAR(HeadlessGrpData) findIf {_x select 0 == _checkGroup};
        if (_dataIndex != -1) exitWith {
            GVAR(HeadlessGrpData) deleteAt _dataIndex
        };

        _dataIndex = GVAR(ZeusGrpData) findIf {_x select 0 == _checkGroup};
        if (_dataIndex != -1) exitWith {
            GVAR(ZeusGrpData) deleteAt _dataIndex
        };
    };

    //clean from Data arrays
    // if (_delete) then {
    //     _dataIndex = GVAR(HeadlessGrpData) findIf {_x select 0 == _checkGroup};
    //     if (_dataIndex != -1) exitWith {
    //         GVAR(HeadlessGrpData) deleteAt _dataIndex
    //     };

    //     _dataIndex = GVAR(ZeusGrpData) findIf {_x select 0 == _checkGroup};
    //     if (_dataIndex != -1) exitWith {
    //         GVAR(ZeusGrpData) deleteAt _dataIndex
    //     };

    // };

}forEach allGroups;
