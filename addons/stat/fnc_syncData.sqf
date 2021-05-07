#include "script_component.hpp"
/*
 * Author: TMZulu
 * Timing loop for reporting FPS and AI data to Server for RPT log
 *
 * Arguments:
 * 0: STRING - Client Name
 *
 * Return Value:
 * NONE
 *
 * Example:
 * ["HC1"] call mf7_server_fnc_syncData
 *
 */
params ["_clientName"];

GVAR(ClientName) = _clientName;

[{

   _curfps = diag_fps;
   _localGroups = {local _x} count allGroups;
   _localUnits = {local _x} count allUnits;
   GVAR(Data) = [GVAR(DataIndex), [GVAR(ClientName), (round (_curfps * 100.0)) / 100.0, _localGroups, _localUnits] ];
   publicVariableServer QGVAR(Data);

 }, GVAR(RPTFreq)] call CBA_fnc_addPerFrameHandler;