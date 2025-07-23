//::///////////////////////////////////////////////
//:: Arcane Resistance
//:: cmi_hx_arcres
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 27, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void  AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}

void main()
{

	int nSpellId = SPELLABILITY_FACTOTUM_ARCDIL;

	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	

    int nLevel = GetLevelByClass(CLASS_FACTOTUM, OBJECT_SELF);
	
	effect eAC;
	effect eLink;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_FOX_CUNNING);	
	float fDuration = HoursToSeconds(48);
			
	if (nLevel > 9) //Improved Mage Armor
		eAC = EffectACIncrease(6, AC_ARMOUR_ENCHANTMENT_BONUS);
	else //Mage Armor
		eAC = EffectACIncrease(4, AC_ARMOUR_ENCHANTMENT_BONUS);

	//Core effect established at level 2	
	eLink = EffectLinkEffects(eAC, eVis);
		
	if (nLevel > 2) //Brains over Brawn code
	{
		int nBrainsSkillBonus = 0;
		
		if (nLevel > 13)
			nBrainsSkillBonus = 4;
		else
		if (nLevel > 5)
			nBrainsSkillBonus = 2;
		nBrainsSkillBonus += (nLevel/2);
		
		effect eSKILL_HIDE = EffectSkillIncrease(SKILL_HIDE,nBrainsSkillBonus);
		effect eSKILL_MOVE_SILENTLY = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nBrainsSkillBonus);
		effect eSKILL_OPEN_LOCK = EffectSkillIncrease(SKILL_OPEN_LOCK,nBrainsSkillBonus);
		effect eSKILL_PARRY = EffectSkillIncrease(SKILL_PARRY,nBrainsSkillBonus);
		effect eSKILL_SET_TRAP = EffectSkillIncrease(SKILL_SET_TRAP,nBrainsSkillBonus);
		effect eSKILL_SLEIGHT_OF_HAND = EffectSkillIncrease(SKILL_SLEIGHT_OF_HAND,nBrainsSkillBonus);
		effect eSKILL_TUMBLE = EffectSkillIncrease(SKILL_TUMBLE,nBrainsSkillBonus);
															
			
		//Hide, Move Silently, Open Lock, Parry, Set Trap, Sleight of Hand, and Tumble.

				
	    eLink = EffectLinkEffects(eLink, eSKILL_HIDE);			
	    eLink = EffectLinkEffects(eLink, eSKILL_MOVE_SILENTLY);		
	    eLink = EffectLinkEffects(eLink, eSKILL_OPEN_LOCK);		
	    eLink = EffectLinkEffects(eLink, eSKILL_PARRY);		
	    eLink = EffectLinkEffects(eLink, eSKILL_SET_TRAP);		
	    eLink = EffectLinkEffects(eLink, eSKILL_SLEIGHT_OF_HAND);		
	    eLink = EffectLinkEffects(eLink, eSKILL_TUMBLE);				
		
	}	
	
	if (nLevel > 3) // Ghostly Visage
	{
	    effect eDam = EffectDamageReduction(5, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);		// 3.5 DR approximation
	    effect eSpell = EffectSpellLevelAbsorption(1);
	    effect eConceal = EffectConcealment(10);
	    eLink = EffectLinkEffects(eLink, eDam);
	    eLink = EffectLinkEffects(eLink, eSpell);
	    eLink = EffectLinkEffects(eLink, eConceal);	
	}
	
	if (nLevel > 5) // Heroism or Greater Heroism
	{
    	int nHPs = nLevel;
		
		//RemoveSpellEffects(857, OBJECT_SELF, OBJECT_SELF);	
		//RemoveSpellEffects(SPELL_GREATER_HEROISM, OBJECT_SELF, OBJECT_SELF);			
		
		if (nLevel > 13) // Greater Heroism
		{
	        effect eAttack = EffectAttackIncrease(4);
	        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4, SAVING_THROW_TYPE_ALL);
	        effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, 4);
	        effect eHP = EffectTemporaryHitpoints(nHPs);
	        effect eFear = EffectImmunity(IMMUNITY_TYPE_FEAR);	
			
			eLink = EffectLinkEffects(eLink, eAttack);
			eLink = EffectLinkEffects(eLink, eSave);			
	        eLink = EffectLinkEffects(eLink, eSkill);
	        eLink = EffectLinkEffects(eLink, eFear);	
			
			eHP = SetEffectSpellId(eHP,SPELL_GREATER_HEROISM);			
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, fDuration);			
		}
		else // Heroism
		{
	        effect eAttack = EffectAttackIncrease(2);
	        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL);
	        effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, 2);
	        effect eHP = EffectTemporaryHitpoints(nHPs);
	        effect eFear = EffectImmunity(IMMUNITY_TYPE_FEAR);	
			
			eLink = EffectLinkEffects(eLink, eAttack);
			eLink = EffectLinkEffects(eLink, eSave);			
	        eLink = EffectLinkEffects(eLink, eSkill);
	        eLink = EffectLinkEffects(eLink, eFear);	
			
			eHP = SetEffectSpellId(eHP,SPELL_GREATER_HEROISM);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, fDuration);						
		}
	}		
	
	if (nLevel > 6) // Greater Magic Weapon
	{
	    int nCasterLvl = nLevel / 4;	
	    if(nCasterLvl > 5)
	    {
	        nCasterLvl = 5;
	    }		
	    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();
	
	    if(GetIsObjectValid(oMyWeapon) )
	    {
	        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
			AddGreaterEnhancementEffectToWeapon(oMyWeapon,fDuration, nCasterLvl);
	    }
		else
	    {
	           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
	    }		
	}	
	
	if (nLevel > 8) // Greater Resistance or Superior Resistance 
	{
		int nSaveBonus = 2;
		if (nLevel > 13)
			nSaveBonus = 4;
			
		RemoveEffectsFromSpell(OBJECT_SELF, SPELL_RESISTANCE);
		RemoveEffectsFromSpell(OBJECT_SELF, SPELL_GREATER_RESISTANCE);	
		RemoveEffectsFromSpell(OBJECT_SELF, SPELL_CONVICTION);		
		if (nLevel > 17) // Superior Resistance
		{
				nSaveBonus += 6;
			    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaveBonus);
				eLink = EffectLinkEffects(eLink, eSave);	
		}
		else // Greater Resistance
		{
				nSaveBonus += 3;		
			    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaveBonus);		
				eLink = EffectLinkEffects(eLink, eSave);					
		}
	}	
	
	if (nLevel > 11) // Lesser Mind Blank
	{
	    effect eImmune1 = EffectImmunity(IMMUNITY_TYPE_CHARM);
	    effect eImmune2 = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
	    effect eImmune3 = EffectImmunity(IMMUNITY_TYPE_FEAR);
	    effect eImmune4 = EffectImmunity(IMMUNITY_TYPE_CONFUSED);	
		eLink = EffectLinkEffects(eLink, eImmune1);
		eLink = EffectLinkEffects(eLink, eImmune2);
		eLink = EffectLinkEffects(eLink, eImmune3);
		eLink = EffectLinkEffects(eLink, eImmune4);			
	}	
	
	if (nLevel > 16) // True Seeing
	{
	    effect eSight = EffectTrueSeeing();
		eLink = EffectLinkEffects(eLink, eSight);		
	}	
	
	if (nLevel > 19) // Shadow Shield without DR
	{
		int nDRMax = nLevel * 10;	
		effect eAC = EffectACIncrease(5, AC_NATURAL_BONUS);
	    effect eImmDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
		effect eImmNeg = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, 9999,  nDRMax);			
    	eLink = EffectLinkEffects(eLink, eAC);	
    	eLink = EffectLinkEffects(eLink, eImmDeath);
		eImmNeg = SetEffectSpellId(eImmNeg,SPELL_SHADOW_SHIELD);		
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmNeg, OBJECT_SELF, fDuration);							
	}	
	
	if (nLevel > 19) // Shadow Shield DR or Greater Stoneskin or Premonition
	{
		int nDRMax = nLevel * 10;	
		if (nDRMax > 150)
			nDRMax = 150;
		if (nLevel > 26) // Premonition
		{
			nDRMax = nDRMax * 4; //Cap at 600, 150 for Shadow Shield, 150 for Greater Stoneskin, and 300 for Premonition
    		effect eStone = EffectDamageReduction( 30, GMATERIAL_METAL_ADAMANTINE, nDRMax, DR_TYPE_GMATERIAL );	// 3.5 DR approximation
			eStone = SetEffectSpellId(eStone,SPELL_PREMONITION);
			eStone = SupernaturalEffect(eStone);				
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStone, OBJECT_SELF, fDuration);		 		
		}
		else
		if (nLevel > 23) // Greater Stoneskin
		{
			nDRMax = nDRMax * 2; //Cap at 300, 150 for Shadow Shield, 150 for Greater Stoneskin
    		effect eStone = EffectDamageReduction( 20, GMATERIAL_METAL_ADAMANTINE, nDRMax, DR_TYPE_GMATERIAL );	// 3.5 DR approximation	
			eStone = SetEffectSpellId(eStone,SPELL_PREMONITION);
			eStone = SupernaturalEffect(eStone);					
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStone, OBJECT_SELF, fDuration);		 						
		}
		else // Shadow Shield DR
		{
    		effect eStone = EffectDamageReduction( 10, GMATERIAL_METAL_ADAMANTINE, nDRMax, DR_TYPE_GMATERIAL );	// 3.5 DR approximation
			eStone = SetEffectSpellId(eStone,SPELL_PREMONITION);
			eStone = SupernaturalEffect(eStone);			
 			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStone, OBJECT_SELF, fDuration);		 				
		}
	}	
	
	if (nLevel > 27) // Chasing Perfection
	{
		effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA,4);
		effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,4);
		effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY,4);	
		effect eWis = EffectAbilityIncrease(ABILITY_WISDOM,4);
		effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
		effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE,4);	
		eLink = EffectLinkEffects(eLink, eCha);
		eLink = EffectLinkEffects(eLink, eCon);	
		eLink = EffectLinkEffects(eLink, eStr);			
		eLink = EffectLinkEffects(eLink, eDex);
		eLink = EffectLinkEffects(eLink, eWis);	
		eLink = EffectLinkEffects(eLink, eInt);		
	}		
									
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
				
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
}