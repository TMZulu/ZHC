#include "script_component.hpp"
/*
	 * Author: TMZulu
	 * Check and return if group or unit is exempt from offload
	 *
	 * Arguments:
	 * 0: group - group to Check
	 *
	 * Return Value:
	 * 0: BOOL - Is Exempt
	 *
 */

private _group = _this select 0;
private ["_name"];
private _badTypes = [BLACKLIST_UAV];
private _badNames = [BLACKLIST_NAMES];
private _exempt = false;

if (GVAR(badTypes) != "") then {
	_badTypes = _badTypes + (GVAR(badTypes) splitString "', ");
};
if (GVAR(badNames) != "") then {
	_badNames = _badNames + (GVAR(badNames) splitString "', ");
};

// zhc_offload_blacklisted variable on group will prevent offload if true
if (_group getVariable [QGVAR(blacklisted), false]) exitWith {
	true
};

// check if held by zeus
if (GVAR(ZeusGrpData) findIf {
	_x select 0 == _group
} != -1) exitWith {
	true
};
// groups doesnt exist
if (units _group isEqualTo [] || isNull _group) exitWith {
	true
};
// player owned group
if (isPlayer leader _group) exitWith {
	true
};

// all vehicles
if (GVAR(BlacklistAllVehicles) && (vehicle leader _group != leader _group)) then {
	if (driver vehicle leader _group == leader _group) exitWith {
		_exempt = true;
	};
};

if (_exempt) exitWith {
	_exempt
};

// check unit names
{
	_name = str _x;
	{
		if (_x in _name) exitWith {
			_exempt = true;
		};
	}forEach _badNames;
	if (_exempt) exitWith {};
}forEach units _group;

if (_exempt) exitWith {
	_exempt
};

// check unit types
{
	_name = typeOf _x;
	{
		if (_x in _name) exitWith {
			_exempt = true;
		};
	}forEach _badTypes;
	if (_exempt) exitWith {};
}forEach units _group;

if (_exempt) exitWith {
	_exempt
};

// check unit's vehicle's type
{
	_name = typeOf (vehicle _x);
	{
		if (_x in _name) exitWith {
			_exempt = true;
		};
	}forEach _badTypes;
	if (_exempt) exitWith {};
}forEach units _group;

if (_exempt) exitWith {
	_exempt
};

// check unit's vehicle's name
{
	_name = str (vehicle _x);
	{
		if (_x in _name) exitWith {
			_exempt = true;
		};
	}forEach _badNames;
}forEach units _group;

if (_exempt) exitWith {
	_exempt
};

// check goup name
_name = str _group;
{
	if (_x in _name) exitWith {
		_exempt = true;
	};
}forEach _badNames;

_exempt
