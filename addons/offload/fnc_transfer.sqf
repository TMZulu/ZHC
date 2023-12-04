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

private ["_groupMoving", "_lead", "_size", "_leadOwner", "_groupGarrisoned", "_excluded", "_hcIndex", "_attachments", "_prevCount", "_HCid", "_vehicle", "_driver", "_groupIndex"];
private _groupArray = GVAR(TransferQueue);// copy current transfer queue
GVAR(TransferQueue) = [];// clear global transfer queue

// settings variable conversion(optimisation)
private _transferLoadout = GVAR(TransferLoadout);
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then {
	_debugEnabled = true;
};

BROADCAST_INFO("Started Transferring");
INFO_1("Started Transferring for %1 groups", count _groupArray);

{
	_HCid = _x;
	GVAR(HeadlessLocalCounts) set [_forEachIndex, (count (allUnits select {
		owner _x == _HCid
	}))];
} forEach GVAR(HeadlessIds);

{
	waitUntil {
		sleep 0.1;
		!GVAR(ProcessingDisconnect)
	};
	if (GVAR(EmergencyTransferring)) exitWith {
		BROADCAST_WARN("Stopping Transferring due to emergency dump");
		WARNING("Stopping Transferring due to emergency dump");
	};
	waitUntil {
		sleep 0.1;
		!GVAR(FastTransferring)
	};

	_groupMoving = _x;
	if (isNull _groupMoving) then {
		continue
	};

	_lead = leader _groupMoving;
	_size = count (units _groupMoving);
	_leadOwner = owner _lead;
	_vehicle = vehicle _lead;

	   // check garrison flag
	if ((_groupMoving getVariable ["Achilles_var_inGarrison", false]) || (_lead getVariable ["zen_ai_garrisoned", false]) || (_groupMoving getVariable ["ace_ai_garrisoned", false]) || !(_lead checkAIFeature "PATH")) then {
		_groupGarrisoned = true;
	} else {
		_groupGarrisoned = false;
	};

	if (GVAR(HeadlessGrpData) findIf {
		_x select 0 == _groupMoving
	} == 1) exitWith {
		diag_log format["WARNING: ZHC Main HC Offload Loop. Group:%1 already offloaded but in TransferQueue", str _groupMoving];
		BROADCAST_WARN_1("Group:%1 already offloaded but in TransferQueue", str _groupMoving);
	};

	_vehicle lock true;
	sleep (GVAR(OffloadDelay)/3);

	if (isNull _groupMoving) then {
		continue
	};
	if (GVAR(EmergencyTransferring)) exitWith {
		BROADCAST_WARN("Stopping Transferring due to emergency dump");
		WARNING("Stopping Transferring due to emergency dump");
	};

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

	BROADCAST_INFO_2("Transferring group %1 to %2", str _groupMoving, str (GVAR(HeadlessArray) select _hcIndex));
	_groupMoving setGroupOwner (GVAR(HeadlessIds) select _hcIndex);

	sleep (GVAR(OffloadDelay)/3);

	if (isNull _groupMoving) then {
		continue
	};
	if (GVAR(EmergencyTransferring)) exitWith {
		BROADCAST_WARN("Stopping Transferring due to emergency dump");
		WARNING("Stopping Transferring due to emergency dump");
	};

	   // reapply garrison
	if (_groupGarrisoned) then {
		waitUntil {
			sleep 0.5;
			((groupOwner _groupMoving) == (GVAR(HeadlessIds) select _hcIndex)) || (isNull _groupMoving) || GVAR(EmergencyTransferring)
		};
		if (isNull _groupMoving) then {
			continue
		};
		if (GVAR(EmergencyTransferring)) exitWith {
			BROADCAST_WARN("Stopping Transferring due to emergency dump");
			WARNING("Stopping Transferring due to emergency dump");
		};
		BROADCAST_INFO_1("Garrison reapplied to: %1", str _groupMoving);
		[_groupMoving] remoteExecCall [QFUNC(reGarrison), GVAR(HeadlessIds) select _hcIndex];
	};

	BROADCAST_INFO_2("Transferred group %1 to %2", str _groupMoving, str (GVAR(HeadlessArray) select _hcIndex));
	sleep (GVAR(OffloadDelay)/3);

	if (isNull _groupMoving) then {
		continue
	};
	if (GVAR(EmergencyTransferring)) exitWith {
		BROADCAST_WARN("Stopping Transferring due to emergency dump");
		WARNING("Stopping Transferring due to emergency dump");
	};

	_vehicle lock false;

	if (_transferLoadout > 0) then {
		if (_transferLoadout == 1) then {
			{
				if (uniform _x == "") then {
					_x setUnitLoadout (_x getVariable [QGVAR(UnitLoadout), typeOf _x]);
				};
			} forEach units _groupMoving;
		} else {
			{
				if (uniform _x == "") then {
					_x setUnitLoadout (typeOf _x);
				};
			} forEach units _groupMoving;
		};
	};

	waitUntil {
		sleep 0.1;
		!GVAR(ProcessingDisconnect)
	};

	GVAR(HeadlessGrpData) pushBack ([_groupMoving, GVAR(HeadlessArray) select _hcIndex]);

	GVAR(HeadlessLocalCounts) set [_hcIndex, (GVAR(HeadlessLocalCounts) select _hcIndex) + _size];

	if (_debugEnabled) then {
		_groupMoving setVariable [QGVAR(OwningClient), (GVAR(HeadlessArray) select _hcIndex), true];
	} else {
		_groupMoving setVariable [QGVAR(OwningClient), (GVAR(HeadlessArray) select _hcIndex)];
	};
} forEach _groupArray;
BROADCAST_INFO("Transferring Finished");
INFO("Transferring Finished");
