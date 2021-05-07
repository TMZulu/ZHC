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
] call CBA_settings_fnc_init;

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
] call CBA_settings_fnc_init;

// Cycle Delay
[
    QGVAR(CycleDelay),
    "SLIDER",
    ["Cycle Delay","Delay between cycles of adding units to dynamic simulation"],
    ["ZHC Caching","Base"],
    [0,500,30,0],
    true,
    {},
    true
] call CBA_settings_fnc_init;

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
        "Group" setDynamicSimulationDistance _value;
    },
    true
] call CBA_settings_fnc_init;

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
        "Vehicle" setDynamicSimulationDistance _value;
    },
    true
] call CBA_settings_fnc_init;

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
        "EmptyVehicle" setDynamicSimulationDistance _value;
    },
    true
] call CBA_settings_fnc_init;

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
        "Prop" setDynamicSimulationDistance _value;
    },
    true
] call CBA_settings_fnc_init;

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
        "IsMoving" setDynamicSimulationDistanceCoef _value;
    },
    true
] call CBA_settings_fnc_init;