//	m01_a_teleport_sam
/*
	Transitions the party to the lumber camp in Samarach.
*/
//	JSH-OEI 5/27/08

#include "ginc_companion"
#include "ginc_overland"
void main()
{
	object oPC			= GetFirstPC();
	string sDestModule	= "G_X2";
	string sDestWP		= "u03_wp_from_m01";
	effect eTeleport	= EffectNWN2SpecialEffectFile("fx_teleport_new");
	
	PrettyDebug("Destination is " + sDestWP);
	
	/*while (GetIsObjectValid(oPC))
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTeleport, oPC);
		oPC = GetNextPC();
	}*/
	
	ExitOverlandMap(oPC);
	SaveRosterLoadModule(sDestModule, sDestWP);
}