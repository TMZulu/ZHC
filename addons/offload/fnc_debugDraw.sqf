#include "script_component.hpp"
/*
 * Author: TMZulu
 * Draw Debug mode for clients
 *
 * Arguments:
 * 0: BOOL - Enable/disable
 *
 * Return Value:
 * NONE
 *
 */
params [["_enable",false]];
private ["_color","_name","_owner","_text","_valid"];
GVAR(Debugging) = _enable;
if (_enable) then {
    hint "Debug Mode Starting";
    missionNamespace setVariable [QGVAR(DebugDrawZHC) , addMissionEventHandler ["Draw3D", {
        {
            if(!(isNull _x) && !(units _x isEqualTo [])) then {
                _leader = leader _x;
                _color = [];
                _name = "";
                _text = "";
                _name = (_x getVariable [QGVAR(OwningClient), "None"]);

                if (_name isEqualType "STRING") then {
                    if (_name == "Server") then {//server
                        _color = [COLOR_SERVER, ICON_TRANSPARENCY];
                        _text = "On Server";
                    };

                    if (_color isEqualTo [] && _name == "None" && !isPlayer _leader) then {//none
                            _color = [COLOR_UNTRANSFERRED, ICON_TRANSPARENCY];
                            _text = "Untransferred";
                    };
                } else {
                    if (_color isEqualTo [] && str _name == (str player)) then {//local
                        _color = [COLOR_LOCAL, ICON_TRANSPARENCY];
                        _text = "Local";
                    };

                    if (_color isEqualTo [] && _name in GVAR(HeadlessArray)) then {//HC
                        _color = [COLOR_HEADLESS, ICON_TRANSPARENCY];
                        _text = "On: " + str _name;
                    };

                    if (_color isEqualTo [] && _name in GVAR(ZeusArray)) then {//Zeus
                        _color = [COLOR_ZEUS, ICON_TRANSPARENCY];
                        _text = "On: " + name _name;
                    };
                };

                if (!(_color isEqualTo [])) then { //Not a player group so draw
                    drawIcon3D ["\a3\ui_f\data\map\vehicleicons\iconvirtual_ca.paa",
                        _color,
                        getPosATL _leader vectorAdd [0,0,2],
                        1,
                        1,
                        0,
                        _text,
                        0.5,
                        0.02,
                        "EtelkaNarrowMediumPro",
                        "center",
                        false
                    ];
                } else {
                    if (_color isEqualTo [] && !isPlayer _leader) then { //failed to assign to type
                        drawIcon3D ["\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa",
                            [1,0,0,0.5],
                            getPosATL _leader vectorAdd [0,0,2],
                            1,
                            1,
                            0
                        ];
                    };
                };
            };
        } forEach allGroups;
    }]];
} else {
    hint "Ending Debug Mode";
    removeMissionEventHandler ["Draw3D", missionNamespace getvariable QGVAR(DebugDrawZHC)];
};
