//::///////////////////////////////////////////////
//:: Animal Growth
//:: cmi_s0_animgrow
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
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,8);
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
	effect eAC = EffectACIncrease(1);
	effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
	effect eAB = EffectAttackDecrease(1);
	effect eLink = EffectLinkEffects(eVis, eStr);
	eLink = EffectLinkEffects(eLink, eCon);
	eLink = EffectLinkEffects(eLink, eDex);
	eLink = EffectLinkEffects(eLink, eAB);
	eLink = EffectLinkEffects(eLink, eAC);				
	
	int nSpellId = GetSpellId();		
		
	int nMetaMagic = GetMetaMagicFeat();
    float fDuration = TurnsToSeconds(nCasterLevel);
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