#include "script_component.hpp"

if (!GVAR(Enabled)) exitwith {};


enableDynamicSimulationSystem true;

"Group" setDynamicSimulationDistance GVAR(GroupDist);
"Vehicle" setDynamicSimulationDistance GVAR(VehDist);
"EmptyVehicle" setDynamicSimulationDistance GVAR(EmptyDist);
"Prop" setDynamicSimulationDistance GVAR(PropDist);

"IsMoving" setDynamicSimulationDistanceCoef GVAR(MoveMult);

if (isServer) exitwith {};

player triggerDynamicSimulation true;