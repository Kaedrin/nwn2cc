/*
Server-Wide Constants for Dalelands Beyond
Author: 		Alex (MustangSVT)
Created: 		January 21, 2011
Last Modified: 	January 24, 2011
Description:

This file contains switches for various features present throughout
the module for Dalelands Beyond.
*/

const int	RESET_ENABLED			= TRUE;
const int 	RESET_SCHEDULE			= 10;
const int   RESET_MESSAGE_SCHEDULE	= 10;
const int	RESET_EXPIRE			= 42000;
const float RESET_TIMER_UPDATE		= 1800.0;
const float CLOCK_TIMER_UPDATE		= 300.0;
const int 	DMFI_FOLLOW_ENABLED		= FALSE;

// AFK prevention system
const float  AFK_CHECK              = 1500.0;
const float  SECOND_AFK_CHECK       = 60.0;
const string AFK_LOCATION           = "hv_afk_location";
const string AFK_CHAT               = "hv_afk_chat";
const int    BOOT_AFK_DM			= FALSE;
const string AFK_SCRIPT1            = "hv_afk_check";
const string AFK_SCRIPT2            = "hv_afk_check2";

// Variables that will be set on the module so I can
// Start/Stop the timer from any script
const string AFK_TIMER_INT          = "hv_afk_timer_int";
const string AFK_CHECK_TIME         = "hv_afk_check_time";