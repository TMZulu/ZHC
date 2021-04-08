#include "script_component.hpp"
/*
 * Author: TMZulu
 * Rebalance Headless Clients
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_rebalance
 */
if (GVAR(HeadlessArray) isEqualTo []) exitWith {
    BROADCAST_WARN("Rebalance called without an HC connected");
};

BROADCAST_INFO("Rebalance started");
private ["_maxHC","_minHC","_diff","_i","_groupMoving","_groupIndex","_prevCountMax","_prevCountMin", "_minHCName","_maxHCName","_HCid","_groupGarrisoned","_group","_owner", "_scriptID"];
private _balanced = false;

//settings variable conversion(optimisation)
private _transferLoadout = GVAR(TransferLoadout);
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then { _debugEnabled = true; };


while {!_balanced} do {
    waitUntil {sleep 0.1; !GVAR(FastTransferring)};//hold in case of emergency dump or fast transfer
    {
        _HCid = _x;
        GVAR(HeadlessLocalCounts) set [_forEachIndex, (count (allUnits select { owner _x == _HCid }))];
    } forEach GVAR(HeadlessIds);

    //get most loaded
    _maxHC = 0;
    _prevCountMax = 0;
    {
        if ((_forEachIndex == 0) || (_x > _prevCountMax)) then {
            _maxHC = _forEachIndex;
            _prevCountMax = _x;
        };
    } forEach GVAR(HeadlessLocalCounts);

    //get least loaded
    _minHC = 0;
    _prevCountMin = 0;
    {
        if ((_forEachIndex == 0) || (_x < _prevCountMin)) then {
            _minHC = _forEachIndex;
            _prevCountMin = _x;
        };
    } forEach GVAR(HeadlessLocalCounts);

    _diff = (_prevCountMax - _prevCountMin);

    if (_diff > 1) then {
        _scriptID  = [] spawn FUNC(cleanup);//clear empty groups
        waitUntil {sleep 1; scriptDone _scriptID};//wait till clean finishes

        _maxHCName = GVAR(HeadlessArray) select _maxHC;
        _minHCName = GVAR(HeadlessArray) select _minHC;

        _groupMoving = grpNull;
        //find a group

        {
            _group = _x select 0;
            _owner = _x select 1;
            if (_owner isEqualTo _maxHCName) then {
                if (count units _group <= _diff/2) exitWith {
                    _groupMoving = _group;
                    _groupIndex = _forEachIndex;
                    //(GVAR(HeadlessLocalCounts) select _maxHC) = (GVAR(HeadlessLocalCounts) select _maxHC) - (count units _x);
                    GVAR(HeadlessLocalCounts) set [_maxHC, (GVAR(HeadlessLocalCounts) select _maxHC) - (count units _group)];
                };
            };
        } forEach GVAR(HeadlessGrpData);

        //no transferrable group
        if (isNull _groupMoving) exitwith { _balanced = true };

        //variables
        _lead = leader _groupMoving;
        _vehicle = vehicle _lead;

        //check garrison
        if ((_groupMoving getVariable ["Achilles_var_inGarrison", false]) || (_groupMoving getVariable ["zen_ai_garrisoned", false]) ||  (_groupMoving getVariable ["ace_ai_garrisoned", false])) then {
            _groupGarrisoned = true;
        } else {
            _groupGarrisoned = false;
        };

        //save loadouts
        if (_transferLoadout == 1) then {
            {
                _x setVariable [QGVAR(UnitLoadout), getUnitLoadout _x];
            } forEach units _groupMoving;
        };

        _vehicle lock true;
        sleep (GVAR(OffloadDelay)/3);
        _groupMoving setGroupOwner (GVAR(HeadlessIds) select _minHC);

        //reapply garrison
        if (_groupGarrisoned) then {
            [_groupMoving] remoteExecCall [QFUNC(reGarrison), GVAR(HeadlessIds) select _minHC];
        };

        sleep (GVAR(OffloadDelay)/3);

        //reapply loadouts
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
        GVAR(HeadlessGrpData) set [_groupIndex, [_groupMoving, _minHCName]];
        //GVAR(HeadlessGroupOwners) set [_groupIndex, _minHCName];
        //(GVAR(HeadlessLocalCounts) select _minHC) = (GVAR(HeadlessLocalCounts) select _minHC) + (count units _groupMoving);
        GVAR(HeadlessLocalCounts) set [_minHC, (GVAR(HeadlessLocalCounts) select _minHC) + (count units _groupMoving)];

        if (_debugEnabled) then {
            _groupMoving setVariable [QGVAR(OwningClient), _minHCName, true];
        } else {
            _groupMoving setVariable [QGVAR(OwningClient), _minHCName];
        };
        BROADCAST_INFO_1("Moved group: %1",str _groupMoving);
        sleep (GVAR(OffloadDelay)/3);
        _vehicle lock false;
    } else {
        _balanced = true;
        BROADCAST_INFO("Balanced");
    };
};

BROADCAST_INFO("Rebalance Complete");
