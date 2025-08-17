//	ka_olmap_visit_wp 
/*	Jumps the party to the waypoint whose tag is the same as the
	placeable's sTravelDest variable. Alternately, if you specify a tag of the Module or Waypoint, it'll work with that, too.
*/	`
//	Nchap
//	JSH-OEI 5/29/08 - Added autosave.

#include "ginc_debug"
#include "ginc_overland"
#include "ginc_companion"

void main(string sDestWPTag, string sDestModuleTag)
{
	if(sDestWPTag == "")
		sDestWPTag = GetDestWPTag();
	
	if(sDestModuleTag == "")
		sDestModuleTag = GetLocalString(OBJECT_SELF, "sDestModule");
	
	object oPC = GetLastUsedBy();
	object oWP = GetWaypointByTag(sDestWPTag);
	
	if( GetModuleName() == sDestModuleTag || sDestModuleTag == "")
	{
		PrettyDebug("Jumping " + GetName(oPC) + " to " + GetTag(oWP));
		oPC = GetFirstPC();
		ExitOverlandMap(oPC);		//This is a sanity check to verify that we don't hit any bugs dealing with saving.
		DoSinglePlayerAutoSave(); // Autosave
		JumpPartyToArea( oPC, oWP );
	}
	
	else
	{
		ExitOverlandMap(oPC);
		SaveRosterLoadModule(sDestModuleTag, sDestWPTag);
	}
}