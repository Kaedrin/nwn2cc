//::///////////////////////////////////////////////
//:: Plant Body
//:: cmi_s0_plantbody
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 8, 2008
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	
	float fDuration = TurnsToSeconds( nCasterLvl * 10 );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eCrit = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
	effect eMind = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
	effect ePsn = EffectImmunity(IMMUNITY_TYPE_POISON);
	effect ePara = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
	effect eSneak = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
	effect eSleep = EffectImmunity(IMMUNITY_TYPE_SLEEP);
	effect eStun = EffectImmunity(IMMUNITY_TYPE_STUN);
		
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	
	effect eLink = EffectLinkEffects(eVis, eCrit);
	eLink = EffectLinkEffects(eLink, eMind);
	eLink = EffectLinkEffects(eLink, ePsn);
	eLink = EffectLinkEffects(eLink, ePara);
	eLink = EffectLinkEffects(eLink, eSneak);
	eLink = EffectLinkEffects(eLink, eSleep);
	eLink = EffectLinkEffects(eLink, eStun);					
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
		
}  