#define DEBUG_SYNCHRONOUS
#include "script_macros_zhc.hpp"//ZHC Macros

#define RGB_GREEN 0, 0.5, 0, 1
#define RGB_BLUE 0, 0, 1, 1
#define RGB_ORANGE 0.5, 0.5, 0, 1
#define RGB_RED 1, 0, 0, 1
#define RGB_YELLOW 1, 1, 0, 1
#define RGB_WHITE 1, 1, 1, 1
#define RGB_GRAY 0.5, 0.5, 0.5, 1
#define RGB_BLACK 0, 0, 0, 1
#define RGB_MAROON 0.5, 0, 0, 1
#define RGB_OLIVE 0.5, 0.5, 0, 1
#define RGB_NAVY 0, 0, 0.5, 1
#define RGB_PURPLE 0.5, 0, 0.5, 1
#define RGB_FUCHSIA 1, 0, 1, 1
#define RGB_AQUA 0, 1, 1, 1
#define RGB_TEAL 0, 0.5, 0.5, 1
#define RGB_LIME 0, 1, 0, 1
#define RGB_SILVER 0.75, 0.75, 0.75, 1

#define AVERAGE_MAN_HEIGHT 1.8288


#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#define DEFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)

#define DGVAR(varName) if (isNil "ZHC_DEBUG_NAMESPACE") then { ZHC_DEBUG_NAMESPACE = []; }; if (!(QGVAR(varName) in ZHC_DEBUG_NAMESPACE)) then { ZHC_DEBUG_NAMESPACE pushBack QGVAR(varName); }; GVAR(varName)
#define DVAR(varName) if (isNil "ZHC_DEBUG_NAMESPACE") then { ZHC_DEBUG_NAMESPACE = []; }; if (!(QUOTE(varName) in ZHC_DEBUG_NAMESPACE)) then { ZHC_DEBUG_NAMESPACE pushBack QUOTE(varName); }; varName

#include "script_debug.hpp"
