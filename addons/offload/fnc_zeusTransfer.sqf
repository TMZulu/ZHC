#include "script_component.hpp"
/*
 * Author: TMZulu
 * Transfers AI to Zeus for holding
 *
 * Arguments:
 * 0: OBJECT - Zeus Calling
 * 1: ARRAY[GROUPS] - List of groups
 * 3: INT - Zeus data array index
 *
 * Return Value:
 * NONE
 *
 */
private _who = _this select 0;
private _groups = _this select 1;
private _dataIndex = _this select 2;
private ["_groupMoving","_lead","_groupGarrisoned","_groupIndex"];

private _transferLoadout = GVAR(TransferLoadout);
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };

GVAR(FastTransferring) = true;

{
    _groupMoving = _x;

    if(isNull _groupMoving) then {continue };

    _lead = leader _groupMoving;
    _size = count (units _groupMoving);
    _leadOwner = owner _lead;
    //_excluded = [_groupMoving] call FUNC(checkBad);
    _vehicle = vehicle _lead;
    _vehicle lock true;
    //check garrison flag
    if ((_groupMoving getVariable ["Achilles_var_inGarrison", false]) || (_groupMoving getVariable ["zen_ai_garrisoned", false]) ||  (_groupMoving getVariable ["ace_ai_garrisoned", false])) then {
        _groupGarrisoned = true;
    } else {
        _groupGarrisoned = false;
    };

    if (_transferLoadout == 1) then {
        {
            _x setVariable [QGVAR(UnitLoadout), getUnitLoadout _x];
        } forEach units _groupMoving;
    };

    _groupMoving setGroupOwner _who;

    //reapply garrison
    if (_groupGarrisoned) then {
        [_groupMoving] remoteExecCall [QFUNC(reGarrison), _who];
    };
    BROADCAST_INFO_1("Transferred to Zeus: %1",str _groupMoving);
    sleep (GVAR(OffloadDelay)/2);

    if (_transferLoadout > 0) then {
        if (_transferLoadout == 1) then {
            {
                if (uniform _x == "") then {
                    _x setUnitLoadout (_x getVariable [GVAR(UnitLoadout), typeof _x]);
                };
            } forEach units _groupMoving;
        } else {
            {
                if (uniform _x == "") then {
                    _x setUnitLoadout (typeof _x);
                };
            } forEach units _groupMoving;
        };
    };

    _hcIndex = GVAR(HeadlessIds) find _leadOwner;
    _groupIndex = GVAR(HeadlessGrpData) findIf {_x select 0 == _groupMoving};
    if (_groupIndex != -1) then {
        GVAR(HeadlessGrpData) deleteAt _groupIndex;
        GVAR(HeadlessLocalCounts) set [_hcIndex, (GVAR(HeadlessLocalCounts) select _hcIndex) - _size];
    };

    GVAR(ZeusGrpData) pushBack ([_groupMoving, GVAR(ZeusArray) select _dataIndex]);
    GVAR(ZeusHeldUnitCounts) set [_dataIndex, (GVAR(ZeusHeldUnitCounts) select _dataIndex) + _size];

    if (_debugEnabled) then {
        _groupMoving setVariable [QGVAR(OwningClient), (GVAR(ZeusArray) select _dataIndex), true];
    } else {
        _groupMoving setVariable [QGVAR(OwningClient), (GVAR(ZeusArray) select _dataIndex)];
    };

    sleep (GVAR(OffloadDelay)/2);
    _vehicle lock false;

} forEach _groups;

{
    _x publicVariableClient QGVAR(ZeusGrpData);
} forEach GVAR(ZeusIds);

GVAR(FastTransferring) = false;

