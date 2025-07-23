/*
Filename:           gui_elu_onhotbarbuttonclick_e
System:             core (OnPreLevelUp event script)
Author:             Edward Beck (0100010)
Date Created:       Aug 2nd, 2009.
Summary:
ELU OnHotbarClick Event.
This gui script should be called via OnLeftClickX=UIObject_Misc_ExecuteServerScript
from the hotbar guis, whenever the player clicks on a hotbar button.

NOTE: OBJECT_SELF in this event is the Owning PlayerCharacter object.
-----------------
Revision: 

*/

#include "elu_functions_i"
#include "hcr2_core_i"

void main(string sButtonID)
{
	object oChar = GetControlledCharacter(OBJECT_SELF);
	SetLocalString(oChar, HOTBAR_BUTTON_ID, sButtonID);		
	h2_RunModuleEventScripts(H2_EVENT_ON_HOTBAR_CLICK);
}