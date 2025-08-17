//::///////////////////////////////////////////////
//:: Heroic Ki
//:: cmi_s2_heroicki
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 25, 2015
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{
	int nSpellId = SPELLABILITY_HEXBLADE_ARCHEROISM;
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	
    int nLevel = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF);
	
	effect eLink;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_FOX_CUNNING);	
	float fDuration = HoursToSeconds(48);
			
	if (nLevel > 4) // Heroism or Greater Heroism
	{
    	int nHPs = nLevel;
		
		RemoveSpellEffects(857, OBJECT_SELF, OBJECT_SELF);	
		RemoveSpellEffects(SPELL_GREATER_HEROISM, OBJECT_SELF, OBJECT_SELF);			
		
		if (nLevel > 12) // Greater Heroism
		{
	        effect eAttack = EffectAttackIncrease(4);
	        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4, 

SAVING_THROW_TYPE_ALL);
	        effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, 4);
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