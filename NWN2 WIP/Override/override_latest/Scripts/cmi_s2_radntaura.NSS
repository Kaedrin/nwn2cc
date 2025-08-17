//::///////////////////////////////////////////////
//:: Radiant Aura
//:: cmi_s2_radntaura
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////
//:: Based on Aura of Despair

#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{
    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();

	if (!GetHasSpellEffect(SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA, OBJECT_SELF))
	{
		effect eVis = EffectVisualEffect(924); //Body of the Sun		
		effect eAOE = EffectAreaOfEffect(VFX_PER_RADIANT_AURA);
		effect eLink = EffectLinkEffects(eAOE, eVis);	
		eLink = SetEffectSpellId(eLink, SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA);
		eLink = SupernaturalEffect(eLink); 	
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA, FALSE));
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(1));
	}
		
}