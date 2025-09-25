//::///////////////////////////////////////////////
//:: Silverbeard
//:: cmi_s0_silverbeard
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 25, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_spells"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    	
	effect eAC = EffectACIncrease(2);
	effect eSkill = EffectSkillIncrease(SKILL_DIPLOMACY, 2);
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		
	effect eLink = EffectLinkEffects(eSkill, eAC);	
	eLink = EffectLinkEffects(eLink,eVis);		
	
    int nCasterLvl = GetPalRngCasterLevel();
	
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
			
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());	
	//Instant effect
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
}      