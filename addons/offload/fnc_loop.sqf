#include "script_component.hpp"
/*
 * Author: TMZulu
 * Primary timing loop for entire HC system
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] spawn zhc_offload_fnc_loop
 *
 * Public: No
 */

private ["_scriptHandle","_rebalanceTime"];

_rebalanceTime = time + 480;

sleep GVAR(StartDelay);

["ZHC Initialized"] remoteExec ["hint", -2, true];

while {GVAR(Enabled)} do {
    BROADCAST_INFO("Cycle Start");
    waitUntil {sleep 2; count GVAR(HeadlessArray) > 0};//make sure there is a headless client available

    waitUntil {sleep 0.5; GVAR(FastTransferring) == false};

    BROADCAST_INFO("Rebalance Check");
    if (GVAR(RebalanceDelay) != 0 && time >= _rebalanceTime && count GVAR(HeadlessArray) > 1) then {  //rebalance timer

        _scriptHandle = [] spawn FUNC(rebalance);
        waitUntil {sleep 1; scriptDone _scriptHandle};//wait until rebalancing complete
        _rebalanceTime = time + GVAR(RebalanceDelay);
    };

    BROADCAST_INFO("Transfer Catch");
    waitUntil {sleep GVAR(CheckDelay);
            [] call FUNC(getGroups);
            ((count GVAR(TransferQueue) > 0) || (time >= _rebalanceTime))
        };//wait for groups to move

    waitUntil {sleep 0.5; GVAR(FastTransferring) == false};

    if (count GVAR(TransferQueue) > 0) then {

        _scriptHandle = [] spawn FUNC(transfer);//call main offloading script
        waitUntil {sleep 1; scriptDone _scriptHandle};//wait until offloading complete
    };

    BROADCAST_INFO("Cycle End");
    sleep GVAR(CycleDelay);
};
