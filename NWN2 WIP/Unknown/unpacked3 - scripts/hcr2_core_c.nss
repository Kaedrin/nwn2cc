/*
Filename:           hcr2_core_c
System:             core (user configuration include script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 core variable user-configuration variable settings.
This script is consumed by hcr2_core_i as an include directive.

This contains user definable toggles and settings for the core system.

-----------------
Revision: v1.01
Added H2_DISABLE_RESPAWN_GUI configuration variable.
Eliminated H2_SAVE_PC_LOCATION setting, the state
of H2_SAVE_PC_LOCATION_TIMER_INTERVAL == 0.0 now serves this purpose.

Revision v1.05
Added H2_DEFAULT_LOGLEVEL configuation variable.
*/

//You may swap the below #include "hc2_core_t"  text directives for an equivalant language specific
//one. (All variable names must match however for it to compile properly.)
#include "hcr2_core_t"

//All below functions and constants may be overriden by the user, but do not alter the function signature
//or the name of the constant.

//Begin user configurable constant declarations.

//Set this value to a number less than or equal to the maximum number of players allowed
//on the server settings on nwserver. Each value less than the maximum allowed on the server
//settings provides one "always available" DM slot.
//If a non-dm player logs in, and this amount has been met or exceeded they will be booted.
//If the PC is booted, both the client enter and client leave hook-in scripts will not run for that PC.
//A value of zero or a value greater than or equal to the maximum number of players allowed on the
//server settings means no slots are reserved for the DMs.
//DMs do not count against this total, when number of player logged in is determined.
//The default value is 0.
const int H2_MAXIMUM_PLAYERS = 0;

//Time interval in real seconds between each location save for a PC. 
//180.0 = save location every 3 RL minutes.
//To turn off PC location saving, set this value to 0.0.
const float H2_SAVE_PC_LOCATION_TIMER_INTERVAL = 2400.0;

//Set the below to true to remove all starting equipment from a newly created character.
//The default value is FALSE.
const int H2_STRIP_ON_FIRST_LOGIN = FALSE;

//Set this value to the interval duration in seconds in which to export all characters.
//You should only change this value if you are using a server vault.
//Recommend setings are from 30.0 (seconds) to 300.0 (five minutes)
//depending on your server performance.
//Individual player exports also occur if this value is above 0 whenever they rest. or level up.
//The default value is 0.0.
const float H2_EXPORT_CHARACTERS_INTERVAL = 1800.0;

//Set this to the number of registered characters (alive or dead) that you want the player
//to be allowed to play. When a player chooses to retire a character it becomes unregistered
//and they are no longer allowed to play that character. If a player created a character after
//they have already attained the maximum number of registered characters allowed, they
//will not be able to play that character and will be booted.
//If a player logs in with a retired character they will be booted.
//If the PC is booted both the client enter and client leave hook-in scripts will not run for that PC.
//A value of zero means there is no limit to the number of characters they can play.
//When this value is zero the option to retire a character doesn't display.
//The default value is 0.
const int H2_REGISTERED_CHARACTERS_ALLOWED = 60;

//Set this to TRUE if you want the login message that shows the current game date and time to the
//entering player to be in the format: DD/MM/YYYY HH:MM instead of MM/DD/YYYY HH:MM.
//The default value is FALSE.
const int H2_SHOW_DAY_BEFORE_MONTH_IN_LOGIN = TRUE;

//Set this to the welcome message you want to be sent to all players (and DMs) that log into your module.
const string H2_TEXT_ON_LOGIN_MESSAGE = "Welcome to Forgotten Realms Dalelands.  Please visit our forums at www.DalelandsBeyond.com.\nWe are currently looking for new DMs, Area Builders, Scripters and Content Developers.  Please contact DM_Bucephalus on the forum if you are interested in making Dalelands a better server.";

//Set this value to TRUE is you want the
//gui_respawn_self script to do nothing. 
//You should set this to true if you are not using a respawn system,
//Or are not using the respawn via the gui_respawn_self script.
const int H2_DISABLE_RESPAWN_GUI = TRUE;

//Set this value to the level of HCR2 message logging desired.
//Possible values:
//0 = no messages. 
//1 = error messages only.
//2 = erros and warning messages.
//3 = erros, warning, and info messages.
//4 = error, warning, info and debug messages.
//If you are are running the HCR2_Test mod, this value is overriden to log at level 4.
const int H2_DEFAULT_LOGLEVEL = 1;

//Set this to true to indicate that you have read this file and made your adjustments to the above settings
//according to your module's needs. If this value is false all who login to the server will receive
//a message stating you have not altered it instead of the above H2_TEXT_ON_LOGIN_MESSAGE.
//The default value is FALSE.
const int H2_READ_CHECK = TRUE;

//End of user configurable constant declarations.