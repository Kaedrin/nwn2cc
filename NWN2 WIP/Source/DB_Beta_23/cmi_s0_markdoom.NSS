//::///////////////////////////////////////////////
//:: Mark of Doom
//:: cmi_s0_markdoom
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
		
	object oTarget = GetSpellTargetObject(); 
	int nSpellId = GetSpellId(); 
			
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = RoundsToSeconds(nCasterLvl);
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	effect eDmg = EffectDamageOverTime(d4() +2, 5.5f, DAMAGE_TYPE_DIVINE);
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_CREEPING_COLD);	
		
	RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, TRUE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmg, oTarget, fDuration);		  	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	
	
}      