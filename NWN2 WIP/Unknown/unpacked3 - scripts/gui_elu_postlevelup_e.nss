/*
Filename:           gui_elu_prelevelup_e
System:             core (OnPreLevelUp event script)
Author:             Edward Beck (0100010)
Date Created:       Aug 2nd, 2009.
Summary:
ELU OnPreLevelUp Event.
This gui script should be called via OnLeftClickX=UIObject_Misc_ExecuteServerScript
from the characterscreen and levelup_* UI xml files on all the buttons which
display or commit a UI level up screen.

NOTE: OBJECT_SELF in this event is the Owning PlayerCharacter object.
-----------------
Revision: 

*/

#include "elu_functions_i"
#include "hcr2_core_i"

void main()
{
	ExecuteScript("gui_elu_prelevelup_e", OBJECT_SELF);
	object oChar = GetControlledCharacter(OBJECT_SELF);
	int bPreLevelUpFlag = GetLocalInt(oChar, PRELEVELUP_FLAG);
	if (!bPreLevelUpFlag)
	{
		string sLogMsg = GetPCPlayerName(OBJECT_SELF) + " " + GetName(oChar) + " reached OnPostLevelUp without having the PreLevelUp flag set.";
		h2_LogMessage(H2_LOG_ERROR, sLogMsg);
		return;
	}
	DeleteLocalInt(oChar, PRELEVELUP_FLAG);		
	AssignPuchasedSkillLevels(oChar);
	
	h2_RunModuleEventScripts(H2_EVENT_ON_POST_LEVEL_UP);
}