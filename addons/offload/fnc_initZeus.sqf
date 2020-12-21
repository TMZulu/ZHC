#include "script_component.hpp"
/*
 * Author: TMZulu
 * Zeus Initialization
 * Adds Zeus client into system or resets its data if reconnecting
 *
 * Arguments:
 * 0: NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call mf7_offload_fnc_initZeus
 */
private _index = -1;

[false] remoteExecCall [QFUNC(syncData), 2];//Grab data from server
//sleep 0.3;

_index = GVAR(ZeusArray) pushBackUnique player;
if (_index != -1) then {//doesnt exist
    //GVAR(ZeusHeldUnitCounts) pushback 0;
    GVAR(ZeusIds) pushback clientOwner;
} else {//exists
    _index = GVAR(ZeusArray) find player;
    //(GVAR(ZeusHeldUnitCounts) select _index) = 0;
    //GVAR(ZeusIds) select _index = clientOwner;
    GVAR(ZeusIds)  set [_index, clientOwner];
};

publicVariable QGVAR(ZeusArray);
publicVariable QGVAR(ZeusIds);

//[] call FUNC(syncData);

GVAR(DataIndex) = _index;

//Clear Zeus Init Eventhandlers
{
    _x removeEventHandler ["CuratorObjectRegistered", _x getVariable [QGVAR(ZeusInitIndex), 0]];
} forEach allCurators;