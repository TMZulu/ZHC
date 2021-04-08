#include "script_component.hpp"
/*
 * Author: TMZulu
 * Checks if unit has zeus capability
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * 0: <BOOL>
 *
 * Example:
 * [player] call mf7_core_fnc_isZeus
 *
 */
params['_unit'];
private ['_getCurator'];
private _isZeus = false;

{
    if (!isnull (getassignedcuratorunit _x)) then {
        _getCurator = getassignedcuratorunit _x;
        if(_getCurator == _unit)exitWith{
            _isZeus= true;
        };
    };

} foreach allcurators;

_isZeus;
