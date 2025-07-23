//::///////////////////////////////////////////////
//:: Strength of Stone
//:: cmi_s0_strofstone
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 25, 2007
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
	
	int nCasterLvl = GetPalRngCasterLevel();
    	
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,8);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_GREATER_STONESKIN );	
	effect eLink = EffectLinkEffects(eVis, eStr);	
	
	float fDuration = RoundsToSeconds(nCasterLvl);
	fDuration = ApplyMetamagicDurationMods(fDuration);
			
	//Should be an Instant effect
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
}      