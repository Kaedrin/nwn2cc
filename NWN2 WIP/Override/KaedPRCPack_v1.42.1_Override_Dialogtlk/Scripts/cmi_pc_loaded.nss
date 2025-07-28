//::///////////////////////////////////////////////
//:: cmi_pc_loaded
//:: Purpose: To Fix characters as they are loaded by a module
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2007
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"

void CheckItemForConBonus(object oItem)
{
	int nConBonusCount;
	itemproperty iProp = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(iProp))
	{
		if (GetItemPropertyType(iProp) == ITEM_PROPERTY_ABILITY_BONUS)
		{	
			if (GetItemPropertySubType(iProp) == ABILITY_CONSTITUTION)
			{
				nConBonusCount = GetLocalInt(OBJECT_SELF, "ConBonusCount");
				nConBonusCount++;
				SetLocalInt(OBJECT_SELF, "ConBonusCount", nConBonusCount); 
			}
		}
		iProp = GetNextItemProperty(oItem);
	}
}

void main()	
{
	
//Reserved for future patching of PrC classes. 
/*
	object oPC = OBJECT_SELF;
		
	int bResetNeeded = FALSE;	
	if (bResetNeeded)
	{
		SendMessageToPC(oPC,"Level will be reset due to changes allowing community content for PrCs to be merged.  I apologize for the inconvenience.  This should be rare in the future.");	
		int iExp = GetXP(oPC);
		SetXP(oPC,1);
		SetXP(oPC,iExp);									
	}
*/

	//This supports Module Start for modules without full cmi_ support.
	if (GetLocalInt(OBJECT_SELF, "RunModuleSupported"))
	{
		IsModuleSupported(TRUE);
		//SetLocalInt(OBJECT_SELF, "RunModuleSupported", 0);
		DeleteLocalInt(OBJECT_SELF, "RunModuleSupported");
	}

	if (!(GetLocalInt(GetModule(),"CMI_Supported")))
	{
		ExecuteScript("cmi_pw_mod_start",GetModule());		
	}
	
	IsModuleSupported(FALSE);
	
	if ( GetLevelByClass(CLASS_SCOUT) > 2 || GetLevelByClass(CLASS_WILD_STALKER) > 3)
	{
		if (!GetHasFeat(FEAT_SCOUT_SKIRMISHAC))
			FeatAdd(OBJECT_SELF,FEAT_SCOUT_SKIRMISHAC,FALSE,TRUE,TRUE);
	}	
	
	if (GetLevelByClass(CLASS_SKULLCLAN_HUNTER, OBJECT_SELF) > 1)
	{
		DelayCommand(1.0f, ExecuteScript("cmi_s2_deathsruin",OBJECT_SELF));		
	}	
	
	if (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE) > 0)
	{
		if (!GetHasFeat(FEAT_DRAGON_DIS_GENERAL, OBJECT_SELF))
		{
			FeatAdd(OBJECT_SELF, FEAT_DRAGON_DIS_GENERAL, FALSE);
			FeatAdd(OBJECT_SELF, FEAT_DRAGON_DIS_RED, FALSE);
			SetLocalInt(OBJECT_SELF, "DragonDisciple", 1);	
		}
	}
	
	if (GetLevelByClass(CLASS_LYRIC_THAUMATURGE) > 9)
	{
		if (!GetHasFeat(1246, OBJECT_SELF, TRUE)) //FEAT_PRACTICED_SPELLCASTER_BARD
		{
			FeatAdd(OBJECT_SELF,1246,FALSE);
		}
	}
	
	int nBladesinger = GetLevelByClass(CLASS_BLADESINGER,OBJECT_SELF);

	object oHideArmor = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
 	if (GetIsObjectValid(oHideArmor))
	{
		DelayCommand(0.1f, ActionUnequipItem(oHideArmor));
		DelayCommand(0.3f, ActionEquipItem(oHideArmor, INVENTORY_SLOT_CARMOUR ));
	}
	object oCWeap1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,OBJECT_SELF);
 	if (GetIsObjectValid(oCWeap1))
	{
		DelayCommand(0.1f, ActionUnequipItem(oCWeap1));
		DelayCommand(0.3f, ActionEquipItem(oCWeap1, INVENTORY_SLOT_CWEAPON_B ));
	}
	object oCWeap2 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,OBJECT_SELF);
 	if (GetIsObjectValid(oCWeap2))
	{
		DelayCommand(0.1f, ActionUnequipItem(oCWeap2));
		DelayCommand(0.3f, ActionEquipItem(oCWeap2, INVENTORY_SLOT_CWEAPON_L ));
	}
	object oCWeap3 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,OBJECT_SELF);
 	if (GetIsObjectValid(oCWeap3))
	{
		DelayCommand(0.1f, ActionUnequipItem(oCWeap3));
		DelayCommand(0.3f, ActionEquipItem(oCWeap3, INVENTORY_SLOT_CWEAPON_R ));
	}			

	if (GetLevelByClass(CLASS_TYPE_PALADIN) > 0)
	{
		if (!GetHasFeat(FEAT_LAYONHANDS_HOSTILE, OBJECT_SELF, TRUE))
		{
			FeatAdd(OBJECT_SELF,FEAT_LAYONHANDS_HOSTILE,FALSE);
		}
	}
	
	if (GetLevelByClass(CLASS_TYPE_DIVINECHAMPION) > 0)
	{
		if (!GetHasFeat(FEAT_LAYONHANDS_HOSTILE, OBJECT_SELF, TRUE))
		{
			FeatAdd(OBJECT_SELF,FEAT_LAYONHANDS_HOSTILE,FALSE);
		}	
		if (GetLocalInt(GetModule(), "DivChampSpellcastingProgression"))
		{
			if (!GetHasFeat(FEAT_DIVCHA_SPELLCASTING))
				FeatAdd(OBJECT_SELF,FEAT_DIVCHA_SPELLCASTING,FALSE);
		}		
	}
	
	if (GetLevelByClass(CLASS_HOSPITALER) > 0) //Hospitaler
	{
		if (!GetHasFeat(FEAT_LAYONHANDS_HOSTILE, OBJECT_SELF, TRUE))
		{
			FeatAdd(OBJECT_SELF,FEAT_LAYONHANDS_HOSTILE,FALSE);
		}	
	}
	
	if (GetLocalInt(GetModule(),"PlanetouchedGetMartialWeaponProf"))
	{
		if (GetRacialType(OBJECT_SELF) == 21)
		{
			if(!GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL ,OBJECT_SELF))
				FeatAdd(OBJECT_SELF, FEAT_WEAPON_PROFICIENCY_MARTIAL, TRUE);
		}
	}
		
	if (GetLocalInt(GetModule(),"GrantSerenasCoin"))
	{
		object oCoin = GetItemPossessedBy(OBJECT_SELF, "cmi_coin_jeannie");
		if (!GetIsObjectValid(oCoin))
			CreateItemOnObject("cmi_coin_jeannie", OBJECT_SELF, 1, "cmi_coin_jeannie", TRUE);
	}	
	
	if (GetActionMode(OBJECT_SELF, 24) == TRUE)
	{
		SetActionMode(OBJECT_SELF, 24, FALSE);
		SetActionMode(OBJECT_SELF, 24, TRUE);		
	}
	
	int nUseConFix = GetLocalInt(GetModule(), "UseConFix");
	if (nUseConFix)
	{	
		
		//This will update the count of Con items on the player since localints are lost on logout
		object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
		CheckItemForConBonus(oItem);	
	    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		CheckItemForConBonus(oItem);
		
		int nCurrentHitPoints = GetCurrentHitPoints();
	
		DelayCommand(0.0f, SetLocalInt(OBJECT_SELF, "DisableConFix", TRUE));
		
		oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
		ClearAllActions(TRUE);
		DelayCommand(0.1f, ActionUnequipItem(oItem));
		
		oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
		DelayCommand(0.2f, ActionUnequipItem(oItem));
		DelayCommand(0.3f, ActionEquipItem(oItem, INVENTORY_SLOT_ARMS));	
		
	    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
		DelayCommand(0.4f, ActionUnequipItem(oItem));
		DelayCommand(0.5f, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTRING));
			
	    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);	
		DelayCommand(0.6f, ActionUnequipItem(oItem));
		DelayCommand(0.7f, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
		
	    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
		DelayCommand(0.8f, ActionUnequipItem(oItem));
		DelayCommand(0.9f, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTRING));
		
	    oItem = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
		DelayCommand(1.0f, ActionUnequipItem(oItem));
		DelayCommand(1.1f, ActionEquipItem(oItem, INVENTORY_SLOT_NECK));
		
	    oItem  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
		DelayCommand(1.2f, ActionUnequipItem(oItem));
		DelayCommand(1.3f, ActionEquipItem(oItem, INVENTORY_SLOT_CLOAK));
			
	    oItem  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
		DelayCommand(1.4f, ActionUnequipItem(oItem));
		DelayCommand(1.5f, ActionEquipItem(oItem, INVENTORY_SLOT_BOOTS));	
		
	    oItem = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
		DelayCommand(1.6f, ActionUnequipItem(oItem));
		DelayCommand(1.7f, ActionEquipItem(oItem, INVENTORY_SLOT_BELT));
		
	    oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
		DelayCommand(1.8f, ActionUnequipItem(oItem));
		DelayCommand(1.9f, ActionEquipItem(oItem, INVENTORY_SLOT_HEAD));	
		
	    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		DelayCommand(2.0f, ActionUnequipItem(oItem));
		DelayCommand(2.1f, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));
		
		oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
		//DelayCommand(2.1f, ActionUnequipItem(oItem));
		DelayCommand(2.2f, ClearAllActions(TRUE));
		DelayCommand(2.3f, ActionEquipItem(oItem, INVENTORY_SLOT_CHEST));	
		
		int nCurrentHP2 = GetCurrentHitPoints(OBJECT_SELF);	
		
		if (nCurrentHP2 < nCurrentHitPoints)
		{
			// Heal the diff
			effect eHeal = EffectHeal(nCurrentHitPoints - nCurrentHP2);
			DelayCommand(2.4f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));
		}
		else
		if (nCurrentHP2 > nCurrentHitPoints)
		{
			// Damage the diff
			effect eDamage = EffectDamage(nCurrentHP2 - nCurrentHitPoints, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
			DelayCommand(2.4f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF));
		}
		
		DelayCommand(2.5f, SetLocalInt(OBJECT_SELF, "DisableConFix", FALSE));		
		
	}
	//DelayCommand(3.0f, SendMessageToPC(OBJECT_SELF, "Test3"));		
															
}