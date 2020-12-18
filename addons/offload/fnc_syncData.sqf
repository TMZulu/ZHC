#include "script_component.hpp"
/*
 * Author: TMZulu
 * Sync data across clients for global arrays
 *
 * Arguments:
 * 0: NUMBER - Client ID to sync to
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call mf7_offload_fnc_transfer
 */
params [["_headless",true]];

if (isServer) then { //Server
    if (isRemoteExecuted) then {
        private _client = remoteExecutedOwner;
        if (_headless) then {
            //_client publicVariableClient QGVAR(HeadlessArray);
            //_client publicVariableClient QGVAR(HeadlessIds);
            //_client publicVariableClient QGVAR(HeadlessGroups);
            _client publicVariableClient QGVAR(HeadlessLocalCounts);
            //_client publicVariableClient QGVAR(HeadlessGroupOwners);
        } else {
            //_client publicVariableClient QGVAR(ZeusArray);
            //_client publicVariableClient QGVAR(ZeusIds);
            //_client publicVariableClient QGVAR(ZeusGroups);
            //_client publicVariableClient QGVAR(ZeusGroupOwners);
            _client publicVariableClient QGVAR(ZeusGrpData);
            _client publicVariableClient QGVAR(ZeusHeldUnitCounts);
        };
    } else {
        if (_headless) then {
            {
                //_x publicVariableClient QGVAR(HeadlessArray);
                //_x publicVariableClient QGVAR(HeadlessIds);
                //_x publicVariableClient QGVAR(HeadlessGroups);
                _x publicVariableClient QGVAR(HeadlessLocalCounts);
                //_x publicVariableClient QGVAR(HeadlessGroupOwners);
            } forEach GVAR(HeadlessIds);
        } else {
            {
                //_x publicVariableClient QGVAR(ZeusArray);
                //_x publicVariableClient QGVAR(ZeusIds);
                //_x publicVariableClient QGVAR(ZeusGroups);
                _x publicVariableClient QGVAR(ZeusGrpData);
                //_x publicVariableClient QGVAR(ZeusGroupOwners);
                _x publicVariableClient QGVAR(ZeusHeldUnitCounts);
            } forEach GVAR(ZeusIds);
        };
    };
};

if (!isServer && !hasInterface) then { //HC
    //publicVariableServer QGVAR(HeadlessArray);
    //publicVariableServer QGVAR(HeadlessIds);
    //publicVariableServer QGVAR(HeadlessGroups);
    publicVariableServer QGVAR(HeadlessLocalCounts);
    //publicVariableServer QGVAR(HeadlessGroupOwners);
};

if (hasInterface) then { //player Zeus
    //publicVariableServer QGVAR(ZeusArray);
    //publicVariableServer QGVAR(ZeusIds);
    //publicVariableServer QGVAR(ZeusGroups);
    publicVariableServer QGVAR(ZeusGrpData);
    //publicVariableServer QGVAR(ZeusGroupOwners);
    publicVariableServer QGVAR(ZeusHeldUnitCounts);
};
