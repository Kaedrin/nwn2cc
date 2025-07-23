//::///////////////////////////////////////////////
//:: cmi_player_rest
//:: Purpose: To handle custom rest functions
//:: Created By: Kaedrin (Matt)
//:: Created On: February 3, 2008
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"
#include "hcr2_core_i"

void main()	
{
	if(!GetLocalInt(OBJECT_SELF, H2_SKIP_CANCEL_REST)) {

	object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	ClearTempItemProps(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	ClearTempItemProps(oItem);	
    oItem    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);	
	ClearTempItemProps(oItem);	
	
	   oItem = GetFirstItemInInventory(OBJECT_SELF);
	   while (GetIsObjectValid(oItem) == TRUE)
	   {
	      ClearTempItemProps(oItem);	
	      oItem = GetNextItemInInventory(OBJECT_SELF);
	   }
	}
	
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
	
	if (GetHasFeat(FEAT_BLIND_FIGHT, OBJECT_SELF))
	{
			if(   (GetSubRace(OBJECT_SELF) != RACIAL_SUBTYPE_YUANTI) && (!GetHasSpellEffect(BLIND_FIGHT_FIX, OBJECT_SELF)) )
			{
				effect eBlindFight = EffectImmunity(IMMUNITY_TYPE_BLINDNESS);
				eBlindFight = SupernaturalEffect(eBlindFight);
				eBlindFight = SetEffectSpellId(eBlindFight, BLIND_FIGHT_FIX);
			    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlindFight, OBJECT_SELF, HoursToSeconds(48)));
			}
	}	
	
	if (GetLevelByClass(CLASS_FACTOTUM, OBJECT_SELF) > 0)
	{
		if (GetHasFeat(FEAT_FACTOTUM_CUN_DEF, OBJECT_SELF))
		{	
			DelayCommand(0.2f, EvaluateCunningDefense(OBJECT_SELF));
		}
		if (GetLevelByClass(CLASS_FACTOTUM, OBJECT_SELF) > 3)
		{
			if (!GetHasFeat(1957, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, 1957, FALSE, TRUE, TRUE);		
		}			
	}
	
	if (GetHasFeat(FEAT_FIGHTER_ARMOR_TRAIN, OBJECT_SELF))
	{
		DelayCommand(0.2f, EvaluateFighterArmorTrain(OBJECT_SELF));
	}			
	
	int nFighter = GetLevelByClass(CLASS_TYPE_FIGHTER, OBJECT_SELF);
	if (nFighter > 4)
	{
		if (!GetHasFeat(FEAT_FIGHTER_PASSIVE, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_FIGHTER_PASSIVE, FALSE, TRUE, TRUE);
		if (!GetHasFeat(FEAT_FIGHTER_ARMOR_TRAIN, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_FIGHTER_ARMOR_TRAIN, FALSE, TRUE, TRUE);				
	}
	else
	if (nFighter > 2)
	{
		if (!GetHasFeat(FEAT_FIGHTER_ARMOR_TRAIN, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_FIGHTER_ARMOR_TRAIN, FALSE, TRUE, TRUE);
	}
	
	if (GetLevelByClass(CLASS_GHOST_FACED_KILLER, OBJECT_SELF) > 6)
	{
		if (!GetHasFeat(FEAT_NINJA_GHOST_SIGHT, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_NINJA_GHOST_SIGHT, FALSE, TRUE, TRUE);		
	}	
	
	if (GetLevelByClass(CLASS_TYPE_RANGER, OBJECT_SELF) > 0)
	{
		if (!GetHasFeat(FEAT_DEMORALIZE_OPPONENT, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_DEMORALIZE_OPPONENT, FALSE, TRUE, TRUE);		
	}
	
	if (GetLevelByClass(CLASS_TYPE_PALADIN, OBJECT_SELF) > 3)
	{
		if (!GetHasFeat(FEAT_CHANNEL_POSITIVE_ENERGY, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_CHANNEL_POSITIVE_ENERGY, FALSE, TRUE, TRUE);		
	}	
	
	if (GetLevelByClass(CLASS_FORCE_MAGE, OBJECT_SELF) > 3)
	{
		if (!GetHasFeat(FEAT_EMPOWER_SPELL, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_EMPOWER_SPELL, FALSE, TRUE, TRUE);		
	}
	
	int nMonk = GetLevelByClass(CLASS_TYPE_MONK, OBJECT_SELF);
	int nMonkFixesDone = GetLocalInt(OBJECT_SELF, "MonkFixed");
	if (nMonkFixesDone)
		nMonk = 0;
	if (nMonk > 0)
	{
		SetLocalInt(OBJECT_SELF, "MonkFixed", TRUE);
		if (nMonk > 29)
		{
			if (!GetHasFeat(WholenessofBody10, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody10, FALSE, TRUE, TRUE);			
		}
		if (nMonk > 26)
		{
			if (!GetHasFeat(WholenessofBody9, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody9, FALSE, TRUE, TRUE);		
		}
		if (nMonk > 25)
		{
			if (!GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_UNARMED, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_EPIC_WEAPON_SPECIALIZATION_UNARMED, FALSE, TRUE, TRUE);	
			if (!GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_QUARTERSTAFF, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_EPIC_WEAPON_SPECIALIZATION_QUARTERSTAFF, FALSE, TRUE, TRUE);							
		}
		if (nMonk > 23)
		{
			if (!GetHasFeat(WholenessofBody8, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody8, FALSE, TRUE, TRUE);		
		}
		if (nMonk > 21)
		{
			if (!GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_UNARMED, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_EPIC_WEAPON_FOCUS_UNARMED, FALSE, TRUE, TRUE);	
			if (!GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_QUARTERSTAFF, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_EPIC_WEAPON_FOCUS_QUARTERSTAFF, FALSE, TRUE, TRUE);							
		
		}
		if (nMonk > 20)
		{
			if (!GetHasFeat(WholenessofBody7, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody7, FALSE, TRUE, TRUE);			
		}
		if (nMonk > 17)
		{
			if (!GetHasFeat(WholenessofBody6, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody6, FALSE, TRUE, TRUE);	
			if (!GetHasFeat(FEAT_GREATER_WEAPON_SPECIALIZATION_UNARMED, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_GREATER_WEAPON_SPECIALIZATION_UNARMED, FALSE, TRUE, TRUE);	
			if (!GetHasFeat(FEAT_GREATER_WEAPON_SPECIALIZATION_QUARTERSTAFF, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_GREATER_WEAPON_SPECIALIZATION_QUARTERSTAFF, FALSE, TRUE, TRUE);						
		}
		if (nMonk > 14)
		{
			if (!GetHasFeat(WholenessofBody5, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody5, FALSE, TRUE, TRUE);			
		}
		if (nMonk > 13)
		{
			if (!GetHasFeat(FEAT_GREATER_WEAPON_FOCUS_UNARMED, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_GREATER_WEAPON_FOCUS_UNARMED, FALSE, TRUE, TRUE);	
			if (!GetHasFeat(FEAT_GREATER_WEAPON_FOCUS_QUARTERSTAFF, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_GREATER_WEAPON_FOCUS_QUARTERSTAFF, FALSE, TRUE, TRUE);								
		}
		if (nMonk > 11)
		{
			if (!GetHasFeat(WholenessofBody4, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody4, FALSE, TRUE, TRUE);			
		}
		if (nMonk > 9)
		{
			if (!GetHasFeat(FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE, FALSE, TRUE, TRUE);	
			if (!GetHasFeat(FEAT_WEAPON_SPECIALIZATION_STAFF, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_WEAPON_SPECIALIZATION_STAFF, FALSE, TRUE, TRUE);		
		}		
		if (nMonk > 8)
		{		
			if (!GetHasFeat(WholenessofBody3, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody3, FALSE, TRUE, TRUE);			
		}			
		if (nMonk > 6)
		{
			if (!GetHasFeat(WholenessofBody2, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, WholenessofBody2, FALSE, TRUE, TRUE);						
		}		
		if (nMonk > 3)
		{
			if (!GetHasFeat(FEAT_UNARMED_COMBAT_MASTERY, OBJECT_SELF))		
				FeatAdd(OBJECT_SELF, FEAT_UNARMED_COMBAT_MASTERY, FALSE, TRUE, TRUE);							
		}
		if (!GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, FEAT_WEAPON_FOCUS_UNARMED_STRIKE, FALSE, TRUE, TRUE);	
		if (!GetHasFeat(96, OBJECT_SELF))		
			FeatAdd(OBJECT_SELF, 96, FALSE, TRUE, TRUE);																													
	}
	
	int nHex = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF);
	if (nHex > 0)
	{
		int nHexFixesDone = GetLocalInt(OBJECT_SELF, "HexFixed");
		if (!nHexFixesDone)
		{
			SetLocalInt(OBJECT_SELF, "HexFixed", TRUE);		
			int nHexbladeSpells = nHex;
			
			int nVengTaker = GetLevelByClass(CLASS_VENGTAKE, OBJECT_SELF);
			nHex += nVengTaker;
			nHexbladeSpells += nVengTaker;
			
			int nBlackGuard = GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF);	
			if (GetHasFeat(FEAT_BG_ARCANE_SERVANT_DARKNESS,OBJECT_SELF))
			{
				nHex += nBlackGuard;
				if (GetHasFeat(FEAT_HEXBLADE_PRACTICED_CASTER,OBJECT_SELF))
					nHexbladeSpells += nBlackGuard;
			}
			else
				nBlackGuard = 0;
				
			if ( (nBlackGuard > 0) || (nVengTaker > 0) )
			{
				StackHexbladeCurse();
			}
			else
			{
				if (GetHasFeat(FEAT_HEXBLADE_EXTRA_CURSE_I, OBJECT_SELF))
					StackHexbladeCurse();			
			}	
			
			if (nHexbladeSpells > 3)
				StackHexbladeSpells(nHexbladeSpells);									
		}
	}
	
	
			
	
//const int FIGHTER_ARMOR_BONUS = -4013;
//const int FIGHTER_PASSIVE_BONUS = -4014;		
		
}