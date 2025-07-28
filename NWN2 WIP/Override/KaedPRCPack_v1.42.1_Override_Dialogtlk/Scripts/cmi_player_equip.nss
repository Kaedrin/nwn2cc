//::///////////////////////////////////////////////
//:: cmi_player_equip
//:: Purpose: To handle classes with special needs when equipping weapons
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2007
//:://////////////////////////////////////////////

#include "cmi_tempest"
#include "cmi_ginc_chars"


void main()	
{
	float fDelay;
	object oPC = OBJECT_SELF;
	object oItem = GetPCItemLastEquipped();
	
	/*
	effect eSpellFailure = EffectSpellFailure(100);
	eSpellFailure = SupernaturalEffect(eSpellFailure);
	DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpellFailure, oPC, 6.0f));
	*/
	ClearAllActions(FALSE); //Replacement for spell failure.
	
	int nDisableConFix = GetLocalInt(oPC, "DisableConFix");
	
	int nUseConFix = GetLocalInt(GetModule(), "UseConFix");
	if (nUseConFix == 0)
		nDisableConFix = TRUE;

	if (!nDisableConFix)
	{
		//SendMessageToPC(OBJECT_SELF, "Equip");
		int nCurrentHitPoints;
		int nMaxHitPoints;	
		effect eHeal = EffectHeal(1);
		effect eDamage;
		int nConValue;
		int nHD = GetHitDice(oPC);
		int nTableValue;
		int nBase1 = (GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) + 1) / 2;
		int nBase2 = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) / 2;
		int nConBonusCount; //= GetLocalInt(OBJECT_SELF, "ConBonusCount");
		itemproperty iProp = GetFirstItemProperty(oItem);
		while (GetIsItemPropertyValid(iProp))
		{
			if (GetItemPropertyType(iProp) == ITEM_PROPERTY_ABILITY_BONUS)
			{	
				if (GetItemPropertySubType(iProp) == ABILITY_CONSTITUTION)
				{
					nCurrentHitPoints = GetCurrentHitPoints(oPC);
					nMaxHitPoints = GetMaxHitPoints(oPC);
					nConBonusCount = GetLocalInt(OBJECT_SELF, "ConBonusCount");
					nConBonusCount++;
					if (nCurrentHitPoints > nMaxHitPoints)
					{	
						DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC));	
					}
					else
					{
						//SendMessageToPC(oPC, "Version 3 ");
						//SendMessageToPC(oPC, "nBase1: " + IntToString(nBase1));
						//SendMessageToPC(oPC, "nBase2: " + IntToString(nBase2));
						if ((nBase1 - nBase2) > 0)
						{
							if (nConBonusCount > 1)
							{
								//SendMessageToPC(oPC, "nConBonusCount: " + IntToString(nConBonusCount));
								nConValue = ((GetItemPropertyCostTableValue(iProp) + 1)/2) * nHD;
								
								// Make sure we don't kill the PC
								if (nCurrentHitPoints <= nConValue)
       								 nConValue = nCurrentHitPoints - 1;
									 
								if (nConValue > 0)
								{		
									eDamage = EffectDamage(nConValue, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
									DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
									DelayCommand(0.2f, ClearAllActions(TRUE));
								}
																
							}
						}
						else
						{
							nTableValue = GetItemPropertyCostTableValue(iProp);
							int nCon = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE);
							int nBase = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, TRUE);
							int	nBonus = StringToInt(Get2DAString("racialsubtypes.2da", "ConAdjust", GetSubRace(OBJECT_SELF)));
							//SendMessageToPC(oPC, "nCon: " + IntToString(nCon));
							//SendMessageToPC(oPC, "nBase: " + IntToString(nBase));
							//SendMessageToPC(oPC, "nBonus: " + IntToString(nBonus));
							int nAdjusted = nCon - (nBase + nBonus);
							if ((nAdjusted >= nTableValue) || (nConBonusCount == 1))
							{
								//SendMessageToPC(oPC, "nBase1: " + IntToString(nBase1));
								//SendMessageToPC(oPC, "nBase2: " + IntToString(nBase2));
								//SendMessageToPC(oPC, "nConBonusCount: " + IntToString(nConBonusCount));
								nConValue = (GetItemPropertyCostTableValue(iProp)/2) * nHD;
								
								// Make sure we don't kill the PC
								if (nCurrentHitPoints <= nConValue)
       								 nConValue = nCurrentHitPoints - 1;
									 
								if (nConValue > 0)
								{		
									eDamage = EffectDamage(nConValue, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
									DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
									DelayCommand(0.2f, ClearAllActions(TRUE));
								}
							}
							/*
							if (nTableValue > 0)
							{
								SendMessageToPC(oPC, "No Heal?: ");
								SendMessageToPC(oPC, "nConBonusCount: " + IntToString(nConBonusCount));
							}
							else
							{
								SendMessageToPC(oPC, "nBase1: " + IntToString(nBase1));
								SendMessageToPC(oPC, "nBase2: " + IntToString(nBase2));
								SendMessageToPC(oPC, "nConBonusCount: " + IntToString(nConBonusCount));
								nConValue = (GetItemPropertyCostTableValue(iProp)/2) * nHD;
								eDamage = EffectDamage(nConValue, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
								DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
							}
							*/
						}
						//nConValue = (GetItemPropertyCostTableValue(iProp)/2) * nHD;
						//eDamage = EffectDamage(nConValue, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
						//DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
						//SendMessageToPC(oPC, "Value: " + IntToString(GetItemPropertyCostTableValue(iProp)));
					}
					SetLocalInt(OBJECT_SELF, "ConBonusCount", nConBonusCount); 												
				}																
			}
			iProp = GetNextItemProperty(oItem);	
		}	
	}
	
	
	if(GetHasFeat(FEAT_CROSSBOW_SNIPER, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_xbowsniper",oPC));
	}	
	
	if(GetHasFeat(FEAT_BARDSONG_SNOWFLAKE_WARDANCE, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, IsSnowflakeStillValid(oPC));
	}	
	
	if (GetLevelByClass(CLASS_NINJA) > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_ninjaac",oPC));
	}	
	
	if (GetLevelByClass(CLASS_DERVISH) > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_dervacbonus",oPC));
	}		
	
	if (GetLevelByClass(CLASS_FIST_FOREST) > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_fotfacbonus",oPC));
		fDelay = 0.2f + (Random(20) * 0.1f);			
		DelayCommand(fDelay, ExecuteScript("cmi_s2_fotfunarmed",oPC));
	}
		
	if (GetHasFeat(FEAT_HEAVY_ARMOR_OPTIMIZATION, oPC))
	{
		if (GetHasFeat(FEAT_GREATER_HEAVY_ARMOR_OPTIMIZATION, oPC))
		{
			fDelay = 0.2f + (Random(20) * 0.1f);
			DelayCommand(fDelay, ExecuteScript("cmi_s2_gharmropt",oPC));
		}
		else
		{
			fDelay = 0.2f + (Random(20) * 0.1f);	
			DelayCommand(fDelay, ExecuteScript("cmi_s2_harmropt",oPC));
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
	
//	object oLast = GetPCItemLastEquipped();
//	if (IPGetIsMeleeWeapon(oLast))
//	{	
		if(GetHasFeat(FEAT_MELEE_WEAPON_MASTERY_B, oPC))
		{
			fDelay = 0.2f + (Random(20) * 0.1f);	
			DelayCommand(fDelay, ExecuteScript("cmi_s2_mwpnmast_b",oPC));
		}	
		if(GetHasFeat(FEAT_MELEE_WEAPON_MASTERY_P, oPC))
		{
			fDelay = 0.2f + (Random(20) * 0.1f);	
			DelayCommand(fDelay, ExecuteScript("cmi_s2_mwpnmast_p",oPC));
		}	
		if(GetHasFeat(FEAT_MELEE_WEAPON_MASTERY_S, oPC))
		{
			fDelay = 0.2f + (Random(20) * 0.1f);	
			DelayCommand(fDelay, ExecuteScript("cmi_s2_mwpnmast_s",oPC));
		}
//	}				
		
	
	if (GetLocalInt(GetModule(), "UseSRFix"))
		DelayCommand(0.3f, ApplySRFix(oPC));
	if (GetLocalInt(GetModule(), "UseDmgResFix"))
		DelayCommand(0.3f, ApplyDmgResFix(oPC, TRUE));
		
	if(GetHasFeat(FEAT_INTUITIVE_ATTACK, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_intuitatk",oPC));
	}	
	
	if (GetLevelByClass(CLASS_DREAD_COMMANDO) > 1)
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_armoredease",oPC));	
	}
			
	
	if(GetHasFeat(FEAT_FIERY_FIST, oPC) && (GetHasSpellEffect(SPELLABILITY_FIERY_FIST)))
	{
	    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	    object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		
		if (GetIsObjectValid(oWeapon) || GetIsObjectValid(oWeapon2))
		{	
			RemoveEffectsFromSpell(oPC, SPELLABILITY_FIERY_FIST);
			SendMessageToPC(oPC, "Fiery Fist can not be used while you have weapons equipped.");			
		}		
	}
	
	if(GetHasFeat(FEAT_SACREDFIST_CODE_OF_CONDUCT, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_sfcoc",oPC));
	}	

	if (GetLevelByClass(CLASS_SKULLCLAN_HUNTER, oPC) > 1)
	{
		fDelay = 0.2f + (Random(20) * 0.1f);		
		DelayCommand(1.0f, ExecuteScript("cmi_s2_deathsruin",oPC));		
	}	
		
	if (GetLevelByClass(CLASS_CHAMPION_WILD, oPC) > 1)
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_elegstrike",oPC));		
	}
	
	if(GetHasFeat(FEAT_GTR_2WPN_DEFENSE, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_gtr2wpndef",oPC));
	}	
	
	if (GetHasFeat(FEAT_ARMOR_SPECIALIZATION_MEDIUM, oPC) || GetHasFeat(FEAT_ARMOR_SPECIALIZATION_HEAVY, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, EvaluateArmorSpec(oPC));
	}
	
	if (GetHasFeat(FEAT_OVERSIZE_TWO_WEAPON_FIGHTING, oPC))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, EvaluateOver2WpnFight());
	}	

	//Bladesinger
	int Bladesinger = GetLevelByClass(CLASS_BLADESINGER,oPC);
	if (Bladesinger > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);
		DelayCommand(fDelay, ExecuteScript("cmi_s2_bladesong",oPC));
		
		if ( Bladesinger > 7)
			DelayCommand(fDelay,ExecuteScript("cmi_s2_battlecaster",oPC));
		else
		if ( Bladesinger > 5 )
			DelayCommand(fDelay,ExecuteScript("cmi_s2_armorcaster",oPC));	
										
		//if ( Bladesinger == 10 )
		//	DelayCommand(fDelay,ExecuteScript("cmi_s2_sngfury",oPC));				
	}	
	
	// Tempest
	if (GetLevelByClass(CLASS_TEMPEST,oPC) > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);
		DelayCommand(fDelay, ExecuteScript("cmi_s2_tempdefense",oPC));
	}	

	// Nightsong Enforcer
	if (GetLevelByClass(CLASS_NIGHTSONG_ENFORCER,oPC) > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_agiltrain",oPC));
	}	
	
	if (GetHasFeat(FEAT_RANGED_WEAPON_MASTERY, oPC, TRUE))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, EvaluateRWM(oPC));
	}
		
	if (GetHasFeat(FEAT_UNARMED_COMBAT_MASTERY, oPC, TRUE))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, EvaluateUCM(oPC));		
	}
		
	if (GetHasFeat(FEAT_CROSSBOW_SNIPER, oPC, TRUE))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_xbowsniper",oPC));
	}
	
	if (GetLevelByClass(CLASS_ELEM_ARCHER,oPC) > 0)
	{	
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay, ExecuteScript("cmi_s2_elemshot",oPC));
	}	
	
	if (GetHasFeat(FEAT_FOREST_MASTER_FOREST_HAMMER, oPC, TRUE))
	{
		fDelay = 0.2f + (Random(20) * 0.1f);	
		DelayCommand(fDelay,ExecuteScript("cmi_s2_forsthammr",oPC));
	}
}