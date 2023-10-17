#include "script_component.hpp"
/*
	 * Author: TMZulu
	 * Transfers AI to Zeus for holding
	 *
	 * Arguments:
	 * 0: OBJECT - Zeus Calling
	 * 1: ARRAY[GROUPS] - list of groups
	 * 3: INT - Zeus data array index
	 *
	 * Return Value:
	 * NONE
	 *
 */
private _who = _this select 0;
private _groups = _this select 1;
private _dataIndex = _this select 2;
private ["_groupMoving", "_lead", "_groupGarrisoned", "_groupIndex"];

private _transferLoadout = GVAR(TransferLoadout);
private _debugEnabled = false;
if (GVAR(DebugMode) > 0) then {
	_debugEnabled = true;
};

GVAR(FastTransferring) = true;

{
	try {
		_groupMoving = _x;

		if (isNull _groupMoving) then {
			continue
		};

		_lead = leader _groupMoving;
		_size = count (units _groupMoving);
		_leadOwner = owner _lead;
		// _excluded = [_groupMoving] call FUNC(checkBad);
		_vehicle = vehicle _lead;
		_vehicle lock true;
		// check garrison flag
        if ((_groupMoving getVariable ["Achilles_var_inGarrison", false]) || (_lead getVariable ["zen_ai_garrisoned", false]) || (_groupMoving getVariable ["ace_ai_garrisoned", false]) || !(_lead checkAIFeature "PATH")) then {
			_groupGarrisoned = true;
		} else {
			_groupGarrisoned = false;
		};

		if (_transferLoadout == 1) then {
			{
				_x setVariable [QGVAR(UnitLoadout), getUnitLoadout _x];
			} forEach units _groupMoving;
		};

		_groupMoving setGroupOwner _who;

		// reapply garrison
		if (_groupGarrisoned) then {
			waitUntil {
				sleep 0.5;
				(groupOwner _groupMoving) == (GVAR(HeadlessIds) select _hcIndex)
			};
			BROADCAST_INFO_1("Garrison reapplied to: %1", str _groupMoving);
			[_groupMoving] remoteExecCall [QFUNC(reGarrison), GVAR(HeadlessIds) select _hcIndex];
		};
		BROADCAST_INFO_1("Transferred to Zeus: %1", str _groupMoving);
		sleep (GVAR(OffloadDelay)/2);

		if (_transferLoadout > 0) then {
			if (_transferLoadout == 1) then {
				{
					if (uniform _x == "") then {
						private _loadout = _x getVariable [GVAR(UnitLoadout), typeOf _x];
						_x setUnitLoadout _loadout;
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
		};// prevent some desync issues

		_groupIndex = GVAR(HeadlessGrpData) findIf {
			_x select 0 == _groupMoving
		};
		if (_groupIndex != -1) then {
			GVAR(HeadlessGrpData) deleteAt _groupIndex;
			GVAR(HeadlessLocalCounts) set [_hcIndex, (GVAR(HeadlessLocalCounts) select _hcIndex) - _size];
		};

		GVAR(ZeusGrpData) pushBack ([_groupMoving, GVAR(ZeusArray) select _dataIndex]);
		GVAR(ZeusHeldUnitCounts) set [_dataIndex, (GVAR(ZeusHeldUnitCounts) select _dataIndex) + _size];

		if (_debugEnabled) then {
			_groupMoving setVariable [QGVAR(OwningClient), (GVAR(ZeusArray) select _dataIndex), true];
		} else {
			_groupMoving setVariable [QGVAR(OwningClient), (GVAR(ZeusArray) select _dataIndex)];
		};

		sleep (GVAR(OffloadDelay)/2);
		_vehicle lock false;
	} catch {
		ERROR_WITH_TITLE("ZHC Zeus Transfer Error", str _exception);
		continue;
	};
} forEach _groups;

{
	_x publicVariableClient QGVAR(ZeusGrpData);
} forEach GVAR(ZeusIds);

GVAR(FastTransferring) = false;
