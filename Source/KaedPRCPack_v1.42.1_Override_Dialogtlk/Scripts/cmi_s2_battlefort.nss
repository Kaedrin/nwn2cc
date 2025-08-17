//::///////////////////////////////////////////////
//:: Battle Fortitude
//:: cmi_s2_battlefort
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 23, 2009
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELLABILITY_SCOUT_BATTLEFORT;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	//At 2nd level, a scout gains a +1 bonus on Fortitude saves. This bonus increases to +2 at 11th, +3 at 20th, and +4 at 29th.
	int nScout = GetLevelByClass(CLASS_SCOUT, OBJECT_SELF);
	int nBonus = 1;
	nBonus += ((nScout - 2) / 9); 

	effect eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, nBonus);
	
	if (nScout > 17)
	{
	    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
	    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
	    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
	    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
		effect eHit = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
	
	    //Link effects
	    effect eLink = EffectLinkEffects(eParal, eEntangle);
	    eLink = EffectLinkEffects(eLink, eSlow);
	    eLink = EffectLinkEffects(eLink, eMove);
		eLink = EffectLinkEffects(eLink, eHit);	
		eFort = EffectLinkEffects(eLink, eFort);
	}

	eFort = SetEffectSpellId(eFort,nSpellId);
	eFort = SupernaturalEffect(eFort);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFort, OBJECT_SELF, HoursToSeconds(72)));	
}      