//	u02_a_leave_samargol
/*
	Does a module transition to the Overland Map.
*/
//	JSH-OEI 8/7/08

#include "ginc_debug"
#include "ginc_overland"
#include "ginc_companion"

void main(int nDestination)
{
	string sDestWP		= "g00_wp_from_samargol";
	string sDestModule	= "G_X2";
	
	object oPC 			= GetLastUsedBy();
	object oWP 			= GetWaypointByTag(sDestWP);
	
	ExitOverlandMap(oPC);
	SaveRosterLoadModule(sDestModule, sDestWP);
}