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

private ["_scriptHandle", "_rebalanceTime"];

_rebalanceTime = time + 480;

sleep GVAR(StartDelay);
if (GVAR(StrtMsg)) then {
	["ZHC Initialized"] remoteExec ["hint", -2, true];
};

INFO("ZHC Initialized");

while { GVAR(Enabled) } do {
	BROADCAST_INFO("Cycle Start");
	INFO("ZHC Cycle Start");
	// make sure there is a headless client available
	waitUntil {
		sleep 2;
		count GVAR(HeadlessArray) > 0
	};

	waitUntil {
		sleep 0.5;
		GVAR(FastTransferring) == false
	};

	BROADCAST_INFO("Rebalance Check");
	if (GVAR(RebalanceDelay) != 0 && time >= _rebalanceTime && count GVAR(HeadlessArray) > 1 && GVAR(EnableRebal)) then {
		// rebalance timer
		_scriptHandle = [] spawn FUNC(rebalance);
		// wait until rebalancing complete
		waitUntil {
			sleep 1;
			scriptDone _scriptHandle
		};
		_rebalanceTime = time + GVAR(RebalanceDelay);
	};

	BROADCAST_INFO("Transfer Catch");

	// wait for groups to move
	waitUntil {
		sleep GVAR(CheckDelay);
		[] call FUNC(getGroups);
		((count GVAR(TransferQueue) > 0) || (time >= _rebalanceTime))
	};

	waitUntil {
		sleep 0.5;
		GVAR(FastTransferring) == false
	};

	if (count GVAR(TransferQueue) > 0) then {
		_scriptHandle = [] spawn FUNC(transfer);// call main offloading script
		// wait until offloading complete
		waitUntil {
			sleep 1;
			scriptDone _scriptHandle
		};
	} else {
		INFO("ZHC Cycle: no units to offload");
	};

	BROADCAST_INFO("Cycle End");
	sleep GVAR(CycleDelay);
};
