#include "script_component.hpp"
/*
 * Author: TMZulu
 * Flags Zeus's selected unit for tranfer back to zeus
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_zeusHold
 */
if (!([player] call FUNC(isZeus))) exitwith {};//if not zeus, exit
if (!GVAR(EnableZeusHolding)) exitWith {};//if holding function disabled exit

private ['_lead','_groupMoving','_groupIndex'];

private _index = GVAR(DataIndex);
private _allSelected = curatorSelected;
private _selectedGroups = _allSelected select 1;
private _who = clientOwner;
private _held = false;
private _heldOther = 0;
private _heldCount = 0;
private _releasedCount = 0;
private _heldCountUnits = 0;
private _releasedCountUnits = 0;
private _groups = [];
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };
[false] remoteExecCall [QFUNC(syncData), 2];//Grab data from server
sleep (0.1);
//processing
{
    _groupMoving = _x;
    _lead = leader _x;
    if (_x in GVAR(LocalHeldGroups) || (GVAR(ZeusGrpData) findIf {_x select 0 == _groupMoving} != -1) || isPlayer _lead) then {
        _held = true;
    } else {
        _held = false;
    };

    if (!_held) then {

        GVAR(LocalHeldGroups) pushBack _x;
        INC(_heldCount);
        _heldCountUnits = _heldCountUnits + count units _x;
        _groups pushback _x;

    } else {
        if (!(_x in GVAR(LocalHeldGroups)) || isPlayer _lead) then {
            INC(_heldOther);
        } else {

            GVAR(LocalHeldGroups) deleteAt (GVAR(LocalHeldGroups) find _groupMoving);
            _groupIndex = GVAR(ZeusGrpData) findIf {_x select 0 == _groupMoving};
            GVAR(ZeusGrpData) deleteAt _groupIndex;

            if (_debugEnabled) then {
                _groupMoving setVariable [QGVAR(OwningClient), "None", true];
            };

            INC(_releasedCount);
            _releasedCountUnits = _releasedCountUnits + count units _x;
        };
    };
} forEach _selectedGroups;
systemChat format ["%1 Groups With %2 Units Flagged for Transfer to Local Machine.", _heldCount, _heldCountUnits];
systemChat format ["%1 Groups With %2 Units Released Back to Headless Client.", _releasedCount, _releasedCountUnits];
systemChat format ["%1 Groups Unable to be Flagged. Held by Another Curator or Player.", _heldOther];

publicVariableServer QGVAR(ZeusGrpData);

[_who, _groups, GVAR(DataIndex)] remoteExec [QFUNC(zeusTransfer), 2, false];
