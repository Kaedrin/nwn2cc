/*
Filename:           gui_elu_cancellevelup_e
System:             core (OnCancelLevelUp event script)
Author:             Edward Beck (0100010)
Date Created:       Aug 2nd, 2009.
Summary:
elu OnCancelLevelUp Event.
This gui script should be called via OnLeftClickX=UIObject_Misc_ExecuteServerScript
from the characterscreen and levelup_* UI xml files on all the buttons which
cancel out of the level up UI screens.

NOTE: OBJECT_SELF in this event is the Owning PlayerCharacter object.
-----------------
Revision: 

*/

#include "elu_functions_i"
#include "hcr2_core_i"

void main()
{
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);
	int bPreLevelUpFlag = GetLocalInt(oControlledChar, PRELEVELUP_FLAG);
	if (!bPreLevelUpFlag)
		return;			
	int bCancelLevelUpFlag = GetLocalInt(oControlledChar, CANCELLEVELUP_FLAG);
	if (bCancelLevelUpFlag)
		return;
	SetLocalInt(oControlledChar, CANCELLEVELUP_FLAG, TRUE);
	DeleteLocalInt(oControlledChar, PRELEVELUP_FLAG);
	
	h2_RunModuleEventScripts(H2_EVENT_ON_CANCEL_LEVEL_UP);			
}