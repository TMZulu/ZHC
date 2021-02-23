#include "script_component.hpp"
/*
 * Author: TMZulu
 * Initializes Headless Framework
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call zhc_offload_fnc_initOffload
 */
private ["_ehIndex"];

//server
if (isServer) then {
    //set up arrays
    GVAR(HeadlessArray) = [];//list of HCs
    GVAR(HeadlessIds) = [];
    GVAR(HeadlessLocalCounts) = [];
    GVAR(HeadlessGrpData) = [];

    GVAR(ZeusArray) = [];//Zeus array
    GVAR(ZeusIds) = [];//Zeus Client Ids
    GVAR(ZeusGrpData) = [];
    GVAR(ZeusHeldUnitCounts) = [];//Zeus held unit counts
    GVAR(TransferQueue) = [];

    publicVariable QGVAR(HeadlessArray);
    publicVariable QGVAR(HeadlessIds);
    publicVariable QGVAR(HeadlessLocalCounts);

    GVAR(FastTransferring) = false;
    GVAR(UnitLoadout) = [];

    [] call FUNC(initServer);

};

//player
if (hasInterface) then {
    //set up arrays
    if (isNil QGVAR(ZeusArray)) then {
        GVAR(ZeusArray) = [];//Zeus array
        GVAR(ZeusIds) = [];//Zeus Client Ids
        GVAR(ZeusHeldUnitCounts) = [];//Zeus held unit counts
        GVAR(ZeusGrpData) = [];
    };

    GVAR(LocalHeldGroups) = [];//Groups held to local Machine

    //Zeus initializer(run only on first enter of interface then removed)
    {
        _ehIndex = _x addEventHandler ["CuratorObjectRegistered", {call FUNC(initZeus);}];
        _x setVariable [QGVAR(ZeusInitIndex), _ehIndex];
    } forEach allCurators;

    GVAR(Debugging) = false;
    systemChat "ZHC Initialized";
};

//Headless
if(!isServer && !hasInterface) then {
    BROADCAST_INFO_1("%1 Initializing",player);
    //set up arrays and variables

    GVAR(DataIndex) = -1;

    [] spawn FUNC(initHeadless);

};
