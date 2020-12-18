#include "script_component.hpp"
/*
 * Author: TMZulu
 * Headless Initialization
 * Adds headless client into system or resets its data if reconnecting
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call mf7_offload_fnc_initHeadless
 */
private _index = -1;

sleep (random 3);
/*if (clientOwner < 10) then { //sleep delay difference for HC initialization
    sleep (clientOwner);
};*/

[true] remoteExecCall [QFUNC(syncData), 2];//Grab data from server
sleep 0.5;
_index = GVAR(HeadlessArray) pushBackUnique player;
if (_index != -1) then { //exists
    //GVAR(HeadlessLocalCounts) pushback 0;
    GVAR(HeadlessIds) pushback clientOwner;
} else {  //doesnt exist
    _index = GVAR(HeadlessArray) find player;
    //GVAR(HeadlessLocalCounts) set [_index, 0];
    GVAR(HeadlessIds)  set [_index, clientOwner];
};

publicVariable QGVAR(HeadlessArray);
publicVariable QGVAR(HeadlessIds);
//publicVariableServer QGVAR(HeadlessLocalCounts);

//[] call FUNC(syncData);
sleep (5);
if (!(player in GVAR(HeadlessArray))) then {
    [true] remoteExecCall [QFUNC(syncData), 2];//Grab data from server
    sleep 0.5;
    _index = GVAR(HeadlessArray) pushBackUnique player;
    if (_index != -1) then { //exists
        //GVAR(HeadlessLocalCounts) pushback 0;
        GVAR(HeadlessIds) pushback clientOwner;
    } else {  //doesnt exist
        _index = GVAR(HeadlessArray) find player;
        //GVAR(HeadlessLocalCounts) set [_index, 0];
        GVAR(HeadlessIds)  set [_index, clientOwner];
    };

    publicVariable QGVAR(HeadlessArray);
    publicVariable QGVAR(HeadlessIds);

};

GVAR(DataIndex) = _index;

BROADCAST_INFO_1("%1 Initialized",player);
