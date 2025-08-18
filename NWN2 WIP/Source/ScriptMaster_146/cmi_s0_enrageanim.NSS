//::///////////////////////////////////////////////
//:: Enrage Animal
//:: cmi_s0_enrageanim
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
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
	
    object oTarget = GetSpellTargetObject();

    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_AWAKEN );	// NWN2 VFX
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,4);
	effect eAC = EffectACIncrease(2);
	effect eDex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, 2);
	effect eAB = EffectAttackDecrease(2);
	effect eAtk = EffectModifyAttacks(1);
	effect eLink = EffectLinkEffects(eVis, eStr);
	eLink = EffectLinkEffects(eLink, eAC);
	eLink = EffectLinkEffects(eLink, eDex);
	eLink = EffectLinkEffects(eLink, eAB);
	eLink = EffectLinkEffects(eLink, eAtk);				
	
	int nSpellId = GetSpellId();		
		
	int nMetaMagic = GetMetaMagicFeat();
    float fDuration = RoundsToSeconds(nCasterLevel);
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
    if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION) == oTarget)
    {
        if(GetHasSpellEffect(nSpellId))
        {
			RemoveEffectsFromSpell(oTarget, nSpellId);
        }
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    }
}