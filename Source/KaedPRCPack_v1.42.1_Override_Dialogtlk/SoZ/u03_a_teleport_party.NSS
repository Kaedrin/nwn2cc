//	u03_a_teleport_party
/*
	Transitions the party to one of three random interiors on the Sword Coast.
*/
//	JSH-OEI 5/6/08
//	JSH-OEI 8/29/08 - After initial malfunction, party always returns to the HQ.

#include "ginc_companion"
#include "ginc_misc"
#include "ginc_overland"

void main()
{
	object oPC				= GetEnteringObject();
	object oPortalEffect	= GetNearestObjectByTag("fx_portal", oPC);
	string sDestModule		= "F_X2";
	int nRandom				= Random(3)+1;
	//string sDestWP		= "f00_from_g00_" + IntToString(nRandom);
	string sDestWP			= "f00_from_g00_1";
	effect eTeleport		= EffectNWN2SpecialEffectFile("fx_teleport_new");
	
	PrettyDebug("Destination is " + sDestWP);
	
	if (!GetIsPC(oPC))
		return;
	
	if (GetLocalInt(GetModule(), "g_bPortalActive") == FALSE)
		return;
	
	if ( !IsMarkedAsDone() )
	{
		SetGlobalInt("00_nStoryProgression", 15);
		
		MarkAsDone();
	}

	if (GetGlobalInt("00_bVisitedCK") == TRUE)
	{
		sDestModule = "M_X2";
		sDestWP	= "m01_wp_from_u03";
	}
	
	/*while (GetIsObjectValid(oPC))
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTeleport, oPC);
		oPC = GetNextPC();
	}*/
	
	SetLocalInt(GetModule(), "g_bPortalActive", FALSE);
	
	if (GetIsObjectValid(oPortalEffect))
	{
		DestroyObject(oPortalEffect);
	}
	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eTeleport, oPC);
	
	ExitOverlandMap(oPC);
	SaveRosterLoadModule(sDestModule, sDestWP);
	
}