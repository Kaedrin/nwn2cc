//::///////////////////////////////////////////////
//:: Nature's Favor
//:: cmi_s0_natfavor
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 15, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "x0_i0_spells"

#include "cmi_ginc_spells"
void main()
{


    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nCasterLevel = GetPalRngCasterLevel();
	int nBonus = nCasterLevel/3;
	
	if (nBonus > 5)
		nBonus = 5;
	
    object oTarget = GetSpellTargetObject();
    effect eAB = EffectAttackIncrease(nBonus);
    effect eDam = EffectDamageIncrease(nBonus);	
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_AWAKEN );	// NWN2 VFX
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = TurnsToSeconds(nCasterLevel);
	
    if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION) == oTarget)
    {
        if(!GetHasSpellEffect(GetSpellId()))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
			fDuration = ApplyMetamagicDurationMods(fDuration);
            effect eLink = EffectLinkEffects(eAB, eDam);
			eLink = EffectLinkEffects(eLink, eVis);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        }
    }
}