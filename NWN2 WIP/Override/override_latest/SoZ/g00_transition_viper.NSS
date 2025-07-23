//	g00_transition_viper
/*
	Does a transition to either the front area or rear area of the
	Viper Temple, depending on how the player exited.
*/
//	JSH-OEI 8/22/08

#include "ginc_debug"
#include "ginc_overland"
#include "ginc_companion"

void main(int nCase)
{
	string sDestWP;
	string sDestModule	= GetLocalString(OBJECT_SELF, "sDestModule");
	
	object oPC = GetLastUsedBy();
	object oWP = GetWaypointByTag(sDestWP);
	
	switch(nCase)
	{
		case 100:
			sDestWP		= "o01front_wp_from_g00";
			break;
		case 200:
			sDestWP		= "o01rear_wp_from_g00";
			break;
		default:
			break;
	}
	
	ExitOverlandMap(oPC);
	SaveRosterLoadModule(sDestModule, sDestWP);
}