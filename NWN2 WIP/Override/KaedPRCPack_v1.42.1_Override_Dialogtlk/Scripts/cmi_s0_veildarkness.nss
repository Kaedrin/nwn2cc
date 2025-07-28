//::///////////////////////////////////////////////
//:: Veil of Darkness
//:: cmi_s0_veildarkness
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 27, 2010
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = GetSpellId();
    int nDuration;		
	if (nSpellId == SPELL_BG_Darkness)
	{
		nDuration = GetBlackguardCasterLevel(OBJECT_SELF);
	}
	else if (nSpellId == SPELL_ASN_Spellbook_2 || nSpellId == SPELL_ASN_Darkness)
	{
		nDuration = GetAssassinCasterLevel(OBJECT_SELF);
	}
	else
	{
    	nDuration = GetCasterLevel(OBJECT_SELF);
	}	
	
  	object oTarget = GetSpellTargetObject();
	  	
	effect eConceal = EffectConcealment(20);	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		
	effect eLink = EffectLinkEffects(eVis, eConceal);
		
	float fDuration = TurnsToSeconds( nDuration );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		

    RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

}