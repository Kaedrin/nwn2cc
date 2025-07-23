//::///////////////////////////////////////////////
//:: Boon of the Unlucky
//:: cmi_hx_boonunluck
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////


#include "cmi_ginc_chars"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
    object oTarget = GetSpellTargetObject();
    
	effect eVis = EffectVisualEffect( VFX_DUR_CESSATE_NEGATIVE );
	
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
	
	if (GetHasFeat(FEAT_HEX_AURUNLCK_1))
	{
		if (d100(1) > 10)
					DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEX_AURUNLCK_1);					
					
		IncrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);	
		
		if (d100(1) <= 5)
			IncrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);	
	}

	//Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0f);
}