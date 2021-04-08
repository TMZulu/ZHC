#include "script_component.hpp"
/*
 * Author: TMZulu
 * Handles emergency dump of ai from either HC or Zeus disconnecting/crashing
 * Freezes all dumped AI and adds them back into the HC system incrementally
 * Prevents server or HC crashing
 *
 * Arguments:
 * 0: ARRAY<GROUP> - Disconnected User's Groups
 * 1: BOOL - Is Headless
 *
 * Return Value:
 * NONE
 *
 */
private _groups = _this select 0;
private _isHC = _this select 1;

if (GVAR(HeadlessArray) isEqualTo []) exitWith {};//no HCs present
waitUntil {sleep 0.5; GVAR(FastTransferring) == false};
GVAR(FastTransferring) = true;

private ["_groupMoving","_lead","_size","_leadOwner","_groupGarrisoned","_excluded","_hcIndex","_attachments","_prevCount","_groupIndex","_prevCount","_curCount","_HCid"];
private _groupArray = _groups;//copy current transfer queue

//settings variable conversion(optimisation)
private _transferLoadout = GVAR(TransferLoadout);
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };

["Zeus or HC Disconnected\nEmergency Offload Engaged"] remoteExec ["hintSilent", -2];//warning message


{
    _HCid = _x;
    GVAR(HeadlessLocalCounts) set [_forEachIndex, (count (allUnits select { owner _x == _HCid }))];
} forEach GVAR(HeadlessIds);

{
    _groupMoving = _x;
    if (!(units _groupMoving isEqualTo [])) then{continue};//skip to next group
    _lead = leader _groupMoving;
    _size = count (units _groupMoving);
    _leadOwner = owner _lead;
    _vehicle = vehicle _lead;
    _vehicle lock true;
    //check garrison flag
    if ((_groupMoving getVariable ["Achilles_var_inGarrison", false]) || (_groupMoving getVariable ["zen_ai_garrisoned", false]) ||  (_groupMoving getVariable ["ace_ai_garrisoned", false])) then {
        _groupGarrisoned = true;
    } else {
        _groupGarrisoned = false;
    };

    _hcIndex = 0;
    _prevCount = 0;
    {
        _curCount = _x;
        if (_forEachIndex == 0 || _curCount < _prevCount) then {
            _hcIndex = _forEachIndex;
            _prevCount = _curCount;
        };
    } forEach GVAR(HeadlessLocalCounts);

    if (_transferLoadout == 1) then {
        {
            _x setVariable [QGVAR(UnitLoadout), getUnitLoadout _x];
        } forEach units _groupMoving;
    };

    _groupMoving setGroupOwner (GVAR(HeadlessIds) select _hcIndex);
    sleep (GVAR(EmergencyOffloadDelay)/3);
    //reapply garrison
    if (_groupGarrisoned) then {
        [_groupMoving] remoteExecCall [QFUNC(reGarrison), GVAR(HeadlessIds) select _hcIndex];
    };

    BROADCAST_INFO_2("Transferred group %1 to %2",str _groupMoving, str (GVAR(HeadlessArray) select _hcIndex));
    sleep (GVAR(EmergencyOffloadDelay)/3);

    if (_transferLoadout > 0) then {
        if (_transferLoadout == 1) then {
            {
                if (uniform _x == "") then {
                    _x setUnitLoadout (_x getVariable [QGVAR(UnitLoadout), typeof _x]);
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

    if (_isHC) then {

        _groupIndex = GVAR(HeadlessGrpData) findIf {_x select 0 == _groupMoving};
        GVAR(HeadlessGrpData) set [_groupIndex, [_groupMoving, GVAR(HeadlessArray) select _hcIndex]];
        GVAR(HeadlessLocalCounts) set [_hcIndex, (GVAR(HeadlessLocalCounts) select _hcIndex) + _size];
    } else {
        //update HC data
        GVAR(HeadlessGrpData) pushBack ([_groupMoving, GVAR(HeadlessArray) select _hcIndex]);
        GVAR(HeadlessLocalCounts) set [_hcIndex, (GVAR(HeadlessLocalCounts) select _hcIndex) + _size];

        //update Zeus data
        _groupIndex = GVAR(ZeusGrpData) findIf {_x select 0 == _groupMoving};
        GVAR(ZeusGrpData) deleteAt _groupIndex;

    };

    if (_debugEnabled) then {
        _groupMoving setVariable [QGVAR(OwningClient), (GVAR(HeadlessArray) select _hcIndex), true];
    } else {
        _groupMoving setVariable [QGVAR(OwningClient), (GVAR(HeadlessArray) select _hcIndex)];
    };

    sleep (GVAR(EmergencyOffloadDelay)/3);

    _vehicle lock false;

} forEach _groupArray;

{
    _x publicVariableClient QGVAR(HeadlessLocalCounts);
} forEach GVAR(HeadlessIds);

["Emergency Offload Complete"] remoteExec ["hintSilent", -2];

GVAR(FastTransferring) = false;
