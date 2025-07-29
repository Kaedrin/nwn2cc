/*
Filename:           hcr2_playerlevelup_e
System:             core (player level up event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerLevelUp Event.
This script should be attachted to the OnPlayerLevelUp event under
the scripts section of Module properties.

-----------------
Revision: v1.05
Added some debug logging
Moved export character code to after the hook events 
are finished running.
Altered logging code

*/
#include "hcr2_core_i"

void main()
{
	object oPC = GetPCLevellingUp();
	string sLevelUpLog = GetName(oPC) + "_" + GetPCPlayerName(oPC) + H2_TEXT_LOG_PLAYER_LEVELUP + IntToString(GetHitDice(oPC));
    h2_LogMessage(H2_LOG_INFO,sLevelUpLog);							
    h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_LEVEL_UP);	
	if (H2_EXPORT_CHARACTERS_INTERVAL > 0.0)
		ExportSingleCharacter(oPC);
	//object oPC = GetPCLevellingUp();
	ExecuteScript("cmi_player_levelup", oPC );
}