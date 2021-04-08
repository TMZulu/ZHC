#include "script_component.hpp"
/*
 * Author: TMZulu
 * Transfers AI for Headless Clients
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_transfer
 */
if (GVAR(HeadlessArray) isEqualTo []) exitWith {};

private ["_groupMoving","_lead","_size","_leadOwner","_groupGarrisoned","_excluded","_hcIndex","_attachments","_prevCount","_HCid","_vehicle","_driver","_groupIndex"];
private _groupArray = GVAR(TransferQueue);//copy current transfer queue
GVAR(TransferQueue) = [];//clear global transfer queue

//settings variable conversion(optimisation)
private _transferLoadout = GVAR(TransferLoadout);
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };

BROADCAST_INFO("Started Transferring");

{
    _HCid = _x;
    GVAR(HeadlessLocalCounts) set [_forEachIndex, (count (allUnits select { owner _x == _HCid }))];
} forEach GVAR(HeadlessIds);

{
    waitUntil {sleep 0.1; !GVAR(FastTransferring)};//hold in case of emergency dump or fast transfer

    _groupMoving = _x;
    _lead = leader _groupMoving;
    _size = count (units _groupMoving);
    _leadOwner = owner _lead;
//    _excluded = [_groupMoving] call FUNC(checkBad);
    _vehicle = vehicle _lead;
    //_driver = driver _vehicle;

    //if (!_excluded) then {

    //check garrison flag
    if ((_groupMoving getVariable ["Achilles_var_inGarrison", false]) || (_groupMoving getVariable ["zen_ai_garrisoned", false]) ||  (_groupMoving getVariable ["ace_ai_garrisoned", false])) then {
        _groupGarrisoned = true;
    } else {
        _groupGarrisoned = false;
    };

    if (GVAR(HeadlessGrpData) findIf {_x select 0 == _groupMoving} == 1) exitwith {
        diag_log format["WARNING: ZHC Main HC Offload Loop. Group:%1 already offloaded but in TransferQueue",str _groupMoving];
        BROADCAST_WARN_1("Group:%1 already offloaded but in TransferQueue",str _groupMoving);
    };
    //GVAR(HeadlessGroups) pushBack _groupMoving;

    _vehicle lock true;
    sleep (GVAR(OffloadDelay)/3);

    _hcIndex = 0;
    _prevCount = 0;
    {
        if (_forEachIndex == 0 || _x < _prevCount) then {
            _hcIndex = _forEachIndex;
            _prevCount = _x;
        };
    } forEach GVAR(HeadlessLocalCounts);

    if (_transferLoadout == 1) then {
        {
            _x setVariable [QGVAR(UnitLoadout), getUnitLoadout _x];
        } forEach units _groupMoving;
    };


    BROADCAST_INFO_2("Transferring group %1 to %2",str _groupMoving, str (GVAR(HeadlessArray) select _hcIndex));
    _groupMoving setGroupOwner (GVAR(HeadlessIds) select _hcIndex);
    sleep (GVAR(OffloadDelay)/3);
    //reapply garrison
    if (_groupGarrisoned) then {
        [_groupMoving] remoteExecCall [QFUNC(reGarrison), GVAR(HeadlessIds) select _hcIndex];
    };

    BROADCAST_INFO_2("Transferred group %1 to %2",str _groupMoving, str (GVAR(HeadlessArray) select _hcIndex));
    sleep (GVAR(OffloadDelay)/3);

    _vehicle lock false;

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

    //GVAR(HeadlessGroups) pushBack _groupMoving;
    //GVAR(HeadlessGroupOwners) pushback (GVAR(HeadlessArray) select _hcIndex);

    GVAR(HeadlessGrpData) pushBack ([_groupMoving, GVAR(HeadlessArray) select _hcIndex]);

    GVAR(HeadlessLocalCounts) set [_hcIndex, (GVAR(HeadlessLocalCounts) select _hcIndex) + _size];

    if (_debugEnabled) then {
        _groupMoving setVariable [QGVAR(OwningClient), (GVAR(HeadlessArray) select _hcIndex), true];
    } else {
        _groupMoving setVariable [QGVAR(OwningClient), (GVAR(HeadlessArray) select _hcIndex)];
    };

//    };

} forEach _groupArray;
BROADCAST_INFO("Completed Transferring");

