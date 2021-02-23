#include "script_component.hpp"
/*
 * Author: TMZulu
 * Initializes Headless Framework
 *
 * Arguments:
 * 0: NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_handleDisconnect
 *
 * Public: No
 */
private _debugEnabled = false;

//disconnect Eventhandler
addMissionEventHandler ["HandleDisconnect", { call FUNC(handleDisconnect) }];

if (GVAR(DebugMode) != 0) then { _debugEnabled = true; };

//All mission groups add to Transfer Queue
{
    if (!(isPlayer leader _x) && !(isNull _x)) then {
        if ([_x] call FUNC(checkBad) && _debugEnabled && !(isPlayer leader _x)) then {
            _x setVariable [QGVAR(OwningClient), "Server", true];
        } else {
            GVAR(TransferQueue) pushBackUnique _x;
        };
    };
} forEach allGroups;

//Spawn main timing loop
[] spawn FUNC(loop);

//sync zeus Groups when changed

QGVAR(ZeusGrpData) addPublicVariableEventHandler {
    if (!GVAR(FastTransferring)) then {
        {
            _x publicVariableClient QGVAR(ZeusGrpData);
        } forEach GVAR(ZeusIds);
    };
};
