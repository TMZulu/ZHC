// Enable HC Offloading
[
    QGVAR(Enabled),
    "CHECKBOX",
    ["Enable Offloading","Enable the headless offload system"],
    ["700th Framework HC","Base"],
    true,
    true,
    {},
    true
] call CBA_settings_fnc_init;

// Offload System Start Delay
[
    QGVAR(StartDelay),
    "SLIDER",
    ["Init Delay","Time delay before offloading system starts"],
    ["700th Framework HC","Base"],
    [0,60,5,0],
    true,
    {},
    true
] call CBA_settings_fnc_init;

// Cycle Delay
[
    QGVAR(CycleDelay),
    "SLIDER",
    ["Cycle Delay","Time delay between offload cycles"],
    ["700th Framework HC","Base"],
    [5,120,DEFAULT_DELAY_CYCLE,0],
    true
] call CBA_settings_fnc_init;

// Offload Delay
[
    QGVAR(OffloadDelay),
    "SLIDER",
    ["Offload Delay","Delay between offloading each group"],
    ["700th Framework HC","Base"],
    [5,120,DEFAULT_DELAY_PER,0],
    true
] call CBA_settings_fnc_init;

// Offload Delay
[
    QGVAR(EmergencyOffloadDelay),
    "SLIDER",
    ["Emergency Offload Delay","Delay between offloading each group during emergency dump"],
    ["700th Framework HC","Base"],
    [5,120,DEFAULT_DELAY_EMERG,0],
    true
] call CBA_settings_fnc_init;

// Rebalance Delay
[
    QGVAR(RebalanceDelay),
    "SLIDER",
    ["Rebalancing Delay","Minimum delay between HC rebalance cycles"],
    ["700th Framework HC","Base"],
    [15,600,DEFAULT_DELAY_REBAL,0],
    true
] call CBA_settings_fnc_init;

// Debug Mode
private _debugOptions = ["Disabled","All Users","Admin/Zeus Only"];
private _debugValues = [0,1,2];
[
    QGVAR(DebugMode),
    "LIST",
    ["Debug Availability","Debug mode availability. Default: Admin/Zeus Only"],
    ["700th Framework HC","Base"],
    [_debugValues,_debugOptions,2],
    true,
    {},
    true // needs mission restart
] call CBA_settings_fnc_init;

//Naked Unit Failsafe
private _loadoutOptions = ["Disabled","Default Current Loadout","Default Config Loadout"];
private _loadoutValues = [0, 1, 2];
[
    QGVAR(TransferLoadout),
    "LIST",
    ["Naked Unit Failsafe", "Action to take if unit is naked after transfer. May cause performance impact"],
    ["700th Framework HC","Base"],
    [_loadoutValues, _loadoutOptions, 1],
    true,
    {},
    true // needs mission restart
] call CBA_settings_fnc_init;

// Attach to compatibility
/*[
    QGVAR(AttachToCompat),
    "CHECKBOX",
    ["AttachTo Compatibility","Enable AttachTo compatibility when transferring"],
    ["700th Framework HC"],
    true,
    true,
    {},
    true
] call CBA_settings_fnc_init;*/

// Zeus Holding
[
    QGVAR(EnableZeusHolding),
    "CHECKBOX",
    ["Enable Zeus Holding","Enable Zeus to hold and trnsfer unit to himself from HC"],
    ["700th Framework HC","Zeus"],
    true,
    true
] call CBA_settings_fnc_init;

// Zeus Hold Limit
/*[
    QGVAR(ZeusHoldLimit),
    "SLIDER",
    ["Zeus Unit Hold Limit","Limit of how many units a Zeus can hold. 0 means no limit (Default = 0)"],
    ["700th Framework HC","Zeus"],
    [0,200,0,0],
    true
] call CBA_settings_fnc_init;*/

private _verboseOptions = ["None","Low","Normal","Verbose"];
private _verboseValues = [0,1,2,3];
// Verbosity
[
    QGVAR(Verbosity),
    "LIST",
    ["Verbose","HC System Debug Verbosity Level"],
    ["700th Framework HC","Debug"],
    [_verboseValues,_verboseOptions,0],
    true,
    {},
    true
] call CBA_settings_fnc_init;

// Blacklist Names
[
    QGVAR(badNames),
    "EDITBOX",
    ["Blacklisted Names","Blacklisted Variablenames. In format: 'name1','name2', ..."],
    ["700th Framework HC","Blacklist"],
    "'ignore'",
    true,
    {},
    true
] call CBA_settings_fnc_init;

// Blacklist Types
[
    QGVAR(badTypes),
    "EDITBOX",
    ["Blacklisted Classnames","Blacklisted Classnames. In format: 'name1','name2', ..."],
    ["700th Framework HC","Blacklist"],
    "",
    true,
    {},
    true
] call CBA_settings_fnc_init;
