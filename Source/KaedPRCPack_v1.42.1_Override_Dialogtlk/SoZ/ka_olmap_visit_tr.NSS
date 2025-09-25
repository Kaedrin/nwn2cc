//	ka_olmap_visit_wp 
/*	Jumps the party to the waypoint whose tag is the same as the
	placeable's sTravelDest variable. Alternately, if you specify a tag, it'll work with that, too.
*/ 
//	Nchap
//	JSH-OEI 5/29/08 - Added autosave.

#include "ginc_debug"
#include "ginc_overland"
#include "ginc_companion"

void main()
{
	string sDestWP = GetDestWPTag();
	string sDestModule = GetLocalString(OBJECT_SELF, "sDestModule");
	
	object oPC = GetEnteringObject();
	object oWP = GetWaypointByTag(sDestWP);
	
	if(!GetIsPC(oPC))
		return;

	object oFM = GetFirstFactionMember( oPC, FALSE );

	while ( GetIsObjectValid( oFM ) == TRUE )
	{
		effect eEffect = GetFirstEffect(oFM);
		while(GetIsEffectValid(eEffect))
		{
			if(GetEffectType(eEffect) == EFFECT_TYPE_HITPOINT_CHANGE_WHEN_DYING)
			{
				if(GetEffectInteger(eEffect, 0) != TRUE)
				{
					effect eDeath = EffectDeath(FALSE,FALSE,TRUE,TRUE);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oFM);
				}
			}
			
			eEffect = GetNextEffect(oFM);
		}
		oFM = GetNextFactionMember( oPC, FALSE );
	}	
	
	if( GetModuleName() == sDestModule || sDestModule == "")
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
		SaveRosterLoadModule(sDestModule, sDestWP);
	}
}