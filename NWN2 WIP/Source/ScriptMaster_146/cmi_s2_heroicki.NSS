//::///////////////////////////////////////////////
//:: Arcane Heroism
//:: cmi_hx_archeroism
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 17, 2013
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{
	int nSpellId = SPELLABILITY_MONK_HEROICKI;		
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);		
	
    int nLevel = GetLevelByClass(CLASS_TYPE_MONK, OBJECT_SELF);
	int nHD = GetHitDice(OBJECT_SELF);
	if (nHD != nLevel)
		return;
				
	effect eLink;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_FOX_CUNNING);	
	float fDuration = HoursToSeconds(48);
			
	if (nLevel > 4) // Heroism or Greater Heroism
	{
    	int nHPs = nLevel;
		
		RemoveSpellEffects(857, OBJECT_SELF, OBJECT_SELF);	
		RemoveSpellEffects(SPELL_GREATER_HEROISM, OBJECT_SELF, OBJECT_SELF);			
		
		if (nLevel > 10) // Greater Heroism
		{
	        effect eAttack = EffectAttackIncrease(4);
	        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4, 

SAVING_THROW_TYPE_ALL);
	        effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, 4);
	        effect eHP = EffectTemporaryHitpoints(nHPs);
	        effect eFear = EffectImmunity(IMMUNITY_TYPE_FEAR);	
			
			
			if (nLevel > 12)
			{	
				if (GetHasFeat(FEAT_EPIC_DIAMOND_SOUL, OBJECT_SELF))
				{
					int nSR = nLevel + 14;
					
					//Revisist to clean up
					if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_1, OBJECT_SELF))
					{
						nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_2, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_3, OBJECT_SELF))
							nSR += 2;	
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_4, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_5, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_6, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_7, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_8, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_9, OBJECT_SELF))
							nSR += 2;
						if (GetHasFeat(FEAT_EPIC_IMPROVED_SPELL_RESISTANCE_10, OBJECT_SELF))
							nSR += 2;																																																	
					}
					
					effect eSR = EffectSpellResistanceIncrease(nSR);
					eLink = EffectLinkEffects(eLink, eSR);
				}
			}
			
			eLink = EffectLinkEffects(eLink, eAttack);
			eLink = EffectLinkEffects(eLink, eSave);			
	        eLink = EffectLinkEffects(eLink, eSkill);
	        eLink = EffectLinkEffects(eLink, eFear);	
		
			eHP = SetEffectSpellId(eHP,SPELL_GREATER_HEROISM);
			eHP = SupernaturalEffect(eHP);					
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF,fDuration);			
		}
		else // Heroism
		{
	        effect eAttack = EffectAttackIncrease(2);
	        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2, 

SAVING_THROW_TYPE_ALL);
	        effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, 2);
	        effect eHP = EffectTemporaryHitpoints(nHPs);
	        effect eFear = EffectImmunity(IMMUNITY_TYPE_FEAR);	
			
			eLink = EffectLinkEffects(eLink, eAttack);
			eLink = EffectLinkEffects(eLink, eSave);			
	        eLink = EffectLinkEffects(eLink, eSkill);
	        eLink = EffectLinkEffects(eLink, eFear);	
			
			eHP = SetEffectSpellId(eHP,SPELL_GREATER_HEROISM);
			eHP = SupernaturalEffect(eHP);	
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, 

fDuration);						
		}
	}		
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
				
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
	}