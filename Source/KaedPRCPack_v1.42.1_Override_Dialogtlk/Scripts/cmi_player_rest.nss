//::///////////////////////////////////////////////
//:: cmi_player_rest
//:: Purpose: To handle custom rest functions
//:: Created By: Kaedrin (Matt)
//:: Created On: February 3, 2008
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"

void main()	
{

	object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	ClearTempItemProps(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	ClearTempItemProps(oItem);	
    oItem    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);	
	ClearTempItemProps(oItem);	
	
	if (GetLocalInt(GetModule(), "UseSacredFistFix") == 1)
	{
		//This fixes characters who were incorrectly given the feat.
		if ( (GetLevelByClass(CLASS_TYPE_SACREDFIST) == 0) && (GetHasFeat(FEAT_SACREDFIST_CODE_OF_CONDUCT, OBJECT_SELF)) )
		{
			FeatRemove(OBJECT_SELF, FEAT_SACREDFIST_CODE_OF_CONDUCT);
		}
	}
	
	if ((GetSubRace(OBJECT_SELF) == RACE_DEEP_IMASKARI) && (GetHitDice(OBJECT_SELF) == 1) )
	{	
		int iFirstClass = GetClassByPosition(1, OBJECT_SELF);
		if (iFirstClass == CLASS_TYPE_WIZARD)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_WIZARD_LEVEL1, FALSE, TRUE,TRUE);
		else
		if (iFirstClass == CLASS_TYPE_SORCERER)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_SORCERER_LEVEL1, FALSE, TRUE,TRUE);	
		else
		if (iFirstClass == CLASS_TYPE_BARD)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_BARD_LEVEL1, FALSE, TRUE,TRUE);
		else
		if (iFirstClass == CLASS_TYPE_CLERIC)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_CLERIC_LEVEL1, FALSE, TRUE,TRUE);
		else
		if (iFirstClass == CLASS_TYPE_FAVORED_SOUL)
			FeatAdd(OBJECT_SELF, 2070, FALSE, TRUE,TRUE);
		else
		if (iFirstClass == CLASS_TYPE_DRUID)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_DRUID_LEVEL1, FALSE, TRUE,TRUE);
		else
		if (iFirstClass == CLASS_TYPE_PALADIN)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_PALADIN_LEVEL1, FALSE, TRUE,TRUE);					
		else
		if (iFirstClass == CLASS_TYPE_RANGER)
			FeatAdd(OBJECT_SELF, FEAT_EXTRA_SLOT_RANGER_LEVEL1, FALSE, TRUE,TRUE);
		else
		if (iFirstClass == CLASS_TYPE_SPIRIT_SHAMAN)
			FeatAdd(OBJECT_SELF, 2005, FALSE, TRUE,TRUE);			
																				
	}
	
	object oPoly = GetItemPossessedBy(OBJECT_SELF, "cmi_cursedpoly");
	DestroyObject(oPoly, 0.1f, FALSE);

	if (GetLevelByClass(CLASS_SKULLCLAN_HUNTER, OBJECT_SELF) > 1)
	{
		//SendMessageToPC(GetFirstPC(), "cmi_pc_loaded");
		DelayCommand(1.0f, ExecuteScript("cmi_s2_deathsruin",OBJECT_SELF));		
	}	
	
	if (GetLevelByClass(CLASS_TYPE_PALEMASTER, OBJECT_SELF) > 9)
	{
		effect eCrit = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
		effect eSneak = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);		
		effect ePM = EffectLinkEffects(eCrit, eSneak);
		ePM = SetEffectSpellId(ePM, PM_IMMUNITY);
		ePM = SupernaturalEffect(ePM);
		RemoveSpellEffects(PM_IMMUNITY, OBJECT_SELF, OBJECT_SELF);		
		DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePM, OBJECT_SELF, HoursToSeconds(48)));		
	}
	
	if (GetLevelByClass(CLASS_TYPE_HELLFIRE_WARLOCK	, OBJECT_SELF)>1) //Level 2+
	{
		int nFire = 0;
		if (GetHasFeat(1788, OBJECT_SELF))
		{
			int nWarlock = GetLevelByClass(CLASS_TYPE_WARLOCK, OBJECT_SELF);
			if (nWarlock == 30)
				nFire = 15;
			else
			if (nWarlock == 20)
				nFire = 10;
			else			
				nFire = 5;
		}	
		if (nFire > 0)
		{
			effect eFireRes = EffectDamageResistance(DAMAGE_TYPE_FIRE, nFire + 10);
			DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireRes, OBJECT_SELF, HoursToSeconds(48)));		
		}
	}
	
	//New Parry AC code. Needs a cmi_option wrapper.
	/*		
	{
		RemoveSpellEffects(PARRY_AC_BONUS, OBJECT_SELF, OBJECT_SELF);	
		int nParry = GetSkillRank(SKILL_PARRY);
		nParry = nParry / 5;
		if (nParry > 12)
			nParry = 12;
		effect eParryAC = EffectACIncrease(nParry, AC_DEFLECTION_BONUS);
		eParryAC = SetEffectSpellId(eParryAC, PARRY_AC_BONUS);
		eParryAC = SupernaturalEffect(eParryAC);		
		DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParryAC, OBJECT_SELF, HoursToSeconds(48)));			

	}
	*/
	
	// New Uncanny Dodge code. Needs a cmi_option wrapper.
	if (GetLocalInt(GetModule(), "UncannyDodgeImprovement") == 1)
	{
		int nReflex = 0;
		if (GetHasFeat(FEAT_UNCANNY_DODGE))
		{
			if (GetHasFeat(FEAT_IMPROVED_UNCANNY_DODGE))
				nReflex = 2;
			else 
				nReflex = 1;
		}
		
		if (nReflex > 0)
		{
			RemoveSpellEffects(UNCANNY_DODGE_BONUS, OBJECT_SELF, OBJECT_SELF);	
			effect eUncanny = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nReflex);
			eUncanny = SetEffectSpellId(eUncanny, UNCANNY_DODGE_BONUS);
			eUncanny = SupernaturalEffect(eUncanny);		
			DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUncanny, OBJECT_SELF, HoursToSeconds(48)));			
		}
	}
	
	if (GetHasFeat(FEAT_BACKGROUND_NATURAL_LEADER, OBJECT_SELF))
	{
			if (!GetHasSpellEffect(NATURAL_LEADER_AURA, OBJECT_SELF))
			{
				effect eAOE = EffectAreaOfEffect(VFX_MOB_NATURAL_LEADER);
				eAOE = ExtraordinaryEffect(eAOE);	 //Make effect extraordinary
				eAOE = SetEffectSpellId(eAOE, NATURAL_LEADER_AURA);
			    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF));
			}
	}
	
	if (GetHasFeat(FEAT_EXPERT_TACTICIAN, OBJECT_SELF))
	{
			if (!GetHasSpellEffect(EXPERT_TACTICIAN_FIX, OBJECT_SELF))
			{
				effect eAB = EffectAttackIncrease(1);
				eAB = SupernaturalEffect(eAB);
				eAB = SetEffectSpellId(eAB, EXPERT_TACTICIAN_FIX);
			    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, HoursToSeconds(48)));
			}
	}	
	
		
}