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
    
	int nHerosCall = GetHasFeat(FEAT_SKALD_HEROS_CALL);	
	int nImprovedHerosCall = GetHasFeat(FEAT_SKALD_IMPROVED_HEROS_CALL);		
	int nInspireToughness = GetHasFeat(FEAT_SKALD_INSPIRE_HEROICS_TOUGHNESS);
	
	int nCasterLvl = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR,OBJECT_SELF);
	nCasterLvl += GetLevelByClass(CLASS_SKALD,OBJECT_SELF);
	float fDuration = TurnsToSeconds( nCasterLvl + 5 );
	
	nCasterLvl+=10; //Free 10 points
	
	effect eBonus;
	effect eVis;
	effect eLink;			
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
		
		    float fDelay = GetRandomDelay(0.4, 1.1);
			
			if (nHerosCall)
			{
				if (nImprovedHerosCall)
				{
					if (GetCurrentHitPoints(oTarget) > (GetMaxHitPoints(oTarget)/2))
					{
						eBonus = EffectTemporaryHitpoints(nCasterLvl*3);
						eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
						eLink = EffectLinkEffects(eVis, eBonus);				
					}
					else
					{
						eBonus = EffectTemporaryHitpoints(nCasterLvl*2);
						eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
						eLink = EffectLinkEffects(eVis, eBonus);					
					}
					effect eAB = EffectAttackIncrease(1);
					eLink = EffectLinkEffects(eLink, eAB);
				}
				else
				{
					eBonus = EffectTemporaryHitpoints(nCasterLvl*2);
					eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
					eLink = EffectLinkEffects(eVis, eBonus);				
				}
					
				effect eSilenceImm = EffectImmunity(IMMUNITY_TYPE_SILENCE);				
				effect eDodgeAC = EffectACIncrease(1);
				eLink = EffectLinkEffects(eLink, eDodgeAC);
				eLink = EffectLinkEffects(eLink, eSilenceImm);
									
			}
			else
			{		
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
			}
			
			if (nInspireToughness)
			{
				effect eStunImm = EffectImmunity(IMMUNITY_TYPE_STUN);				
				eLink = EffectLinkEffects(eLink, eStunImm);
			}
			
		    RemoveEffectsFromSpell(oTarget, GetSpellId());			
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
				
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }	
	
}      