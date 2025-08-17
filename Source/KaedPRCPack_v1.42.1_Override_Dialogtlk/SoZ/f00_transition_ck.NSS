//	f00_transition_ck
/*
	Does a transition to an area in Crossroad Keep.
*/
//	JSH-OEI 8/5/08

#include "ginc_debug"
#include "ginc_companion"
#include "ginc_overland"

void main()
{
	string sDestWP		= "m03_wp_from_f00";
	string sDestModule	= GetLocalString(OBJECT_SELF, "sDestModule");
	
	object oPC = GetLastUsedBy();
	object oWP = GetWaypointByTag(sDestWP);
	
	ExitOverlandMap(oPC);
	SaveRosterLoadModule(sDestModule, sDestWP);
}