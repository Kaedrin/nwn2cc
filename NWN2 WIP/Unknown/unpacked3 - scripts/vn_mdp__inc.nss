//------------------------------------------------------------------------------
//  C Daniel Vale 2005
//  djvale@gmail.com
//
//  C Laurie Vale 2005
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//------------------------------------------------------------------------------
// Script Name:mdp__inc
// Description: include file for functions specific to the item property modification
//------------------------------------------------------------------------------
#include "vn_inc_debug"
#include "vn_inc_array"
#include "vn_inc_items"


// Area tags for mdp
const string CRAFTING_ALLOWED = "NoPlay";
const string GUGOTHO_SMITH = "vn_gv_smith_ground";

// This allows you to adjust prices as you would a store. The default markup of 100% 
// means you pay twice the gold piece value for a custom item. You can put a negative 
// number here to discount the price. 
const int MDP_PERCENT_MARK_UP = 100;

// If this is set to TRUE the gold charge will be bypassed, but the cost will still display.  
//const int MDP_FOR_FREE = TRUE;  
const int MDP_FOR_FREE = FALSE;  
  
// This is set to TRUE when compiling for the override version.   
// This forces Charlie's Item Modifier to work in any area, even if the override is run on a   
// local game that initialises the system to use crafting restrictions.  
//const int MDP_OVERRIDE_CRAFTING = TRUE;  
const int MDP_OVERRIDE_CRAFTING = FALSE;  
  
// This overrides the module variable MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS  
// when Charlie's Item Modifier runs as an override (MDP_OVERRIDE_CRAFTING = TRUE)  
// If this is set TRUE, item modifications will be restricted (to less powerful properties).  
//const int MDP_RESTRICT_CRAFTER_IN_OVERRIDE = TRUE;  
const int MDP_RESTRICT_CRAFTER_IN_OVERRIDE = FALSE;

// This turns on a set of per area restrictions, used to customize individual crafting areas.  
// These restrictions are defined in vn_mdp_check_custom_rules, and are in addition to any  
// world/campaign/module wide restrictions defined in vn_mdp_check_allow.  
//const int MDP_AREA_RESTRICTIONS = TRUE;  
const int MDP_AREA_RESTRICTIONS = FALSE;


// Sequencer properties
const int ACTIVATE_ITEM_SEQUENCER_1 = 521;
const int ACTIVATE_ITEM_SEQUENCER_2 = 522;
const int ACTIVATE_ITEM_SEQUENCER_3 = 523;
const int CLEAR_SEQUENCER = 524;


// additional IP_CONST values
// these are the index values from ipropdef.2da
// not all CAN or SHOULD be used
const int IP_CONST_ABILITY_BONUS = 0;
const int IP_CONST_AC_BONUS = 1;
const int IP_CONST_AC_V_ALIGN = 2;
const int IP_CONST_AC_V_DAMAGE = 3;
const int IP_CONST_AC_V_RACE = 4;
const int IP_CONST_AC_V_SALIGN = 5;
const int IP_CONST_ENHANCEMENT_BONUS = 6;
const int IP_CONST_ENHANCEMENT_V_ALIGN = 7;
const int IP_CONST_ENHANCEMENT_V_RACE = 8;
const int IP_CONST_ENHANCEMENT_V_SALIGN = 9;
const int IP_CONST_ATTACK_PENALTY = 10;
const int IP_CONST_WEIGHT_REDUCTION = 11;
const int IP_CONST_BONUS_FEAT = 12;
const int IP_CONST_BONUS_LEVEL_SPELL = 13;
const int IP_CONST_BOOMERANG = 14; // DO NOT USE : no function for applying this
const int IP_CONST_CAST_SPELL = 15;
const int IP_CONST_DAMAGE_BONUS = 16;
const int IP_CONST_DAMAGE_V_ALIGN = 17;
const int IP_CONST_DAMAGE_V_RACE = 18;
const int IP_CONST_DAMAGE_V_SALIGN = 19;
const int IP_CONST_DAMAGE_IMMUNITY = 20;
const int IP_CONST_DAMAGE_PENALTY = 21;
const int IP_CONST_DAMAGE_REDUCED = 22; // Damage reduction doesn't seem to work???
const int IP_CONST_DAMAGE_RESISTANCE = 23;
const int IP_CONST_DAMAGE_VULNERABILITY = 24;
const int IP_CONST_DANCING_SCIMITAR = 25; // ?? HUH
const int IP_CONST_DARKVISION = 26;
const int IP_CONST_DECREASED_ABILITY = 27;
const int IP_CONST_DECREASED_AC = 28;
const int IP_CONST_DECREASED_SKILL = 29;
const int IP_CONST_DOUBLE_STACK = 30; // ?? HUH // DO NOT USE : no function for applying this
const int IP_CONST_ENHANCED_CONTAINER_BONUS_SLOT = 31; // ?? HUH // DO NOT USE : no function for applying this
const int IP_CONST_ENHANCED_CONTAINER_WEIGHT = 32; // ?? HUH
const int IP_CONST_DAMAGE_MELEE = 33;
const int IP_CONST_DAMAGE_RANGE = 34;
const int IP_CONST_HASTE = 35;
const int IP_CONST_HOLY_AVENGER = 36;
const int IP_CONST_IMMUNITY_MISC = 37;
const int IP_CONST_IMPROVED_EVASION = 38;
const int IP_CONST_BONUS_SPELL_RESISTANCE = 39;
const int IP_CONST_IMPROVED_SAVING_THROW = 40;
const int IP_CONST_IMPROVED_SAVING_THROW_SPECIFIC = 41;
// NOTHING IN ROW 42 OF 2DA TABLE
const int IP_CONST_KEEN = 43;
const int IP_CONST_LIGHT = 44;
const int IP_CONST_MIGHTY = 45;
const int IP_CONST_MIND_BLANK = 46; // DO NOT USE : no function for applying this
const int IP_CONST_DAMAGE_NONE = 47; // ?? HUH  - MAYBE FOR CURSED???
const int IP_CONST_ON_HIT = 48;
const int IP_CONST_REDUCED_SAVING_THROW = 49;
const int IP_CONST_REDUCED_SAVING_THROW_SPECIFIC = 50;
const int IP_CONST_REGENERATION = 51;
const int IP_CONST_SKILL_BONUS = 52;
const int IP_CONST_SPELL_IMMUNITY_SPECIFIC = 53;
const int IP_CONST_SPELL_IMMUNITY_SCHOOL = 54;
const int IP_CONST_THIEVES_TOOLS = 55; 
const int IP_CONST_ATTACK_BONUS = 56;
const int IP_CONST_ATTACK_V_ALIGN = 57;
const int IP_CONST_ATTACK_V_RACE = 58;
const int IP_CONST_ATTACK_V_SALIGN = 59;
const int IP_CONST_TO_HIT_PENALTY = 60;
const int IP_CONST_UNLIMITED_AMMO = 61;
const int IP_CONST_USE_LIMITATION_ALIGNMENT_GROUP = 62;
const int IP_CONST_USE_LIMITATION_CLASS = 63;
const int IP_CONST_USE_LIMITATION_RACIAL = 64;
const int IP_CONST_USE_LIMITATION_ALIGNMENT_SPECIFIC = 65;
const int IP_CONST_BONUS_HITPOINTS = 66;
const int IP_CONST_VAMPIRIC_REGENERATION = 67;
const int IP_CONST_VORPAL = 68; // DO NOT USE : no function for applying this
const int IP_CONST_WOUNDING = 69; // DO NOT USE : no function for applying this
const int IP_CONST_TRAP = 70;
const int IP_CONST_TRUE_SEEING = 71;
const int IP_CONST_ON_MONSTER_HIT = 72;
const int IP_CONST_TURN_RESISTANCE = 73;
const int IP_CONST_MASSIVE_CRITICAL = 74;
const int IP_CONST_FREE_ACTION = 75;
const int IP_CONST_POISON = 76; // DO NOT USE : no function for applying this
const int IP_CONST_MONSTER_DAMAGE = 77;
const int IP_CONST_IMMUNITY_SPELL_LEVEL = 78;
const int IP_CONST_SPECIAL_WALK = 79;
const int IP_CONST_HEALERS_KIT = 80;
const int IP_CONST_WEIGHT_INCREASE = 81;
const int IP_CONST_ON_HIT_CAST_SPELL = 82;
const int IP_CONST_VISUAL_EFFECT = 83;
const int IP_CONST_ARCANE_SPELL_FAILURE = 84;
const int IP_CONST_ARROW_CATCHING = 85; // DO NOT USE : no function for applying this
const int IP_CONST_BASHING = 86; // DO NOT USE : no function for applying this
const int IP_CONST_ANIMATED = 87; // DO NOT USE : no function for applying this
const int IP_CONST_WILD = 88; // DO NOT USE : no function for applying this
const int IP_CONST_ETHEREALNESS = 89; // DO NOT USE : no function for applying this
const int IP_CONST_DAMAGE_REDUCTION = 90;

// for use limitation by class
const int IP_CONST_CLASS_WARLOCK = 39;

int GetIsRemovalDisallowed(itemproperty ip);
// Is removal of property allowed

int GetFirstValidRemovalProperty(object oModifyItem);
// We don't allow removal of use restrictions
// Use restrictions can be listed before other properties
// This finds the first property that is valid under our 
// removal rules

int GetLastValidRemovalProperty(object oModifyItem);
// We don't allow removal of use restrictions
// Use restrictions can be listed before other properties
// This finds the last property that is valid under our 
// removal rules

int GetNextValidRemovalProperty(object oModifyItem,int nPropertyNumber);
// We don't allow removal of use restrictions
// Use restrictions can be listed anywhere in the list of properties
// This finds the next property that is valid under our 
// removal rules

int GetPreviousValidRemovalProperty(object oModifyItem,int nPropertyNumber);
// We don't allow removal of use restrictions
// Use restrictions can be listed anywhere in the list of properties
// This finds the previous property that is valid under our 
// removal rules

int	VerifyModificationCost(object oPC);
// Get the cost for the modification

void CustomAddProperty(object oItem, itemproperty ipToAdd);
//Add property ip to object oItem

int GetIsRemovalDisallowed(itemproperty ip)
// disallow removal of some properties
// 62 - 66 : use limitations
{
    int iType = GetItemPropertyType(ip);
    if (iType >= 62 && iType <= 65)
        return TRUE;

    return FALSE;
}

int GetFirstValidRemovalProperty(object oModifyItem)
// We don't allow removal of use restrictions
// Use restrictions can be listed before other properties
// This finds the first property that is valid under our 
// removal rules
{
	int nPropertyCount = 0;
	itemproperty ipTestProperty = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipTestProperty))
	{
		nPropertyCount++;
		if (!GetIsRemovalDisallowed(ipTestProperty)) 
			return nPropertyCount;
		else
			ipTestProperty = GetNextItemProperty(oModifyItem);
	}
	return nPropertyCount;//no properties on item
}

int GetLastValidRemovalProperty(object oModifyItem)
// We don't allow removal of use restrictions
// Use restrictions can be listed before other properties
// This finds the first property that is valid under our 
// removal rules
{
	int nPropertyCount = 0;
	int nLastValidProperty = 0;
	
	itemproperty ipTestProperty = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipTestProperty))
	{
		nPropertyCount++;
		if (!GetIsRemovalDisallowed(ipTestProperty)) 
			nLastValidProperty=nPropertyCount;
		
		ipTestProperty = GetNextItemProperty(oModifyItem);	
	}

	return nLastValidProperty;
}

			
int GetNextValidRemovalProperty(object oModifyItem,int nPropertyNumber)
// We don't allow removal of use restrictions
// Use restrictions can be listed anywhere in the list of properties
// This finds the next property that is valid under our 
// removal rules
{
	nPropertyNumber++;
	itemproperty ipTestProperty = GetItemProperty(oModifyItem, nPropertyNumber);

	while (GetIsItemPropertyValid(ipTestProperty))
	{
		if (!GetIsRemovalDisallowed(ipTestProperty))	
			return nPropertyNumber;
		else
		{
			ipTestProperty = GetNextItemProperty(oModifyItem);
			nPropertyNumber++;
		}
	}

	nPropertyNumber = GetFirstValidRemovalProperty(oModifyItem);
	return nPropertyNumber;
}

int GetPreviousValidRemovalProperty(object oModifyItem,int nPropertyNumber)
// We don't allow removal of use restrictions
// Use restrictions can be listed anywhere in the list of properties
// This finds the previous property that is valid under our 
// removal rules
{
	nPropertyNumber--;
	itemproperty ipTestProperty = GetItemProperty(oModifyItem, nPropertyNumber);

	while (GetIsItemPropertyValid(ipTestProperty))
	{
		if (!GetIsRemovalDisallowed(ipTestProperty))	
			return nPropertyNumber;
		else
		{
			nPropertyNumber--;
			ipTestProperty = GetItemProperty(oModifyItem, nPropertyNumber);
		}
	}

	nPropertyNumber = GetLastValidRemovalProperty(oModifyItem);
	return nPropertyNumber;
}

int	VerifyModificationCost(object oPC)
// Get the cost for the modification
{
	// we use the REMOVAL_MODIFY_ITEM as the base cost so that a PC
	// can't remove properties first then add properties to bring the value
	// to the same as the original value and get property changes for free.
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	int nRemovalModifyValue = GetGoldPieceValue(oRemovalModifyItem);
	int nModifiedValue = GetGoldPieceValue(oModifyItem); 
	int nModCost;
	// using floats to avoid overflow in the calculation.
	float fModCost = IntToFloat(nModifiedValue - nRemovalModifyValue);
	fModCost = fModCost * IntToFloat(MDP_PERCENT_MARK_UP + 100) / 100.0;
	nModCost = FloatToInt(fModCost);
	

//	if (nModCost < 0)
//		nModCost = 0;
		
	return nModCost;
}
//Add property ip to object oItem
void CustomAddProperty(object oItem, itemproperty ipToAdd)
{
    //DebugLiveOn();
    //Find and remove existing property with same type as ip, then add ip
    int iTypeToAdd = GetItemPropertyType(ipToAdd);
    int iSubTypeToAdd = GetItemPropertySubType(ipToAdd);

    object oPC = GetPCSpeaker();
    SendMessageToPC(oPC, "Property being added:-");
    DebugShowItemProperty(ipToAdd, oPC);

    // Test to see if we are adding any special properties (as in special cases)
    int bSequencer = 
	(
		iTypeToAdd == IP_CONST_CAST_SPELL && 
		(
			iSubTypeToAdd == ACTIVATE_ITEM_SEQUENCER_1 ||
			iSubTypeToAdd == ACTIVATE_ITEM_SEQUENCER_2 ||
			iSubTypeToAdd == ACTIVATE_ITEM_SEQUENCER_3
		)	
	);
	
    int bSpellSlot = (iTypeToAdd == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N);
    int bLight = (iTypeToAdd == IP_CONST_LIGHT);
	int bVisualEffect = (iTypeToAdd == IP_CONST_VISUAL_EFFECT);
    int bWeightReduction = (iTypeToAdd == IP_CONST_WEIGHT_REDUCTION);

	Debug
	(
		"bSequencer = " + IntToString(bSequencer) + " : " +
		"bSpellSlot = " + IntToString(bSpellSlot) + " : " +
//		"bSneakAttack = " + IntToString(bSneakAttack) + " : " +
//		"bDamageReduction = " + IntToString(bDamageReduction) + " : " +
		"bLight = " + IntToString(bLight)  + " : " +
		"bWeightReduction = " + IntToString(bWeightReduction)
		, MDP
		, 3
	);

    //Loop through item properties looking for match
    int bReplaceExistingProperty = FALSE;
    itemproperty ipOnItem = GetFirstItemProperty(oItem);

    while ((! bReplaceExistingProperty) && GetIsItemPropertyValid(ipOnItem))
    {
    //    Debug("Property on item:-", oPC);
    //    DebugShowItemProperty(ipOnItem, oPC);
        int iTypeOnItem = GetItemPropertyType(ipOnItem);
        int iSubTypeOnItem = GetItemPropertySubType(ipOnItem);

        // Test for a match
        if (iTypeToAdd == iTypeOnItem)
        {
            if (bSequencer)
            {
                // Allow only one sequencer property at a time, but keep clear sequencer
                bReplaceExistingProperty =
                (
                     iSubTypeOnItem == ACTIVATE_ITEM_SEQUENCER_1 ||
                     iSubTypeOnItem == ACTIVATE_ITEM_SEQUENCER_2 ||
                     iSubTypeOnItem == ACTIVATE_ITEM_SEQUENCER_3
                );
				Debug("vn_mdp__inc: CustomAddProperty() - Replace sequencer: " + IntToString(bReplaceExistingProperty));
            }
            else if (bWeightReduction)
            {
                // Allow only one weight reduction property at a time.
                bReplaceExistingProperty = TRUE;
            }
            else if (bLight)
            {
                // Allow only one light at a time.
                bReplaceExistingProperty = TRUE;
            }
            else if (bVisualEffect)
            {
                // Allow only one visual effect at a time.
                bReplaceExistingProperty = TRUE;
            }
            else if (bSpellSlot)
            {
                // Allow multiple spell slots,
                //   as long as they are different lvls / classes
                // For bonus spell levels:
                // iTyp is ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N
                // iSubTyp is the class constant
                // Need to get the cost table value to determine the spell level
                int iCostTableValue = GetItemPropertyCostTableValue(ipToAdd);
                int iCostTableValue1 = GetItemPropertyCostTableValue(ipOnItem);
     //           Debug("you already have a spell slot", oPC);
                bReplaceExistingProperty = (iSubTypeToAdd == iSubTypeOnItem) && (iCostTableValue == iCostTableValue1);
            }
            else
            {
                // default test, covers most properties. If the sub types match
                // or there is no sub type, the properties are mutually exclusive
  //              Debug("oops, using default match policy", oPC);
                bReplaceExistingProperty = (iTypeToAdd == iTypeOnItem  && (iSubTypeToAdd == iSubTypeOnItem || iSubTypeToAdd == -1));
            }// if: check special types

        }// if: match base type (iTyp == iTyp1)


        if (! bReplaceExistingProperty)
            ipOnItem = GetNextItemProperty(oItem);
    }

    if (bReplaceExistingProperty)
       RemoveItemProperty(oItem, ipOnItem);

    AddItemProperty(DURATION_TYPE_PERMANENT, ipToAdd, oItem);

    //DebugLiveOff();

}

itemproperty ItemPropertyUniversal(int nType, int nSubType1 = 0, int nSubType2 = 0, int nSubType3 = 0)
{
	Debug
	(
		"vn_mdp_inc: ItemPropertyUniversal - \n" +
		"  nType = " + IntToString(nType) + "\n" +
		"  nSubType1 = " + IntToString(nSubType1) + "\n" +
		"  nSubType2 = " + IntToString(nSubType2) + "\n" +
		"  nSubType3 = " + IntToString(nSubType3) + "\n" 
//		, MDP
		, TRE
		, 2
	);
	switch(nType)
	{
		case IP_CONST_ABILITY_BONUS:
			return ItemPropertyAbilityBonus(nSubType1, nSubType2);
		case IP_CONST_AC_BONUS:
			return ItemPropertyACBonus(nSubType1);
		case IP_CONST_AC_V_ALIGN:
			return ItemPropertyACBonusVsAlign(nSubType1, nSubType2);
		case IP_CONST_AC_V_DAMAGE:
			return ItemPropertyACBonusVsDmgType(nSubType1, nSubType2);
		case IP_CONST_AC_V_RACE:
			return ItemPropertyACBonusVsRace(nSubType1, nSubType2);
		case IP_CONST_AC_V_SALIGN:
			return ItemPropertyACBonusVsSAlign(nSubType1, nSubType2);
		case IP_CONST_ENHANCEMENT_BONUS:
			return ItemPropertyEnhancementBonus(nSubType1);
		case IP_CONST_ENHANCEMENT_V_ALIGN:
			return ItemPropertyEnhancementBonusVsAlign(nSubType1, nSubType2);
		case IP_CONST_ENHANCEMENT_V_RACE:
			return ItemPropertyEnhancementBonusVsRace(nSubType1, nSubType2);
		case IP_CONST_ENHANCEMENT_V_SALIGN:
			return ItemPropertyEnhancementBonusVsSAlign(nSubType1, nSubType2);
		case IP_CONST_ATTACK_PENALTY:
			return ItemPropertyAttackPenalty(nSubType1);
		case IP_CONST_WEIGHT_REDUCTION:
			return ItemPropertyWeightReduction(nSubType1); 			
		case IP_CONST_BONUS_FEAT:
			return ItemPropertyBonusFeat(nSubType1);
		case IP_CONST_BONUS_LEVEL_SPELL:
			return ItemPropertyBonusLevelSpell(nSubType1, nSubType2);
		case IP_CONST_CAST_SPELL:
			return ItemPropertyCastSpell(nSubType1, nSubType2);
		case IP_CONST_DAMAGE_BONUS:
			return ItemPropertyDamageBonus(nSubType1, nSubType2);
		case IP_CONST_DAMAGE_V_ALIGN:
			if (Get2DAString("itempropdef", "Param1ResRef", 17) != "")
				return ItemPropertyDamageBonusVsAlign(nSubType1, nSubType3, nSubType2);
			else
				return ItemPropertyDamageBonusVsAlign(nSubType1, DAMAGE_TYPE_PIERCING, nSubType2);
			
		case IP_CONST_DAMAGE_V_RACE:
		{
			if (Get2DAString("itempropdef", "Param1ResRef", 18) != "")
				return ItemPropertyDamageBonusVsRace(nSubType1, nSubType3, nSubType2); // custom (fixed) itempropdef.2da
			else
				return ItemPropertyDamageBonusVsRace(nSubType1, DAMAGE_TYPE_PIERCING, nSubType2/*, nSubType3*/); // The 2da dosen't link to a damage type for damage Vs race NWN2 1.04
		}	
		case IP_CONST_DAMAGE_V_SALIGN:
		{
			if (Get2DAString("itempropdef", "Param1ResRef", 19) != "")
				return ItemPropertyDamageBonusVsSAlign(nSubType1, nSubType3, nSubType2); // custom (fixed) itempropdef.2da
			else
				return ItemPropertyDamageBonusVsSAlign(nSubType1, DAMAGE_TYPE_PIERCING, nSubType2/*, nSubType3*/); // The 2da dosen't link to a damage type for damage Vs race NWN2 1.04
		}	
		case IP_CONST_DAMAGE_IMMUNITY:
			return ItemPropertyDamageImmunity(nSubType1, nSubType2);
		case IP_CONST_DAMAGE_PENALTY:
			return ItemPropertyDamagePenalty(nSubType1);						
		case IP_CONST_DAMAGE_RESISTANCE:
			return ItemPropertyDamageResistance(nSubType1, nSubType2);									
		case IP_CONST_DAMAGE_VULNERABILITY:
			return ItemPropertyDamageVulnerability(nSubType1, nSubType2);
		case IP_CONST_DARKVISION:
			return ItemPropertyDarkvision();							
		case IP_CONST_DECREASED_ABILITY:
			return ItemPropertyDecreaseAbility(nSubType1, nSubType2);
		case IP_CONST_DECREASED_AC:
			return ItemPropertyDecreaseAC(nSubType1, nSubType2);			
		case IP_CONST_DECREASED_SKILL:
			return ItemPropertyDecreaseSkill(nSubType1, nSubType2);	
		case IP_CONST_DAMAGE_MELEE:
			return ItemPropertyExtraMeleeDamageType(nSubType1);						
		case IP_CONST_DAMAGE_RANGE:
			return ItemPropertyExtraRangeDamageType(nSubType1);	
		case IP_CONST_HASTE:
			return ItemPropertyHaste();			
		case IP_CONST_HOLY_AVENGER:
			return ItemPropertyHolyAvenger();
		case IP_CONST_IMMUNITY_MISC:
			return ItemPropertyImmunityMisc(nSubType1);
		case IP_CONST_IMPROVED_EVASION:
			return ItemPropertyImprovedEvasion();
		case IP_CONST_BONUS_SPELL_RESISTANCE:
			return ItemPropertyBonusSpellResistance(nSubType1);			
		case IP_CONST_IMPROVED_SAVING_THROW:
			return ItemPropertyBonusSavingThrowVsX(nSubType1, nSubType2);
		case IP_CONST_IMPROVED_SAVING_THROW_SPECIFIC:
			return ItemPropertyBonusSavingThrow(nSubType1, nSubType2);
		case IP_CONST_KEEN:
			return ItemPropertyKeen();
		case IP_CONST_LIGHT:
			return ItemPropertyLight(nSubType1, nSubType2);												
		case IP_CONST_MIGHTY:
			return ItemPropertyMaxRangeStrengthMod(nSubType1);
		case IP_CONST_DAMAGE_NONE:
			return ItemPropertyNoDamage();
		case IP_CONST_ON_HIT:
			return ItemPropertyOnHitProps(nSubType1, nSubType2, nSubType3);
		case IP_CONST_REDUCED_SAVING_THROW:
			return ItemPropertyReducedSavingThrowVsX(nSubType1, nSubType2);
		case IP_CONST_REDUCED_SAVING_THROW_SPECIFIC:
			return ItemPropertyReducedSavingThrow(nSubType1, nSubType2);						
		case IP_CONST_REGENERATION:
			return ItemPropertyRegeneration(nSubType1);
		case IP_CONST_SKILL_BONUS:
			return ItemPropertySkillBonus(nSubType1, nSubType2);
		case IP_CONST_SPELL_IMMUNITY_SPECIFIC:
			return ItemPropertySpellImmunitySpecific(nSubType1);
		case IP_CONST_SPELL_IMMUNITY_SCHOOL:
			return ItemPropertySpellImmunitySchool(nSubType1);
		case IP_CONST_ATTACK_BONUS:
			return ItemPropertyAttackBonus(nSubType1);
		case IP_CONST_ATTACK_V_ALIGN:
			return ItemPropertyAttackBonusVsAlign(nSubType1, nSubType2);
		case IP_CONST_ATTACK_V_RACE:
			return ItemPropertyAttackBonusVsRace(nSubType1, nSubType2);
		case IP_CONST_ATTACK_V_SALIGN:
			return ItemPropertyAttackBonusVsSAlign(nSubType1, nSubType2);
		case IP_CONST_TO_HIT_PENALTY:
			return ItemPropertyAttackPenalty(nSubType1);
		case IP_CONST_UNLIMITED_AMMO:
			return ItemPropertyUnlimitedAmmo(nSubType1); 
		case IP_CONST_USE_LIMITATION_ALIGNMENT_GROUP:
			return ItemPropertyLimitUseByAlign(nSubType1); 									
		case IP_CONST_USE_LIMITATION_CLASS:
			return ItemPropertyLimitUseByClass(nSubType1); 	
		case IP_CONST_USE_LIMITATION_RACIAL:
			return ItemPropertyLimitUseByRace(nSubType1); 	
		case IP_CONST_USE_LIMITATION_ALIGNMENT_SPECIFIC:
			return ItemPropertyLimitUseBySAlign(nSubType1); 										
		case IP_CONST_BONUS_HITPOINTS:
			return ItemPropertyBonusHitpoints(nSubType1);
		case IP_CONST_VAMPIRIC_REGENERATION:
			return ItemPropertyVampiricRegeneration(nSubType1);
		case IP_CONST_TRUE_SEEING:
			return ItemPropertyTrueSeeing();			
		case IP_CONST_MASSIVE_CRITICAL:
			return ItemPropertyMassiveCritical(nSubType1);
		case IP_CONST_FREE_ACTION:
			return ItemPropertyFreeAction();
		case IP_CONST_IMMUNITY_SPELL_LEVEL:
			return ItemPropertyImmunityToSpellLevel(nSubType1 + 1); // offset required as 2da does not align with function
		case IP_CONST_WEIGHT_INCREASE:
			return ItemPropertyWeightIncrease(nSubType1);
		case IP_CONST_ON_HIT_CAST_SPELL:
			return ItemPropertyOnHitCastSpell(nSubType1, nSubType2);
		case IP_CONST_VISUAL_EFFECT:
			return ItemPropertyVisualEffect(nSubType1);
		case IP_CONST_ARCANE_SPELL_FAILURE:
			return ItemPropertyArcaneSpellFailure(nSubType1);

		}
		Error("vn_mdp__inc: ItemPropertyUniversal : Unhandled IP_CONST value : " + IntToString(nType),MDP);
		return GetFirstItemProperty(OBJECT_INVALID);
}

//	void main() {}