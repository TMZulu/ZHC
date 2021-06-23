#include "script_component.hpp"
/*
 * Author: TMZulu
 * Log FPS and AI counts to RPT
 * Runs on both HCs and Server
 *
 * Arguments:
 * 0: Refresh Delay in seconds <NUMBER><OPTIONAL> (default = 10)
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [10] call mf7_stat_fnc_fpsLogToRpt
 *
 */
params ["_clientName",["_refreshDelay",10]];

if (hasInterface) exitwith {};

GVAR(clientRptName) = _clientName;

[{

	private _curfps = diag_fps;
	private _localunits = {local _x} count allUnits;
	private _localgroups = {local _x} count allGroups;
	
	if (GVAR(DebugRPTForm) == 0) then {
		 
		private _strArray = [];
		_strArray pushBack format ["%1: %2 fps, %3 local groups, %4 local units", GVAR(clientRptName), (round (_curfps * 100.0)) / 100.0, _localgroups, _localunits];
		private _failed = false;
		{
			if (_x isEqualType []) then {
				_strArray pushBack format ["|| %1: %2 fps, %3 local groups, %4 local units", _x select 0, _x select 1, _x select 2, _x select 3];
			} else {
				_failed = true;
			};
			
		} forEach GVAR(Stats);

		diag_log (_strArray joinString "");

		if (_failed) then {
			private _cleanArray = [];
			{
				if (_x isEqualType []) then {
					_cleanArray pushBack _x;
				};
			} forEach GVAR(Stats);
			GVAR(Stats) = _cleanArray;
		};

	} else {
		//diag_log format [";%1;%2;%3;%4;", GVAR(clientRptName), (round (_curfps * 100.0)) / 100.0, _localunits, _localgroups];
		private _strArray = [];
		_strArray pushBack format ["[ZHC];%1;%2;%3;%4;", GVAR(clientRptName), (round (_curfps * 100.0)) / 100.0, _localgroups, _localunits];

		{
			_strArray pushBack format ["%1;%2;%3;%4;", _x select 0, _x select 1, _x select 2, _x select 3];
			
		} forEach GVAR(Stats);

		diag_log (_strArray joinString "");

	};
}, _refreshDelay] call CBA_fnc_addPerFrameHandler;