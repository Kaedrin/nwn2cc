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
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);	
	int bPreLevelUpFlag = GetLocalInt(oControlledChar, PRELEVELUP_FLAG);
	if (bPreLevelUpFlag)
		return;		
	int nLevel = GetHitDice(oControlledChar);
	if (GetXP(oControlledChar) < GetMinimumXPRequiredForLevel(nLevel))
		return;
	SetLocalInt(oControlledChar, PRELEVELUP_FLAG, TRUE);
	DeleteLocalInt(oControlledChar, CANCELLEVELUP_FLAG);
			
	h2_RunModuleEventScripts(H2_EVENT_ON_PRE_LEVEL_UP);	
}