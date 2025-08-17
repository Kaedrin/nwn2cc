//::///////////////////////////////////////////////
//:: Ninja - Ghost Walk
//:: cmi_s2_ninjagwalk
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	if (IsNoArmorValid())
	{
		int nSpellId = SPELLABILITY_NINJA_GHOST_WALK;
		float fDuration = RoundsToSeconds(GetLevelByClass(CLASS_NINJA, OBJECT_SELF));
		
		effect eVis = EffectVisualEffect( VFX_DUR_INVISIBILITY );
	    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
		effect eLink = EffectLinkEffects( eInvis, eVis );
		effect eSanc = EffectEthereal();
		eLink = EffectLinkEffects(eLink, eSanc);	
				
		eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);	
		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_NINJA_KI_POWER_1);
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_NINJA_KI_POWER_1);		
	}					
	else
		SendMessageToPC(OBJECT_SELF, "You may not use this ability while wearing armor.");					
}