//::///////////////////////////////////////////////
//:: Curse of Lethargy
//:: cmi_hx_curseleth
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 25, 2011
//:://////////////////////////////////////////////

#include "x2_i0_spells"
#include "cmi_ginc_chars"

void main()
{
   /*
   if (!GetHasFeat(FEAT_HEXCURSE_1, OBJECT_SELF))
   {
		FloatingTextStringOnCreature(HEX_NO_VALID_CURSES,OBJECT_SELF);
        return;
   }
   */
   
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
	
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_VAMPIRIC_FEAST);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));			

    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF);
	int nEpic = FALSE;
	
	if (nLevel > 25)
	{
	    if(GetHasFeat(FEAT_HEXBLADE_EPIC_CURSE)) // Epic Curse
	    {
	        nEpic = TRUE;
	    }
	}
	
	float fDuration = HoursToSeconds(1);
    if(GetHasFeat(FEAT_HEXBLADE_LINGERING_CURSE)) // lingering curse
    {
        fDuration = fDuration * 2;
    }
	
    effect eDur  = EffectVisualEffect(VFX_DUR_CURSESONG);    
	effect eSlow = EffectSlow();
	
	effect eLink = EffectLinkEffects(eDur, eSlow);
	if (nEpic)
	{
		effect eSlash = EffectDamageDecrease(5, DAMAGE_TYPE_SLASHING);
		effect ePierce = EffectDamageDecrease(5, DAMAGE_TYPE_PIERCING);
		effect eCrush = EffectDamageDecrease(5, DAMAGE_TYPE_BLUDGEONING);	
		eLink = EffectLinkEffects(eLink, eSlash);			
		eLink = EffectLinkEffects(eLink, ePierce);	
		eLink = EffectLinkEffects(eLink, eCrush);					
	}	

    eLink = SetEffectSpellId(eLink, SPELLABILITY_HEX_CURSE_LETH);
	eLink = SupernaturalEffect(eLink);
	
	effect eImpactVis = EffectVisualEffect(VFX_HIT_SPELL_CURSE_OF_IMPENDING_BLADES);
    object oTarget = GetSpellTargetObject();
	location lTarget = GetSpellTargetLocation();	
	object oTarget2 = oTarget;
	int nAffected = 0;
    while(GetIsObjectValid(oTarget2))
    {
        if(spellsIsTarget(oTarget2, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			SignalEvent(oTarget2, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HEX_CURSE_LETH)); 
			if (!MySavingThrow(SAVING_THROW_WILL, oTarget2, GetHexbladeDC(nLevel/2), SAVING_THROW_TYPE_ALL))
			{
    			RemoveEffectsFromSpell(oTarget2, SPELLABILITY_HEX_CURSE_LETH);					
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget2));
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget2, fDuration));
				nAffected++;
			}
        }
        oTarget2 = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }	
	
	if (nAffected > 0)
    	DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);
	
}