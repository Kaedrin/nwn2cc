//::///////////////////////////////////////////////
//:: Sacred Haven
//:: cmi_s0_sachaven
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
    	
	effect eAC = EffectACIncrease(2);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_GREATER_HEROISM);
	effect eLink = EffectLinkEffects(eAC, eVis);
	
	object oTarget = GetSpellTargetObject();	
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
    RemoveEffectsFromSpell(oTarget, GetSpellId());	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      