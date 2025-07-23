//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001


#include "hcr2_pccorpse_i"
#include "x2_inc_switches"

 

void main()
{
	int nSpellID = GetSpellId();
	
	if (nSpellID == 1157)
		nSpellID = 142;
		
	if (nSpellID == SPELL_RAISE_DEAD || nSpellID == SPELL_RESURRECTION)
	{
		object oTarget = GetSpellTargetObject();
		object oToken = GetLocalObject(oTarget, H2_PC_CORPSE_ITEM);
		if (GetIsObjectValid(oToken))
		{
			string sUniquePCID = GetLocalString(oToken, H2_DEAD_PLAYER_ID);
    		object oPC = h2_FindPCWithGivenUniqueID(sUniquePCID);
			object oCaster = OBJECT_SELF;
			
			// Hyper :: faithless cannot cast this spell
			if (GetDeity(oCaster) == "No Deity") {
				SendMessageToPC(oCaster, "No gods answer the faithless.");
				return;
			}

			if(GetPCPlayerName(oPC)!="")
			{
				// Hyper :: faithless cannot be brought back :(
				if (GetDeity(oPC) == "No Deity") {
					SendMessageToPC(oCaster, "The faithless soul cannot be brought back with divine help.");
				}
				// Avarson:: Abyssal pacters sold their souls for rock and roll
				else if (GetHasFeat(2300, oPC)) {
					SendMessageToPC(oCaster, "The soul does not answer your call.");
				}
				// Avarson:: Infernal pactsers sold their soul for sweet powers
				else if (GetHasFeat(2303, oPC)) {
					SendMessageToPC(oCaster, "The soul does not answer your call.");
				}
				else {
					h2_RemoveCorpse(oTarget);
					h2_RaiseSpellCastOnCorpseToken(nSpellID, oToken); 
				}
			}
			else
			{
				SendMessageToPC(oCaster, "The soul of this body has wondered away and cannot be brought back to the prime material.");
			}
		}			
	}
	}		
	