// Enable map fps display
[
    QGVAR(EnableFPSCounter),
    "CHECKBOX",
    "Enable Map FPS Monitor",
    ["ZHC Settings","Debug"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

// Log to RPT
[
    QGVAR(DebugRPT),
    "CHECKBOX",
    ["Log Stats To RPT","Print Statistics to RPT. May cause extra stress."],
    ["ZHC Settings","Debug"],
    0,
    true,
    {},
    true // needs mission restart
] call CBA_settings_fnc_init;

//Log RPT Format
private _rptOptions = ["Normal","CSV"];
private _rptValues = [0,1];
[
    QGVAR(DebugRPTForm),
    "LIST",
    ["RPT Stats Log Format","Format for RPT stats logs"],
    ["ZHC Settings","Debug"],
    [_rptValues,_rptOptions,0],
    true,
    {},
    false
] call CBA_settings_fnc_init;

//Log frequency
[
    QGVAR(RPTFreq),
    "SLIDER",
    ["RPT Stats Log Frequency","Time between RPT stats logs"],
    ["ZHC Settings","Debug"],
    [1,60,15,0],
    true,
    {},
    true
] call CBA_settings_fnc_init;
