//::///////////////////////////////////////////////
//:: cwhit_tracking
//:: Purpose: Provide a toggle to suppress tracking messages
//:: Created By: Chris Whitaker for Dalelands Beyond PW
//:: Created On: March 8, 2011
//:://////////////////////////////////////////////

#include "nwnx_sql"
void main()
{
    // This is the Object to apply the effect to.
    object oPC = OBJECT_SELF;
	
	if (GetLocalInt(oPC, "SHOW_TRACKING")) {
	   SetLocalInt(oPC, "SHOW_TRACKING", FALSE);
	   SetPersistentInt(oPC, "SHOW_TRACKING", FALSE, 0, "dbtools");
	   SendMessageToPC(oPC, "Tracking messages are now suppressed.");
	} else {
	   SetLocalInt(oPC, "SHOW_TRACKING", TRUE);
	   SetPersistentInt(oPC, "SHOW_TRACKING", TRUE, 0, "dbtools");
	   SendMessageToPC(oPC, "Tracking messages are now displayed.");
	}
	
}