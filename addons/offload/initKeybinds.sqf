#include "\a3\ui_f\hpp\definedikcodes.inc"
//Mark Ai for Zeus Offload
[
    "700th Framework",
    "hc_hold_key",
    "Hold Selected Units on Client",
    {_this spawn FUNC(zeusHold);},
    "",
    [DIK_LBRACKET, [true, false, false]] //shift+[
] call CBA_fnc_addKeybind;

//Toggle debug
[
    "700th Framework",
    "hc_debug_key",
    "Toggle Debug Mode",
    {_this call FUNC(debugToggle);},
    "",
    [DIK_RBRACKET, [false, true, false]] //ctrl+]
] call CBA_fnc_addKeybind;
