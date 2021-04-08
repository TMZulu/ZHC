// Enable HC Offloading
[
    QGVAR(Enabled),
    "CHECKBOX",
    ["Enable Offloading","Enable the headless offload system"],
    ["ZHC Settings","Base"],
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
    ["ZHC Settings","Base"],
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
    ["ZHC Settings","Base"],
    [5,120,DEFAULT_DELAY_CYCLE,0],
    true
] call CBA_settings_fnc_init;

// Check Delay
[
    QGVAR(CheckDelay),
    "SLIDER",
    ["Check Delay","Time delay between checking for untransferred groups"],
    ["ZHC Settings","Base"],
    [1,120,DEFAULT_DELAY_CHECK,0],
    true
] call CBA_settings_fnc_init;

// Offload Delay
[
    QGVAR(OffloadDelay),
    "SLIDER",
    ["Offload Delay","Delay between offloading each group"],
    ["ZHC Settings","Base"],
    [5,120,DEFAULT_DELAY_PER,0],
    true
] call CBA_settings_fnc_init;

// Emergency Offload Delay
[
    QGVAR(EmergencyOffloadDelay),
    "SLIDER",
    ["Emergency Offload Delay","Delay between offloading each group during emergency dump"],
    ["ZHC Settings","Base"],
    [5,120,DEFAULT_DELAY_EMERG,0],
    true
] call CBA_settings_fnc_init;

// Rebalance Delay
[
    QGVAR(RebalanceDelay),
    "SLIDER",
    ["Rebalancing Delay","Minimum delay between HC rebalance cycles"],
    ["ZHC Settings","Base"],
    [15,600,DEFAULT_DELAY_REBAL,0],
    true
] call CBA_settings_fnc_init;


//Naked Unit Failsafe
private _loadoutOptions = ["Disabled","Default Current Loadout","Default Config Loadout"];
private _loadoutValues = [0, 1, 2];
[
    QGVAR(TransferLoadout),
    "LIST",
    ["Naked Unit Failsafe", "Action to take if unit is naked after transfer. May cause performance impact"],
    ["ZHC Settings","Base"],
    [_loadoutValues, _loadoutOptions, 1],
    true,
    {},
    true // needs mission restart
] call CBA_settings_fnc_init;

// Zeus Holding
[
    QGVAR(EnableZeusHolding),
    "CHECKBOX",
    ["Enable Zeus Holding","Enable Zeus to hold and transfer unit to himself from HC"],
    ["ZHC Settings","Zeus"],
    true,
    true
] call CBA_settings_fnc_init;

// Zeus Hold Limit
/*[
    QGVAR(ZeusHoldLimit),
    "SLIDER",
    ["Zeus Unit Hold Limit","Limit of how many units a Zeus can hold. 0 means no limit (Default = 0)"],
    ["ZHC Settings","Zeus"],
    [0,200,0,0],
    true
] call CBA_settings_fnc_init;*/

// Debug Mode
private _debugOptions = ["Disabled","All Users","Admin/Zeus Only"];
private _debugValues = [0,1,2];
[
    QGVAR(DebugMode),
    "LIST",
    ["Debug Availability","Debug mode availability. Default: Admin/Zeus Only"],
    ["ZHC Settings","Debug"],
    [_debugValues,_debugOptions,2],
    true,
    {},
    true // needs mission restart
] call CBA_settings_fnc_init;


private _verboseOptions = ["None","Low","Normal","Verbose"];
private _verboseValues = [0,1,2,3];
// Verbosity
[
    QGVAR(Verbosity),
    "LIST",
    ["Debug Verbosity","HC System Debug Verbosity Level"],
    ["ZHC Settings","Debug"],
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
    ["ZHC Settings","Blacklist"],
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
    ["ZHC Settings","Blacklist"],
    "",
    true,
    {},
    true
] call CBA_settings_fnc_init;
