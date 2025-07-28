//::///////////////////////////////////////////////
//:: Teamwork (Nightsong Enforcer)
//:: cmi_s2_neteamwork
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "cmi_includes"

void main()
{
    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();
		
	if (!GetHasSpellEffect(SPELLABILITY_AURA_DC_TEAMINIT, OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(VFX_PER_NE_TEAMWORK);
		//Create an instance of the AOE Object using the Apply Effect function
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_AURA_DC_TEAMINIT, FALSE));
	    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget));
		
			
		effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		eVis = SupernaturalEffect(eVis);
		eVis = SetEffectSpellId (eVis, -SPELLABILITY_AURA_DC_TEAMINIT);
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget));	
						
	}
		
}