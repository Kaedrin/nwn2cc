//::///////////////////////////////////////////////
//:: Hexblade's Curse
//:: cmi_hx_curse
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
	
	int nPenalty = 2;	
	if (nLevel > 18)
		nPenalty = 6;
	else
	if (nLevel > 6)
		nPenalty = 4;
	if (nLevel > 25)
	{
	    if(GetHasFeat(FEAT_HEXBLADE_EPIC_CURSE)) // Epic Curse
	    {
	        nPenalty += 2;
	    }
	}
	
	float fDuration = HoursToSeconds(1);
    if(GetHasFeat(FEAT_HEXBLADE_LINGERING_CURSE)) // lingering curse
    {
        fDuration = fDuration * 2;
    }
	
	int nAreaCurse = FALSE;
	
	if (nLevel >= 20)
		nAreaCurse = GetHasFeat(FEAT_HEXBLADE_EPIC_MISFORTUNE);

	effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nPenalty);
	effect eAC = EffectACDecrease(nPenalty, AC_DODGE_BONUS);
	effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, nPenalty);
    effect eAttack = EffectAttackDecrease(nPenalty);
    effect eDur  = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);    
	
	effect eLink = EffectLinkEffects(eSkill, eAC);
	eLink = EffectLinkEffects(eLink,eSave);
	eLink = EffectLinkEffects(eLink,eAttack);	
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = SetEffectSpellId(eLink, SPELLABILITY_HEX_CURSE);
	eLink = SupernaturalEffect(eLink);
	
	effect eImpactVis = EffectVisualEffect(VFX_HIT_SPELL_CURSE_OF_IMPENDING_BLADES);
    object oTarget = GetSpellTargetObject();
	location lLocation = GetSpellTargetLocation();
	/*	
    if(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_EPIC_CURSE_SONG)); 
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        }
    }
	*/
	
	int nAffected = 0;
	if (nAreaCurse)
	{
		oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLocation);
	    while(GetIsObjectValid(oTarget))
	    {
	        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
	        {
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HEX_CURSE)); 
				if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetHexbladeDC(nLevel/2), SAVING_THROW_TYPE_ALL))
				{
	    			RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE);		
					DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget));
					DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
					nAffected++;
				}
	        }
	        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLocation);
	    }	
	}
	else
	{
	    if(GetIsObjectValid(oTarget))
	    {
	        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
	        {
					SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HEX_CURSE)); 
					if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetHexbladeDC(nLevel/2), SAVING_THROW_TYPE_ALL))
					{
		    			RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE);		
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget));
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
						nAffected++;
					}
	        }
	    }	
	}
	
	if (nAffected == 0)
    	IncrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);
		
//  SendMessageToPC(OBJECT_SELF, "nPenalty: " + IntToString(nPenalty));
//	SendMessageToPC(OBJECT_SELF, "nAffected: " + IntToString(nAffected));
//	SendMessageToPC(OBJECT_SELF, "fDuration: " + FloatToString(fDuration));
	
	
	
}