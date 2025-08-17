//::///////////////////////////////////////////////
//:: Adrenaline Boost
//:: cmi_s2_adrenboost
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
    	
	
	int nCasterLvl = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR,OBJECT_SELF);
	float fDuration = TurnsToSeconds( nCasterLvl );
	
	effect eBonus;
	effect eVis;
	effect eLink;			

	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
		
		    float fDelay = GetRandomDelay(0.4, 1.1);
			
			if (GetCurrentHitPoints(oTarget) > (GetMaxHitPoints(oTarget)/2))
			{
				eBonus = EffectTemporaryHitpoints(nCasterLvl);
				eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
				eLink = EffectLinkEffects(eVis, eBonus);				
			}
			else
			{
				eBonus = EffectTemporaryHitpoints(nCasterLvl*2);
				eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
				eLink = EffectLinkEffects(eVis, eBonus);				
			}
			
		    RemoveEffectsFromSpell(oTarget, GetSpellId());			
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
				
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }	
	
}      