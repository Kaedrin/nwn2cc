//::///////////////////////////////////////////////
//:: cmi_player_equip
//:: Purpose: To handle classes with special needs when equipping weapons
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"

#include "cmi_tempest"
#include "cmi_ginc_chars"

void HealIfNeeded(object oPC, int nActualTableValue)
{
	int nConBonus = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, TRUE);
	int	nBonus = StringToInt(Get2DAString("racialsubtypes.2da", "ConAdjust", GetSubRace(OBJECT_SELF)));
	nConBonus = nConBonus - nBonus;
	
	int nBase1 = (GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) + 1) / 2;
	int nBase2 = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) / 2;
	//SendMessageToPC(OBJECT_SELF, "nBase1: " + IntToString(nBase1));
	//SendMessageToPC(OBJECT_SELF, "nBase2: " + IntToString(nBase2));
	//SendMessageToPC(OBJECT_SELF, "nActualTableValue: " + IntToString(nActualTableValue));
	//SendMessageToPC(OBJECT_SELF, "nConBonus: " + IntToString(nConBonus));	
	
	int nTableValue;
	if (nConBonus > 0)
	{
		if ((nBase1 - nBase2) > 0)
		nTableValue = (nActualTableValue) / 2;	
		else	
		nTableValue = (nActualTableValue + 1) / 2;
	}
	else
		nTableValue = nActualTableValue / 2;
		
	//if (nConBonus >= nActualTableValue)
	//	nTableValue = 0;	
									
	if (nTableValue > 0)
	{	
		int nHeal = nTableValue * GetHitDice(oPC);
		effect eHeal = EffectHeal(nHeal);
		//SendMessageToPC(oPC, "nHeal: " + IntToString(nHeal));
		DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC));;		
	}		
}

void main()	
{
	object oPC = OBJECT_SELF;
	object oItem = GetPCItemLastUnequipped();
	
	//Fix for sticking item props
	if (GetLocalInt(GetModule(), "UnequipLosesTempProperties") == 1)
		ClearTempItemProps(oItem);
		
	int nUseConFix = GetLocalInt(GetModule(), "UseConFix");
	if (nUseConFix == 1)
	{
		//Fix for equipping/unequipping con items
		//int nDisableConFix = GetLocalInt(oPC, "DisableConFix");
		//if (!nDisableConFix)
		{	
			//SendMessageToPC(OBJECT_SELF, "Unequip");	
			int nTableValue = 0;
			int nActualTableValue;
			itemproperty iProp = GetFirstItemProperty(oItem);
			while (GetIsItemPropertyValid(iProp))
			{
				if (GetItemPropertyType(iProp) == ITEM_PROPERTY_ABILITY_BONUS)
				{	
					if (GetItemPropertySubType(iProp) == ABILITY_CONSTITUTION)
					{			
						nActualTableValue = GetItemPropertyCostTableValue(iProp);
						if (nActualTableValue > nTableValue) //Handles multiple con bonuses on one item
							nTableValue	= nActualTableValue;
						SetLocalInt(OBJECT_SELF, "ConBonusCount", (	GetLocalInt(OBJECT_SELF, "ConBonusCount") - 1)); 			
					}																
				}
				iProp = GetNextItemProperty(oItem);	
			}
			if (nTableValue > 0)		
				DelayCommand(0.3f, HealIfNeeded(oPC, nTableValue));
		}	
		//End - Fix for equipping/unequipping con items
	}
		
	if(GetHasFeat(FEAT_CROSSBOW_SNIPER, oPC))
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_xbowsniper",oPC));
	}	
	
	if(GetHasFeat(FEAT_BARDSONG_SNOWFLAKE_WARDANCE, oPC))
	{	
		DelayCommand(0.1f, IsSnowflakeStillValid(oPC));
	}
	
	if (GetLevelByClass(CLASS_NINJA) > 0)
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_ninjaac",oPC));	
	}	
	
	if (GetLevelByClass(CLASS_DERVISH) > 0)
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_dervacbonus",oPC));	
	}		
	
	if (GetLevelByClass(CLASS_FIST_FOREST) > 0)
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_fotfacbonus",oPC));	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_fotfunarmed",oPC));
	}	
	
	if (GetHasFeat(FEAT_HEAVY_ARMOR_OPTIMIZATION, oPC))
	{
		if (GetHasFeat(FEAT_GREATER_HEAVY_ARMOR_OPTIMIZATION, oPC))
		{
			DelayCommand(0.1f, ExecuteScript("cmi_s2_gharmropt",oPC));
		}
		else
		{
			DelayCommand(0.1f, ExecuteScript("cmi_s2_harmropt",oPC));
		}
	}
	
	if (GetHasSpellEffect(SPELL_Blessed_Aim, oPC))
	{
		  object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		  if (!GetIsObjectValid(oWeapon) || !GetWeaponRanged(oWeapon))
		  {	
			    RemoveEffectsFromSpell(oPC, SPELL_Blessed_Aim);			
		  } 		
	}
		
//	object oLast = GetPCItemLastUnequipped();
//	if (IPGetIsMeleeWeapon(oLast))
//	{
		if(GetHasFeat(FEAT_MELEE_WEAPON_MASTERY_B, oPC))
		{
			DelayCommand(0.1f, ExecuteScript("cmi_s2_mwpnmast_b",oPC));		
		}	
		if(GetHasFeat(FEAT_MELEE_WEAPON_MASTERY_P, oPC))
		{
			DelayCommand(0.1f, ExecuteScript("cmi_s2_mwpnmast_p",oPC));
		}	
		if(GetHasFeat(FEAT_MELEE_WEAPON_MASTERY_S, oPC))
		{
			DelayCommand(0.1f, ExecuteScript("cmi_s2_mwpnmast_s",oPC));
		}		
//	}
	
	if (GetLocalInt(GetModule(), "UseSRFix"))
		DelayCommand(0.3f, ApplySRFix(oPC));
	if (GetLocalInt(GetModule(), "UseDmgResFix"))
		DelayCommand(0.3f, ApplyDmgResFix(oPC, TRUE));
		
	if(GetHasFeat(FEAT_INTUITIVE_ATTACK, oPC))
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_intuitatk",oPC));
	}
	
	if (GetLevelByClass(CLASS_DREAD_COMMANDO) > 1)
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_armoredease",oPC));	
	}	
			
	if(GetHasFeat(FEAT_SACREDFIST_CODE_OF_CONDUCT, oPC))
	{
		DelayCommand(0.1f, ExecuteScript("cmi_s2_sfcoc",oPC));
	}	
		
	if (GetLevelByClass(CLASS_CHAMPION_WILD, oPC) > 1)
		DelayCommand(0.1f, ExecuteScript("cmi_s2_elegstrike",oPC));		
		
	if (GetHasFeat(FEAT_ARMOR_SPECIALIZATION_MEDIUM, oPC) || GetHasFeat(FEAT_ARMOR_SPECIALIZATION_HEAVY, oPC))
	{
		DelayCommand(0.1f, EvaluateArmorSpec(oPC));
	}
	
	if(GetHasFeat(FEAT_GTR_2WPN_DEFENSE, oPC))
	{
		DelayCommand(0.1f, ExecuteScript("cmi_s2_gtr2wpndef",oPC));
	}
	
	if (GetHasFeat(FEAT_OVERSIZE_TWO_WEAPON_FIGHTING, oPC))
	{
		DelayCommand(0.1f, EvaluateOver2WpnFight());
	}
		
	//Bladesinger
	int Bladesinger = GetLevelByClass(CLASS_BLADESINGER,oPC);
	if (Bladesinger > 0)
	{	
			DelayCommand(0.1f, ExecuteScript("cmi_s2_bladesong",oPC));
		

			
		if ( GetHasFeat(FEAT_BATTLE_CASTER_BLADESINGER) )
			DelayCommand(0.1f,ExecuteScript("cmi_s2_battlecaster",oPC));
		else						
		if ( GetHasFeat(FEAT_ARMORED_CASTER_BLADESINGER) )
			DelayCommand(0.1f,ExecuteScript("cmi_s2_armorcaster",oPC));	
					
		//if ( GetHasFeat(FEAT_BLADESINGER_SONG_FURY) )
		//	DelayCommand(0.1f,ExecuteScript("cmi_s2_sngfury",oPC));				
	}			
	
	// Tempest
	if (GetLevelByClass(CLASS_TEMPEST,oPC) > 0)
	{
		DelayCommand(0.1f,ExecuteScript("cmi_s2_tempdefense",oPC));
	}		


	// Nightsong Enforcer
	if (GetLevelByClass(CLASS_NIGHTSONG_ENFORCER,oPC) > 0)
	{	
		DelayCommand(0.1f,ExecuteScript("cmi_s2_agiltrain",oPC));		
	}

	
	if (GetHasFeat(FEAT_RANGED_WEAPON_MASTERY, oPC, TRUE))
		DelayCommand(0.1f, EvaluateRWM(oPC));
		
	if (GetHasFeat(FEAT_UNARMED_COMBAT_MASTERY, oPC, TRUE))
		DelayCommand(0.1f, EvaluateUCM(oPC));	
		
	if (GetLevelByClass(CLASS_ELEM_ARCHER,oPC) > 0)
	{	
		DelayCommand(0.1f, ExecuteScript("cmi_s2_elemshot",oPC));
	}		
	
	if (GetHasFeat(FEAT_FOREST_MASTER_FOREST_HAMMER, oPC, TRUE))
		DelayCommand(0.1f, RemoveEffectsFromSpell(OBJECT_SELF, FOREST_MASTER_FOREST_HAMMER));	
		
	
}