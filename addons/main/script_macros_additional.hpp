/*
    Header: script_macros_additional.hpp

    Description:
        A general set of macros for use in zhc

    Authors: TMZulu
*/

/* -------------------------------------------
Macro: BROADCAST_INFO()
    Broadcast systemchat to all users
    Only works if GVAR(verbosity) is "Verbose" => 3

Parameters:
    MESSAGE - Message to send <STRING>

Example:
    (begin example)
        BROADCAST_INFO("Initiated clog-dancing simulator.");
    (end)

Author:
    TMZulu
------------------------------------------- */

#define BROADCAST_INFO(MESSAGE) SEND_CHAT(MESSAGE)
#define BROADCAST_INFO_1(MESSAGE,ARG1) BROADCAST_INFO(FORMAT_1(MESSAGE,ARG1))
#define BROADCAST_INFO_2(MESSAGE,ARG1,ARG2) BROADCAST_INFO(FORMAT_2(MESSAGE,ARG1,ARG2))
#define BROADCAST_INFO_3(MESSAGE,ARG1,ARG2,ARG3) BROADCAST_INFO(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define BROADCAST_INFO_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) BROADCAST_INFO(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define BROADCAST_INFO_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) BROADCAST_INFO(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))


/* -------------------------------------------
Macro: BROADCAST_WARN()
    Broadcast systemchat to all users
    Works if GVAR(verbosity) is "Normal" => 2 or greater

Parameters:
    MESSAGE - Message to send <STRING>

Example:
    (begin example)
        BROADCAST_WARN("Initiated clog-dancing simulator.");
    (end)

Author:
    TMZulu
------------------------------------------- */

#define BROADCAST_WARN(MESSAGE) SEND_CHAT_WARN(MESSAGE)
#define BROADCAST_WARN_1(MESSAGE,ARG1) BROADCAST_WARN(FORMAT_1(MESSAGE,ARG1))
#define BROADCAST_WARN_2(MESSAGE,ARG1,ARG2) BROADCAST_WARN(FORMAT_2(MESSAGE,ARG1,ARG2))
#define BROADCAST_WARN_3(MESSAGE,ARG1,ARG2,ARG3) BROADCAST_WARN(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define BROADCAST_WARN_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) BROADCAST_WARN(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define BROADCAST_WARN_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) BROADCAST_WARN(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))

/* -------------------------------------------
Macro: BROADCAST_ERROR()
    Broadcast systemchat to all users
    Works if GVAR(verbosity) is "Low" => 1 or greater

Parameters:
    MESSAGE - Message to send <STRING>

Example:
    (begin example)
        BROADCAST_ERROR("Initiated clog-dancing simulator.");
    (end)

Author:
    TMZulu
------------------------------------------- */

#define BROADCAST_ERROR(MESSAGE) SEND_CHAT_ERROR(MESSAGE)
#define BROADCAST_ERROR_1(MESSAGE,ARG1) BROADCAST_ERROR(FORMAT_1(MESSAGE,ARG1))
#define BROADCAST_ERROR_2(MESSAGE,ARG1,ARG2) BROADCAST_ERROR(FORMAT_2(MESSAGE,ARG1,ARG2))
#define BROADCAST_ERROR_3(MESSAGE,ARG1,ARG2,ARG3) BROADCAST_ERROR(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define BROADCAST_ERROR_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) BROADCAST_ERROR(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define BROADCAST_ERROR_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) BROADCAST_ERROR(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))

//Submacros
#define SEND_CHAT(MESSAGE) if(GVAR(Verbosity) == 3) then { \
    if (hasInterface) then { \
        systemChat MESSAGE; \
    } else { \
        [MESSAGE] remoteExec ["systemChat", -2]; \
    }; \
} \

#define SEND_CHAT_WARN(MESSAGE) if(GVAR(Verbosity) >= 2) then { \
    if (hasInterface) then { \
        systemChat MESSAGE; \
    } else { \
        [FORMAT_1("Warning: %1",MESSAGE)] remoteExec ["systemChat", -2]; \
    }; \
} \

#define SEND_CHAT_ERROR(MESSAGE) if(GVAR(Verbosity) >= 1) then { \
    if (hasInterface) then { \
        systemChat MESSAGE; \
    } else { \
        [FORMAT_1("ERROR: %1",MESSAGE)] remoteExec ["systemChat", -2]; \
    }; \
} \
