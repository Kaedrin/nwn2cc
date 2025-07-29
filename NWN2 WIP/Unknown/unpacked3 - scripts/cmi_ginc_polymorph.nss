//::///////////////////////////////////////////////
//:: General Include for Spells
//:: cmi_ginc_spells
//:: Utility script for spells
//:: Created By: Kaedrin (Matt)
//:: Created On: June 25, 2007
//:://////////////////////////////////////////////

//#include "X0_I0_SPELLS"

// X2_IP_ADDPROP_POLICY_REPLACE_EXISTING is in x2_inc_itemprop
// x2_inc_itemprop for item properties, reference marker.


#include "x2_inc_itemprop"
#include "cmi_includes"
#include "cmi_ginc_spells"


void WildshapeAbilityBuffs(object oPC, float fDuration, object oRightHand = OBJECT_INVALID, object oLeftHand = OBJECT_INVALID)
{

	int nDruidLevel = GetLevelByClass(CLASS_TYPE_DRUID);
	nDruidLevel+= GetLevelByClass(CLASS_LION_TALISID);
	nDruidLevel+= GetLevelByClass(CLASS_NATURES_WARRIOR);	
	nDruidLevel+= GetLevelByClass(CLASS_DAGGERSPELL_SHAPER);	
	
	int    nSpell = GetSpellId();
	//SendMessageToPC(OBJECT_SELF, IntToString(nSpell));

	object oCWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC);
	object oCWeapon2 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
	object oCWeapon3 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
	object oCHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	
	//FEAT_EXALTED_NATURAL_ATTACK
	if (GetHasFeat(FEAT_EXALTED_NATURAL_ATTACK, oPC))
	{

		if (GetIsObjectValid(oCWeapon1))
		{
			IPSafeAddItemProperty(oCWeapon1,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oCWeapon1,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oCWeapon1,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
		}
				
		if (GetIsObjectValid(oCWeapon2))
		{

			IPSafeAddItemProperty(oCWeapon2,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oCWeapon2,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oCWeapon2,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
		}
				
		if (GetIsObjectValid(oCWeapon3))
		{		
			IPSafeAddItemProperty(oCWeapon3,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oCWeapon3,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oCWeapon3,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
		}		
	}
	
	//Jagged Tooth
	if (GetHasSpellEffect(1002, oPC))
	{
		int CL = GetCasterLevel(oPC);				
		float fSpellDuration = 10 * TurnsToSeconds(CL);	
		itemproperty iKeen = ItemPropertyKeen();	
		itemproperty iImpCritUnarm = ItemPropertyBonusFeat(IP_CONST_FEAT_IMPCRITUNARM);
		itemproperty iNatCritUnarm = ItemPropertyBonusFeat(IPRP_FEAT_IMPCRITCREATURE);		
		if (GetIsObjectValid(oCHide))
		{
			IPSafeAddItemProperty(oCHide, iKeen, fSpellDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
			IPSafeAddItemProperty(oCHide, iImpCritUnarm, fSpellDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
			IPSafeAddItemProperty(oCHide, iNatCritUnarm, fSpellDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);						
		}				
	}
	
	//Greater Magic Fang
	if (GetHasSpellEffect(453, oPC))
	{
	
		int CL = GetCasterLevel(oPC);
    	int nPower = (CL + 1) / 3;	
		int nFangBuff = GetLocalInt(GetModule(), "FangLineExceeds20");
		float fSpellDuration = TurnsToSeconds(CL);
	    if ((nPower > 5) && (!nFangBuff))
	    	nPower = 5;  // * max of +5 bonus	
			
		itemproperty iEbonus = ItemPropertyEnhancementBonus(nPower);
		float fDuration = TurnsToSeconds(nDruidLevel);
		
		if (GetIsObjectValid(oCWeapon1))
		{
			IPSafeAddItemProperty(oCWeapon1, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
		}
		if (GetIsObjectValid(oCWeapon2))
		{
			IPSafeAddItemProperty(oCWeapon2, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
		}
		if (GetIsObjectValid(oCWeapon3))
		{
			IPSafeAddItemProperty(oCWeapon3, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
		}				
				
	
	}	
	//Magic Fang
	else	
	if (GetHasSpellEffect(452, oPC))
	{
		itemproperty iEbonus = ItemPropertyEnhancementBonus(1);
		float fSpellDuration = TurnsToSeconds(nDruidLevel);
		if (GetIsObjectValid(oCWeapon1))
		{
			IPSafeAddItemProperty(oCWeapon1, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
		}
		if (GetIsObjectValid(oCWeapon2))
		{
			IPSafeAddItemProperty(oCWeapon2, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
		}
		if (GetIsObjectValid(oCWeapon3))
		{
			IPSafeAddItemProperty(oCWeapon3, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
		}
	
	}
	
	if (GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oPC) > 1)
	{
		//SendMessageToPC(oPC, "Dagger 1 Name: " + GetName(oRightHand));
		if (GetIsObjectValid(oRightHand) && (GetBaseItemType(oRightHand) == BASE_ITEM_DAGGER) )
		{
			itemproperty iEbonus = ItemPropertyEnhancementBonus(IPGetWeaponEnhancementBonus(oRightHand));
			float fSpellDuration = TurnsToSeconds(nDruidLevel);
			if (GetIsObjectValid(oCWeapon1))
			{
				IPSafeAddItemProperty(oCWeapon1, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
			}
			if (GetIsObjectValid(oCWeapon2))
			{
				IPSafeAddItemProperty(oCWeapon2, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
			}
			if (GetIsObjectValid(oCWeapon3))
			{
				IPSafeAddItemProperty(oCWeapon3, iEbonus, fSpellDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
			}		
		}	
	}			


}


void FixPolymorph(float fDuration, int nWisBonus, int nChaBonus, int nIntBonus)
{


	object oBracer = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }
	
	
	
	
	//Fix for Spell Slot loss	
	object oCursedPolyItem = CreateItemOnObject("cmi_cursedpoly",OBJECT_SELF,1,"",FALSE);
	if (oCursedPolyItem == OBJECT_INVALID)
		SendMessageToPC(OBJECT_SELF, "Your Inventory was full so bonus spell slots from items and racial spellcasting stat modifiers will not survive the transition to your new form.");
	
	AddSpellSlotsToObject(oWeaponOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oArmorOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oRing1Old,oCursedPolyItem, fDuration);
	AddSpellSlotsToObject(oRing2Old,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oAmuletOld,oCursedPolyItem, fDuration);
	AddSpellSlotsToObject(oCloakOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oBootsOld,oCursedPolyItem, fDuration);			
	AddSpellSlotsToObject(oBeltOld,oCursedPolyItem, fDuration);
	AddSpellSlotsToObject(oHelmetOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oShield,oCursedPolyItem, fDuration);
	
	//SendMessageToPC(GetFirstPC(), IntToString(nWisBonus));
	
	if (nWisBonus > 12)
		nWisBonus = 12;	
	if (nIntBonus > 12)
		nIntBonus = 12;	
	if (nChaBonus > 12)
		nChaBonus = 12;	
						
	itemproperty ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, nWisBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

	ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, nIntBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

	ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nChaBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
	
	WildshapeCheck (OBJECT_SELF,oCursedPolyItem);
		
}