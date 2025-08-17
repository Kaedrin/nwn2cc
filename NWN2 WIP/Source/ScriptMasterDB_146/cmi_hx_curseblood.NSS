//::///////////////////////////////////////////////
//:: Hexblade's Curse Blood
//:: cmi_hx_curse
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 27, 2015
//:://////////////////////////////////////////////

#include "x2_i0_spells"
#include "cmi_ginc_chars"

void main()
{

    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
	
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_VAMPIRIC_FEAST);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));			

    //Declare major variables
    int nLevel = GetHexbladeCurseLevel(OBJECT_SELF);	
	int nDC = GetHexbladeDC(nLevel/2);
	
	float fDuration = RoundsToSeconds(nLevel);
    if(GetHasFeat(FEAT_HEXBLADE_LINGERING_CURSE)) // lingering curse
    {
        fDuration = (fDuration * 3) / 2;
    }	
		
    effect eDur  = EffectVisualEffect(VFX_DUR_CURSESONG);   
	effect eDoT = EffectDamageOverTime(nLevel, RoundsToSeconds(1), DAMAGE_TYPE_ALL);
	
	int nWillDebuff = GetHasFeat(FEAT_HEXBLADE_ABILITY_FOCUS, OBJECT_SELF);
	effect eSaveDebuff = EffectSavingThrowDecrease(SAVING_THROW_WILL, 4);	
		
	effect eLink = EffectLinkEffects(eDur, eDoT);
	
	if (GetHasFeat(FEAT_VENGTAKE_EMPOWERED_CURSES))
	{
		fDuration += RoundsToSeconds(2);
		nDC += 2;
		effect eNegLevel = EffectNegativeLevel(2);
		eSaveDebuff = EffectLinkEffects(eSaveDebuff, eNegLevel);
	}		

	if (nWillDebuff)
		eLink = EffectLinkEffects(eLink, eSaveDebuff);
			
    eLink = SetEffectSpellId(eLink, SPELLABILITY_VENGTAKE_CURSE_BLOOD);
	eLink = SupernaturalEffect(eLink);
	
	effect eImpactVis = EffectVisualEffect(VFX_HIT_SPELL_CURSE_OF_IMPENDING_BLADES);
	
	int nAffected = 0;	
	object oTarget = GetSpellTargetObject();	    
	if(GetIsObjectValid(oTarget))
	{
		if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
	    {
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_VENGTAKE_CURSE_BLOOD)); 
			if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_ALL))
			{
	    		RemoveEffectsFromSpell(oTarget, SPELLABILITY_VENGTAKE_CURSE_BLOOD);		
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget));
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
				nAffected++;
			}
			else
			{
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveDebuff, oTarget, fDuration));				
			}					
	    }
	}		
	
	if (nAffected > 0)
    	DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);
	
}