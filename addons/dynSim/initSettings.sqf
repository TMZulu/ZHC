// Enable Dynamic Simulation
[
    QGVAR(Enabled),
    "CHECKBOX",
    ["Enable Dynamic Simulation support","Enable ZHC support for Dynamic Simulation."],
    ["ZHC Caching","Base"],
    false,
    true,
    {},
    true
] call CBA_fnc_addSetting;

// Override mission settings
[
    QGVAR(Override),
    "CHECKBOX",
    ["Override mission settings","Override the mission's dynamic simulation settings."],
    ["ZHC Caching","Base"],
    true,
    true,
    {},
    true
] call CBA_fnc_addSetting;

// Cycle Delay
[
    QGVAR(CycleDelay),
    "SLIDER",
    ["Cycle Delay (Seconds)","Delay between cycles of adding units to dynamic simulation"],
    ["ZHC Caching","Base"],
    [0,500,30,0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

// Group Dynamic sim distance
[
    QGVAR(GroupDist),
    "SLIDER",
    ["Group Activation Distance","Activation distance for ai groups"],
    ["ZHC Caching","Activation"],
    [0,100000,500,0],
    true,
    {
        params ["_value"];
        if (!dynamicSimulationSystemEnabled || GVAR(Override)) then {
            "Group" setDynamicSimulationDistance _value;
        };
    },
    false
] call CBA_fnc_addSetting;

// vehicle Dynamic sim distance
[
    QGVAR(VehDist),
    "SLIDER",
    ["Vehicles Activation Distance","Activation distance for ai vehicles"],
    ["ZHC Caching","Activation"],
    [0,100000,350,0],
    true,
    {
        params ["_value"];
        if (!dynamicSimulationSystemEnabled || GVAR(Override)) then {
            "Vehicle" setDynamicSimulationDistance _value;
        };
    },
    false
] call CBA_fnc_addSetting;

// empty vehicle Dynamic sim distance
[
    QGVAR(EmptyDist),
    "SLIDER",
    ["Empty Vehicles Activation Distance","Activation distance for empty vehicles"],
    ["ZHC Caching","Activation"],
    [0,100000,250,0],
    true,
    {
        params ["_value"];
        if (!dynamicSimulationSystemEnabled || GVAR(Override)) then {
            "EmptyVehicle" setDynamicSimulationDistance _value;
        };
    },
    false
] call CBA_fnc_addSetting;

// prop Dynamic sim distance
[
    QGVAR(PropDist),
    "SLIDER",
    ["Group Activation Distance","Activation distance for props/objects"],
    ["ZHC Caching","Activation"],
    [0,100000,50,0],
    true,
    {
        params ["_value"];
        if (!dynamicSimulationSystemEnabled || GVAR(Override)) then {
            "Prop" setDynamicSimulationDistance _value;
        };
    },
    false
] call CBA_fnc_addSetting;

// isMoving activation multiplier
[
    QGVAR(MoveMult),
    "SLIDER",
    ["Moving Activation Muliplier","Activation distance multiplier when moving"],
    ["ZHC Caching","Activation"],
    [0,100,1,1],
    true,
    {
        params ["_value"];
        if (!dynamicSimulationSystemEnabled || GVAR(Override)) then {
            "IsMoving" setDynamicSimulationDistanceCoef _value;
        };
    },
    false
] call CBA_fnc_addSetting;