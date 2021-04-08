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
 * [] call zhc_offload_fnc_syncData
 */
params [["_headless",true]];

if (isServer) then { //Server
    if (isRemoteExecuted) then {
        private _client = remoteExecutedOwner;
        if (_headless) then {
            _client publicVariableClient QGVAR(HeadlessLocalCounts);
        } else {
            _client publicVariableClient QGVAR(ZeusGrpData);
            _client publicVariableClient QGVAR(ZeusHeldUnitCounts);
        };
    } else {
        if (_headless) then {
            {
                _x publicVariableClient QGVAR(HeadlessLocalCounts);
            } forEach GVAR(HeadlessIds);
        } else {
            {
                _x publicVariableClient QGVAR(ZeusGrpData);
                _x publicVariableClient QGVAR(ZeusHeldUnitCounts);
            } forEach GVAR(ZeusIds);
        };
    };
};

if (!isServer && !hasInterface) then { //HC
    publicVariableServer QGVAR(HeadlessLocalCounts);
};

if (hasInterface) then { //player Zeus
    publicVariableServer QGVAR(ZeusGrpData);
    publicVariableServer QGVAR(ZeusHeldUnitCounts);
};
