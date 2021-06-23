#include "script_component.hpp"

if (!GVAR(Enabled)) exitwith {};

if (!dynamicSimulationSystemEnabled || GVAR(Override)) then {
	enableDynamicSimulationSystem true;

	"Group" setDynamicSimulationDistance GVAR(GroupDist);
	"Vehicle" setDynamicSimulationDistance GVAR(VehDist);
	"EmptyVehicle" setDynamicSimulationDistance GVAR(EmptyDist);
	"Prop" setDynamicSimulationDistance GVAR(PropDist);

	"IsMoving" setDynamicSimulationDistanceCoef GVAR(MoveMult);

	[] spawn FUNC(loop);

	if (isServer) exitwith {};

	player triggerDynamicSimulation true;
	
};
