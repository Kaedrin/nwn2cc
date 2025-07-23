//::///////////////////////////////////////////////
//:: Song of Fury
//:: cmi_s2_sngfury
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 19, 2008
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


	object oPC = OBJECT_SELF;
	int nSpellId = BLADESINGER_SONG_FURY;		
	
	int bHasSongFury = GetHasSpellEffect(nSpellId,oPC);
	if (bHasSongFury)
	{
		SendMessageToPC(oPC, "Song of Fury disabled.");	
		RemoveSpellEffects(nSpellId, oPC, oPC);
	}
	else
	{
	
		int bSongFuryValid = IsBladesingerValid();	
		if (bSongFuryValid)
		{
			//RemoveSpellEffects(nSpellId, oPC, oPC);
					
			effect eBonusAttack = EffectModifyAttacks(1);
			effect eAB = EffectAttackDecrease(2);
			effect eLink = EffectLinkEffects(eAB, eBonusAttack);
			eLink =  SupernaturalEffect(eLink);		
			eLink = SetEffectSpellId(eLink,nSpellId);
			
			if (!bHasSongFury)
				SendMessageToPC(oPC,"Song of Fury enabled.");			
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPC);			
		}
		else
		{
		    //RemoveSpellEffects(nSpellId, oPC, oPC);
			if (bHasSongFury)
				SendMessageToPC(oPC,"Song of Fury disabled, it is only valid when wielding a longsword or rapier in one hand (and nothing in the other) and wearing light or no armor.");			
		}
	}
	
	
		
}      