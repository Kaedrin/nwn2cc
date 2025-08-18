//::///////////////////////////////////////////////
//:: Hexblade's Curse Shadows
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
	
	float fDuration = HoursToSeconds(1);
    if(GetHasFeat(FEAT_HEXBLADE_LINGERING_CURSE)) // lingering curse
    {
        fDuration = fDuration * 2;
    }
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
		
    effect eDur  = EffectVisualEffect(VFX_DUR_CURSESONG);  
	
	int nConceal = 5;
	if(GetHasFeat(FEAT_HEXBLADE_EPIC_CURSE, OBJECT_SELF))
		nConceal = 20;
	else	
	if (nLevel > 18)
		nConceal = 15;
	else
	if (nLevel > 6)
		nConceal = 10;
	  
	effect eConcealSight = EffectMissChance(nConceal);
	
	int nWillDebuff = GetHasFeat(FEAT_HEXBLADE_ABILITY_FOCUS, OBJECT_SELF);
	effect eSaveDebuff = EffectSavingThrowDecrease(SAVING_THROW_WILL, 4);	
		
	effect eLink = EffectLinkEffects(eDur, eConcealSight);
	
	if (GetHasFeat(FEAT_VENGTAKE_EMPOWERED_CURSES))
	{
		fDuration += RoundsToSeconds(2);
		nDC += 2;
		effect eNegLevel = EffectNegativeLevel(2);
		eSaveDebuff = EffectLinkEffects(eSaveDebuff, eNegLevel);
	}		

	if (nWillDebuff)
		eLink = EffectLinkEffects(eLink, eSaveDebuff);
			
    eLink = SetEffectSpellId(eLink, SPELLABILITY_VENGTAKE_CURSE_SHADOWS);
	eLink = SupernaturalEffect(eLink);
	
	effect eImpactVis = EffectVisualEffect(VFX_HIT_SPELL_CURSE_OF_IMPENDING_BLADES);
	location lTarget = GetSpellTargetLocation();	
	object oTarget2 = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	int nAffected = 0;
    while(GetIsObjectValid(oTarget2))
    {
        if(spellsIsTarget(oTarget2, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			SignalEvent(oTarget2, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_VENGTAKE_CURSE_SHADOWS)); 
			if (!MySavingThrow(SAVING_THROW_WILL, oTarget2, nDC, SAVING_THROW_TYPE_ALL))
			{
    			DelayCommand(0.1f, RemoveEffectsFromSpell(oTarget2, SPELLABILITY_VENGTAKE_CURSE_SHADOWS));					
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget2));
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget2, fDuration));
				nAffected++;
			}
			else
			{
				DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveDebuff, oTarget2, fDuration));				
			}			
        }
        oTarget2 = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }	
	
	if (nAffected > 0)
    	DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);
	
}