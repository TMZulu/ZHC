// Enable map fps display
[
    QGVAR(EnableFPSCounter),
    "CHECKBOX",
    "Enable Map FPS Monitor",
    ["ZHC Settings","Debug"],
    true,
    true,
    {},
    true
] call CBA_fnc_addSetting;

//Map fps display location
private _mapFpsOptions = ["Bottom Right","Bottom Left"];
private _mapFpsValues = [0,1];
[
    QGVAR(MapFpsPos),
    "LIST",
    ["Position for map FPS markers","Where to display map markers for FPS and Unit Counts"],
    ["ZHC Settings","Debug"],
    [_mapFpsValues,_mapFpsOptions,0],
    true,
    {},
    true
] call CBA_fnc_addSetting;

//Map markers vertical spacing modifier
// [
//     QGVAR(RPTFreq),
//     "SLIDER",
//     ["Map FPS Vertical Spacing","Modifier for vertical spacing of map FPS markers(% of total map height)"],
//     ["ZHC Settings","Debug"],
//     [.01 , 0.25, 0.016276, 2, true],
//     true,
//     {},
//     true
// ] call CBA_settings_fnc_init;


// Log to RPT
[
    QGVAR(DebugRPT),
    "CHECKBOX",
    ["Log Stats To RPT","Print Statistics to RPT. May cause extra stress."],
    ["ZHC Settings","Debug"],
    false,
    true,
    {},
    true // needs mission restart
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

// Log to RPT
[
    QGVAR(DebugRPT),
    "CHECKBOX",
    ["Log Stats To RPT","Print Statistics to RPT. May cause extra stress."],
    ["ZHC Settings","Debug"],
    false,
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



