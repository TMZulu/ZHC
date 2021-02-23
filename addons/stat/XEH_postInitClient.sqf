#include "script_component.hpp"

if (!hasInterface) exitWith {};

if (GVAR(EnableFPSCounter)) then {
    [10] call FUNC(fpsHcHandler);
};




