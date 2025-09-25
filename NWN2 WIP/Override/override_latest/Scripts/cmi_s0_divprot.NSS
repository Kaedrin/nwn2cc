//::///////////////////////////////////////////////
//:: Divine Protection
//:: cmi_s0_divprot
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
    	
	effect eBonus = EffectACIncrease(1);
	effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
	effect eLink = EffectLinkEffects(eBonus, eSaves);
	eLink = EffectLinkEffects(eLink, eVis);	
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF) && (oTarget != OBJECT_SELF))
        {
				
			float fDelay = GetRandomDelay(0.4, 1.1);
				
			RemoveEffectsFromSpell(oTarget, GetSpellId());			
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));				
  					
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }
	
	if (GetLastSpellCastClass() == CLASS_TYPE_PALADIN)		
	{
		RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());			
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));				
	}	
}      