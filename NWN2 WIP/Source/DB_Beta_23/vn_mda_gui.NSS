//-----------------------------------------------------------------------------
//  C Daniel Vale 2007
//  djvale@gmail.com
//
//  C Laurie Vale 2007
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
//  Script Name: vn_mda_gui
//  Description: GUI functions for modifying item appearance
//------------------------------------------------------------------------------
#include "vn_mda__inc"
#include "vn_inc_constants"

// Get the base armor type so that only armor of the same type is offered
// ALL armor returns BaseItemType BASE_ITEM_ARMOR
// Chanshirt is baseAC 4 and light, scalemail is baseAC 4 and medium
// both breastplate and chainmail are baseAC 5, but the dex bonus is different
// the only way to differentiate between the armor is the base gold value - it is
// important that all the base armor made for the appearance modifier is left
// at the default price, so people can't change their base armor type when changing
// the appearance.
string mda_GetBaseArmorType(object oTestArmor, object oPC)
{
	string sArmorType;
	
	// breast and splint are both the same price but different ranks
	int nArmorRank = GetArmorRank(oTestArmor);
	
	int nArmorBaseValue = GetGoldPieceValue(oTestArmor);
	
	if(GetIsDM(oPC))
	{
		switch(nArmorBaseValue)
		{
			case 1: sArmorType = "cloth";break; 
			case 5: sArmorType = "padded";break;
			case 10: sArmorType = "leather";break;
			case 15: sArmorType = "hide";break;
			case 25: sArmorType = "studded";break;
			case 50: sArmorType = "scalemail";break;
			case 100: sArmorType = "chainshirt";break;
			case 150: sArmorType = "chainmail";break;
			case 200: 
				if (nArmorRank == ARMOR_RANK_HEAVY)
				{
					sArmorType = "splint";
					break;
				}
				if (nArmorRank == ARMOR_RANK_MEDIUM)
				{
					sArmorType = "breastplate";
					break;
				}
			case 250: sArmorType = "banded";break;
			case 600: sArmorType = "halfplate";break;
			case 1100: sArmorType = "mithral_chainshirt";break;
			case 1500: sArmorType = "fullplate";break;
			case 4050: sArmorType = "mithral_scalemail";break;
			case 4150: sArmorType = "mithral_chainmail";break;
			case 4200:
				if (nArmorRank == ARMOR_RANK_MEDIUM)
				{
					sArmorType = "mithral_splint";
					break;
				}
				if (nArmorRank == ARMOR_RANK_LIGHT)
				{
					sArmorType = "mithral_breastplate";
					break;
				}
			case 9250: sArmorType = "mithral_banded";break;
			case 9600: sArmorType = "mithral_halfplate";break;
			case 10500: sArmorType = "mithral_fullplate";break;
			
			default: sArmorType = "error";break;
		}	
	}
	else
	{
		switch(nArmorBaseValue)
		{
			case 1: sArmorType = "cloth";break; 
			case 5: sArmorType = "padded";break;
			case 10: sArmorType = "leather";break;
			case 15: sArmorType = "hide";break;
			case 25: sArmorType = "studded";break;
			case 50: sArmorType = "scalemail";break;
			case 100: sArmorType = "chainshirt";break;
			case 150: sArmorType = "chainmail";break;
			case 200: 
				if (nArmorRank == ARMOR_RANK_HEAVY)
				{
					sArmorType = "splint";
					break;
				}
				if (nArmorRank == ARMOR_RANK_MEDIUM)
				{
					sArmorType = "breastplate";
					break;
				}
			case 250: sArmorType = "banded";break;
			case 600: sArmorType = "halfplate";break;
			case 1500: sArmorType = "fullplate";break;

			default: sArmorType = "error";break;
		}	
	}
	
	return sArmorType;
}

// get the base resref for the item 
// just a big if statement, so it's here to get it out of the way
string mda_GetBaseResRef(string sItem)
{
	string sBaseResRef;

	if (sItem == "helm")
	   sBaseResRef = HELM;
	else if (sItem == "cloak")
	   sBaseResRef = CLOAK;
	else if (sItem == "boots")
	   sBaseResRef = BOOTS;
	else if (sItem == "gloves")
	   sBaseResRef = GLOVES;
	else if (sItem == "bracer")
		sBaseResRef = BRACERS;   
	else if (sItem == "cloth")
	   sBaseResRef = CLOTH;
	else if (sItem == "padded")
	   sBaseResRef = PADDED;
	else if (sItem == "leather")
	   sBaseResRef = LEATHER;
	else if (sItem == "studded")
	   sBaseResRef = STUDDED;
	else if (sItem == "chainshirt")
	   sBaseResRef = CHAINSHIRT;
	else if (sItem == "hide")
	   sBaseResRef = HIDE;
	else if (sItem == "scalemail")
	   sBaseResRef = SCALEMAIL;
	else if (sItem == "chainmail")
	   sBaseResRef = CHAINMAIL;
	else if (sItem == "breastplate")
	   sBaseResRef = BREASTPLATE;
	else if (sItem == "banded")
	   sBaseResRef = BANDED;
	else if (sItem == "halfplate")
	   sBaseResRef = HALFPLATE;
	else if (sItem == "fullplate")
	   sBaseResRef = FULLPLATE;
	else if (sItem == "splint")
		sBaseResRef = SPLINT;   
	else if (sItem == "mithral_chainshirt")
		sBaseResRef = MITHRAL_CHAINSHIRT;
	else if (sItem == "mithral_scalemail")
		sBaseResRef = MITHRAL_SCALEMAIL;
	else if (sItem == "mithral_chainmail")
		sBaseResRef = MITHRAL_CHAINMAIL;
	else if (sItem == "mithral_splint")
		sBaseResRef = MITHRAL_SPLINT;
	else if (sItem == "mithral_breastplate")
		sBaseResRef = MITHRAL_BREASTPLATE;
	else if (sItem == "mithral_banded")
		sBaseResRef = MITHRAL_BANDED;
	else if (sItem == "mithral_halfplate")
		sBaseResRef = MITHRAL_HALFPLATE;
	else if (sItem == "mithral_fullplate")
		sBaseResRef = MITHRAL_FULLPLATE;   
	else if (sItem ==  "light")
	   sBaseResRef = LIGHTSHIELD;
	else if (sItem == "heavy")
	   sBaseResRef = HEAVYSHIELD;
	else if (sItem == "tower")
	   sBaseResRef = TOWERSHIELD;
	else if (sItem == "bastardsword")
	   sBaseResRef = BASTARDSWORD;
	else if (sItem == "battleaxe")
	   sBaseResRef = BATTLEAXE;
	else if (sItem == "club")
	   sBaseResRef = CLUB;
	else if (sItem == "dagger")
	   sBaseResRef = DAGGER;
	else if (sItem == "dwarvenwaraxe")
	   sBaseResRef = DWARVENWARAXE;
	else if (sItem == "falchion")
	   sBaseResRef = FALCHION;
	else if (sItem == "greataxe")
	   sBaseResRef = GREATAXE;
	else if (sItem == "greatsword")
	   sBaseResRef = GREATSWORD;
	else if (sItem == "halberd")
	   sBaseResRef = HALBERD;
	else if (sItem == "handaxe")
	   sBaseResRef = HANDAXE;
	else if (sItem == "heavycrossbow")
	   sBaseResRef = HEAVYCROSSBOW;
	else if (sItem == "kama")
	   sBaseResRef = KAMA;
	else if (sItem == "katana")
	   sBaseResRef = KATANA;
	else if (sItem == "kukri")
	   sBaseResRef = KUKRI;
	else if (sItem == "lightcrossbow")
	   sBaseResRef = LIGHTCROSSBOW;
	else if (sItem == "lightflail")
	   sBaseResRef = LIGHTFLAIL;
	else if (sItem == "lighthammer")
	   sBaseResRef = LIGHTHAMMER;
	else if (sItem == "longbow")
	   sBaseResRef = LONGBOW;
	else if (sItem == "longsword")
	   sBaseResRef = LONGSWORD;
	else if (sItem == "mace")
	   sBaseResRef = MACE;
	else if (sItem == "morningstar")
	   sBaseResRef = MORNINGSTAR;
	else if (sItem == "quarterstaff")
	   sBaseResRef = QUARTERSTAFF;
	else if (sItem == "rapier")
	   sBaseResRef = RAPIER;
	else if (sItem == "scimitar")
	   sBaseResRef = SCIMITAR;
	else if (sItem == "scythe")
	   sBaseResRef = SCYTHE;
	else if (sItem == "shortbow")
	   sBaseResRef = SHORTBOW;
	else if (sItem == "shortsword")
	   sBaseResRef = SHORTSWORD;
	else if (sItem == "sickle")
	   sBaseResRef = SICKLE;
	else if (sItem == "spear")
	   sBaseResRef = SPEAR;
	else if (sItem == "warhammer")
	   sBaseResRef = WARHAMMER;
	else if (sItem == "warmace")
	   sBaseResRef = WARMACE;

	return sBaseResRef;
}
// get the base resref for the item
// just a big if statement, so it's here to get it out of the way
int mda_GetBaseVariationsNumber(string sItem)
{
	int nBaseVariations;

	if (sItem == "helm")
	   nBaseVariations = HELM_VARIATIONS;
	if (sItem == "cloak")
	   nBaseVariations = CLOAK_VARIATIONS;
	if (sItem == "boots")
	   nBaseVariations = BOOTS_VARIATIONS;
	if (sItem == "gloves")
	   nBaseVariations = GLOVES_VARIATIONS;
	if (sItem == "bracer")
	   nBaseVariations = BRACER_VARIATIONS;
	if (sItem == "cloth")
	   nBaseVariations = CLOTH_VARIATIONS;
	if (sItem == "padded")
	   nBaseVariations = PADDED_VARIATIONS;
	if (sItem == "leather")
	   nBaseVariations = LEATHER_VARIATIONS;
	if (sItem == "studded")
	   nBaseVariations = STUDDED_VARIATIONS;
	if (sItem == "chainshirt")
	   nBaseVariations = CHAINSHIRT_VARIATIONS;
	if (sItem == "hide")
	   nBaseVariations = HIDE_VARIATIONS;
	if (sItem == "scalemail")
	   nBaseVariations = SCALEMAIL_VARIATIONS;
	if (sItem == "chainmail")
	   nBaseVariations = CHAINMAIL_VARIATIONS;
	if (sItem == "breastplate")
	   nBaseVariations = BREASTPLATE_VARIATIONS;
	if (sItem == "banded")
	   nBaseVariations = BANDED_VARIATIONS;
	if (sItem == "halfplate")
	   nBaseVariations = HALFPLATE_VARIATIONS;
	if (sItem == "fullplate")
	   nBaseVariations = FULLPLATE_VARIATIONS;
	if (sItem == "splint")
		nBaseVariations = SPLINT_VARIATIONS;   
	if (sItem == "mithral_chainshirt")
		nBaseVariations = MITHRAL_CHAINSHIRT_VARIATIONS;
	if (sItem == "mithral_scalemail")
		nBaseVariations = MITHRAL_SCALEMAIL_VARIATIONS;
	if (sItem == "mithral_chainmail")
		nBaseVariations = MITHRAL_CHAINMAIL_VARIATIONS;
	if (sItem == "mithral_splint")
		nBaseVariations = MITHRAL_SPLINT_VARIATIONS;
	if (sItem == "mithral_breastplate")
		nBaseVariations = MITHRAL_BREASTPLATE_VARIATIONS;
	if (sItem == "mithral_banded")
		nBaseVariations = MITHRAL_BANDED_VARIATIONS;
	if (sItem == "mithral_halfplate")
		nBaseVariations = MITHRAL_HALFPLATE_VARIATIONS;
	if (sItem == "mithral_fullplate")
		nBaseVariations = MITHRAL_FULLPLATE_VARIATIONS;   	   
	if (sItem ==  "light")
	   nBaseVariations = LIGHTSHIELD_VARIATIONS;
	if (sItem == "heavy")
	   nBaseVariations = HEAVYSHIELD_VARIATIONS;
	if (sItem == "tower")
	   nBaseVariations = TOWERSHIELD_VARIATIONS;
	if (sItem == "bastardsword")
	   nBaseVariations = BASTARDSWORD_VARIATIONS;
	if (sItem == "battleaxe")
	   nBaseVariations = BATTLEAXE_VARIATIONS;
	if (sItem == "club")
	   nBaseVariations = CLUB_VARIATIONS;
	if (sItem == "dagger")
	   nBaseVariations = DAGGER_VARIATIONS;
	if (sItem == "dwarvenwaraxe")
	   nBaseVariations = DWARVENWARAXE_VARIATIONS;
	if (sItem == "falchion")
	   nBaseVariations = FALCHION_VARIATIONS;
	if (sItem == "greataxe")
	   nBaseVariations = GREATAXE_VARIATIONS;
	if (sItem == "greatsword")
	   nBaseVariations = GREATSWORD_VARIATIONS;
	if (sItem == "halberd")
	   nBaseVariations = HALBERD_VARIATIONS;
	if (sItem == "handaxe")
	   nBaseVariations = HANDAXE_VARIATIONS;
	if (sItem == "heavycrossbow")
	   nBaseVariations = HEAVYCROSSBOW_VARIATIONS;
	if (sItem == "kama")
	   nBaseVariations = KAMA_VARIATIONS;
	if (sItem == "katana")
	   nBaseVariations = KATANA_VARIATIONS;
	if (sItem == "kukri")
	   nBaseVariations = KUKRI_VARIATIONS;
	if (sItem == "lightcrossbow")
	   nBaseVariations = LIGHTCROSSBOW_VARIATIONS;
	if (sItem == "lightflail")
	   nBaseVariations = LIGHTFLAIL_VARIATIONS;
	if (sItem == "lighthammer")
	   nBaseVariations = LIGHTHAMMER_VARIATIONS;
	if (sItem == "longbow")
	   nBaseVariations = LONGBOW_VARIATIONS;
	if (sItem == "longsword")
	   nBaseVariations = LONGSWORD_VARIATIONS;
	if (sItem == "mace")
	   nBaseVariations = MACE_VARIATIONS;
	if (sItem == "morningstar")
	   nBaseVariations = MORNINGSTAR_VARIATIONS;
	if (sItem == "quarterstaff")
	   nBaseVariations = QUARTERSTAFF_VARIATIONS;
	if (sItem == "rapier")
	   nBaseVariations = RAPIER_VARIATIONS;
	if (sItem == "scimitar")
	   nBaseVariations = SCIMITAR_VARIATIONS;
	if (sItem == "scythe")
	   nBaseVariations = SCYTHE_VARIATIONS;
	if (sItem == "shortbow")
	   nBaseVariations = SHORTBOW_VARIATIONS;
	if (sItem == "shortsword")
	   nBaseVariations = SHORTSWORD_VARIATIONS;
	if (sItem == "sickle")
	   nBaseVariations = SICKLE_VARIATIONS;
	if (sItem == "spear")
	   nBaseVariations = SPEAR_VARIATIONS;
	if (sItem == "warhammer")
	   nBaseVariations = WARHAMMER_VARIATIONS;
	if (sItem == "warmace")
	   nBaseVariations = WARMACE_VARIATIONS;

	return nBaseVariations;
}
// get the variable for displaying the current appearance number
int mda_GetGUILocalVariableNum(string sItem)
{
	int nGUILocalVariableNum;

	if (sItem == "helm")
	   nGUILocalVariableNum = 10;
	if (sItem == "cloak")
	   nGUILocalVariableNum = 11;
	if (sItem == "armor")
	   nGUILocalVariableNum = 12;
	if (sItem == "gloves")
	   nGUILocalVariableNum = 13;
	if (sItem == "righthand")
	   nGUILocalVariableNum = 14;
	if (sItem == "lefthand")
	   nGUILocalVariableNum = 15;
	if (sItem == "boots")
	   nGUILocalVariableNum = 16;

	return nGUILocalVariableNum;
}


// we can charge different prices for helm, cloak and armor changes
// we can also set a flat fee, or charge a percentage of the value of
// the item. We use the original item to get the value as it may have properties
// on it that effects the value.
// we can change the appearance of multiple objects so the script takes that into
// account.

int mda_GetAppearanceChangeCost(object oPC)
{
	int nHelmChanged = GetLocalInt(oPC,"Helm_TryingNew");
	int nCloakChanged = GetLocalInt(oPC,"Cloak_TryingNew");
	int nBootsChanged = GetLocalInt(oPC,"Boots_TryingNew");
	int nGlovesChanged = GetLocalInt(oPC,"Gloves_TryingNew");	
	int nArmorChanged = GetLocalInt(oPC,"Armor_TryingNew");
	int nRightHandChanged = GetLocalInt(oPC,"RightHand_TryingNew");
	int nLeftHandChanged = GetLocalInt(oPC,"LeftHand_TryingNew");
	
	int nHelmValue = GetLocalInt(oPC,"PC_Helm_Value");
	int nCloakValue = GetLocalInt(oPC,"PC_Cloak_Value");
	int nBootsValue = GetLocalInt(oPC,"PC_Boots_Value");
	int nGlovesValue = GetLocalInt(oPC,"PC_Gloves_Value");	
	int nArmorValue = GetLocalInt(oPC,"PC_Armor_Value");
	int nRightHandValue = GetLocalInt(oPC,"PC_RightHand_Value");
	int nLeftHandValue = GetLocalInt(oPC,"PC_LeftHand_Value");
	
	int nHelmChangeCost;
	int nCloakChangeCost;
	int nBootsChangeCost;
	int nGlovesChangeCost;
	int nArmorChangeCost;
	int nRightHandCost;
	int nLeftHandCost;
	int nCost;
	
	if (nHelmChanged)
		nHelmChangeCost = FloatToInt(HELM_PERCENTAGE_CHARGE / 100 * nHelmValue ) + HELM_FLAT_FEE;
	else
		nHelmChangeCost = 0;
	
	if (nCloakChanged)
		nCloakChangeCost = FloatToInt(CLOAK_PERCENTAGE_CHARGE / 100 * nCloakValue ) + CLOAK_FLAT_FEE;
	else
		nCloakChangeCost = 0;
	
	if (nBootsChanged)
		nBootsChangeCost = FloatToInt(BOOTS_PERCENTAGE_CHARGE / 100 * nBootsValue ) + BOOTS_FLAT_FEE;
	else
		nBootsChangeCost = 0;
	
	if (nGlovesChanged)
		nGlovesChangeCost = FloatToInt(GLOVES_PERCENTAGE_CHARGE / 100 * nGlovesValue ) + GLOVES_FLAT_FEE;
	else
		nGlovesChangeCost = 0;
		
	if (nArmorChanged)	
		nArmorChangeCost = FloatToInt(ARMOR_PERCENTAGE_CHARGE * nArmorValue ) / 100 + ARMOR_FLAT_FEE;
	else
		nArmorChangeCost = 0;

	if (nRightHandChanged)
		nRightHandCost = FloatToInt(RIGHTHAND_PERCENTAGE_CHARGE * nRightHandValue ) / 100 + RIGHTHAND_FLAT_FEE;
	else
		nRightHandCost = 0;
			
	if (nLeftHandChanged)
		nLeftHandCost = FloatToInt(LEFTHAND_PERCENTAGE_CHARGE / 100 * nLeftHandValue ) + LEFTHAND_FLAT_FEE;
	else
		nLeftHandCost = 0;
		
	nCost = nHelmChangeCost + nCloakChangeCost + nBootsChangeCost + nGlovesChangeCost;
	nCost = nCost + nArmorChangeCost + nRightHandCost + nLeftHandCost;
	
	return nCost;
}
// put properties of the old item onto the new appearance
void mda_ApplyExistingPropertiesToNewObject(object oPCOriginalItem,object oPCNewItem)
{
	string sName = GetName(oPCOriginalItem);
	string sDescription = GetDescription(oPCOriginalItem);
	int    nMaterial = GetItemBaseMaterialType(oPCOriginalItem);
	
	SetFirstName(oPCNewItem,sName);
	SetDescription(oPCNewItem,sDescription);
	SetItemBaseMaterialType(oPCNewItem, nMaterial);
	
	itemproperty ipExistingProperty = GetFirstItemProperty(oPCOriginalItem);
	
	while(GetIsItemPropertyValid(ipExistingProperty))
	{
		// we only transfer permanent duration type so people can't put spells on items
		// then make them permanenet by changing the item appearance
		if (GetItemPropertyDurationType(ipExistingProperty) == DURATION_TYPE_PERMANENT)
			AddItemProperty(DURATION_TYPE_PERMANENT,ipExistingProperty,oPCNewItem);
		ipExistingProperty = GetNextItemProperty(oPCOriginalItem);
	}

}
// Update the GUI
void mda_UpdateGUIState(object oPC)
{
	int nHelmChanged = GetLocalInt(oPC,"Helm_TryingNew");
	int nCloakChanged = GetLocalInt(oPC,"Cloak_TryingNew");
	int nBootsChanged = GetLocalInt(oPC,"Boots_TryingNew");
	int nGlovesChanged = GetLocalInt(oPC,"Gloves_TryingNew");	
	int nArmorChanged = GetLocalInt(oPC,"Armor_TryingNew");
	int nRightHandChanged = GetLocalInt(oPC,"RightHand_TryingNew");
	int nLeftHandChanged = GetLocalInt(oPC,"LeftHand_TryingNew");
	int nPCsGold = GetGold(oPC);
	int nCost = mda_GetAppearanceChangeCost(oPC);



	if (nHelmChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","HELM_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","HELM_CANCEL",TRUE);

	if (nCloakChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","CLOAK_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","CLOAK_CANCEL",TRUE);
		
	if (nBootsChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","BOOTS_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","BOOTS_CANCEL",TRUE);

	if (nGlovesChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","GLOVES_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","GLOVES_CANCEL",TRUE);
		
	if (nArmorChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","ARMOR_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","ARMOR_CANCEL",TRUE);

	if (nRightHandChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","RIGHTHAND_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","RIGHTHAND_CANCEL",TRUE);
		
	if (nLeftHandChanged)
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","LEFTHAND_CANCEL",FALSE);
	else
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","LEFTHAND_CANCEL",TRUE);
		
						
	if (nHelmChanged || nCloakChanged ||
		nBootsChanged || nGlovesChanged ||
		nArmorChanged || nRightHandChanged || nLeftHandChanged
	    )
		SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",1,IntToString(nCost));	
		
	if (! nHelmChanged && ! nCloakChanged && 
		! nBootsChanged && ! nGlovesChanged && 
		! nArmorChanged && ! nRightHandChanged && ! nLeftHandChanged
		)
	{
		// no change
		SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",1,"0");
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","MDA_MAKE_CHANGE",TRUE);
		SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",4,"Choose the changes you'd like");	
	}
	else if (nCost >= 0)
	{
		if ((nCost > nPCsGold) && (!GetIsDM(oPC)) && (!GetIsDMPossessed(oPC)))
		{
			// can't afford it
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","MDA_MAKE_CHANGE",TRUE);
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",2,"You can't afford these changes");
		}
		else
		{
			// ready to make change
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","MDA_MAKE_CHANGE",FALSE);
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",2,"Make changes to the item");	
		}
	}
	else
	{
		// cost overflow
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","MDA_MAKE_CHANGE",TRUE);
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",2,"Item value too high. Please remove some properties.");		
	}


}

// get the base type item in left or right hand - is it a shield or weapon
// needed as a string

string mda_GetItemInHand(object oItem)
{
	int nBaseItemType = GetBaseItemType(oItem);
	string sBaseItemType;
	
	switch (nBaseItemType)
	{
		case BASE_ITEM_SMALLSHIELD: sBaseItemType = "light";break;
		case BASE_ITEM_LARGESHIELD: sBaseItemType = "heavy";break;
		case BASE_ITEM_TOWERSHIELD: sBaseItemType = "tower";break;
		case BASE_ITEM_BASTARDSWORD: sBaseItemType = "bastardsword";break;
		case BASE_ITEM_BATTLEAXE: sBaseItemType = "battleaxe";break;
		case BASE_ITEM_CLUB: sBaseItemType = "club";break;
		case BASE_ITEM_DAGGER: sBaseItemType = "dagger";break;
		case BASE_ITEM_DWARVENWARAXE: sBaseItemType = "dwarvenwaraxe";break;
		case BASE_ITEM_FALCHION: sBaseItemType = "falchion";break;
		case BASE_ITEM_GREATAXE: sBaseItemType = "greataxe";break;
		case BASE_ITEM_GREATSWORD: sBaseItemType = "greatsword";break;
		case BASE_ITEM_HALBERD: sBaseItemType = "halberd";break;
		case BASE_ITEM_HANDAXE: sBaseItemType = "handaxe";break;
		case BASE_ITEM_HEAVYCROSSBOW: sBaseItemType = "heavycrossbow";break;
		case BASE_ITEM_KAMA: sBaseItemType = "kama";break;
		case BASE_ITEM_KATANA: sBaseItemType = "katana";break;
		case BASE_ITEM_KUKRI: sBaseItemType = "kukri";break;
		case BASE_ITEM_LIGHTCROSSBOW: sBaseItemType = "lightcrossbow";break;
		case BASE_ITEM_LIGHTFLAIL: sBaseItemType = "lightflail";break;
		case BASE_ITEM_LIGHTHAMMER: sBaseItemType = "lighthammer";break;
		case BASE_ITEM_LONGBOW: sBaseItemType = "longbow";break;
		case BASE_ITEM_LONGSWORD: sBaseItemType = "longsword";break;
		case BASE_ITEM_MACE: sBaseItemType = "mace";break;
		case BASE_ITEM_MORNINGSTAR: sBaseItemType = "morningstar";break;
		case BASE_ITEM_QUARTERSTAFF: sBaseItemType = "quarterstaff";break;
		case BASE_ITEM_RAPIER: sBaseItemType = "rapier";break;
		case BASE_ITEM_SCIMITAR: sBaseItemType = "scimitar";break;
		case BASE_ITEM_SCYTHE: sBaseItemType = "scythe";break;
		case BASE_ITEM_SHORTBOW: sBaseItemType = "shortbow";break;
		case BASE_ITEM_SHORTSWORD: sBaseItemType = "shortsword";break;
		case BASE_ITEM_SICKLE: sBaseItemType = "sickle";break;
		case BASE_ITEM_SPEAR: sBaseItemType = "spear";break;
		case BASE_ITEM_WARHAMMER: sBaseItemType = "warhammer";break;
		case BASE_ITEM_WARMACE: sBaseItemType = "warmace";break;

		default: sBaseItemType = "error";	
	}
	return sBaseItemType;
}
// Armor needs to be done in sections and be delayed a little to get the base armor type properly
void mda_SetupArmorStats(object oPC, object oTestArmor)
{
	string sArmorType = mda_GetBaseArmorType(oTestArmor, oPC); 
	SetLocalString(oPC,"BaseArmorType",sArmorType);
		
	if (sArmorType == "error")
	{
		FloatingTextStringOnCreature("vn_base: Error : Base armor value not found.",oPC,FALSE);
		SendMessageToPC(oPC,"vn_base: Error : Base armor value not found.");
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_ARMOR",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_ARMOR",TRUE);
	}
	else
	{	
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_ARMOR",FALSE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_ARMOR",FALSE);
	}
	DestroyObject(oTestArmor,10.0);

}
// Set up PC for item appearance modification
// we disable, or enable choices depending on what the PC is currently changing
// we need to set the original item as a local object on the PC
// we need to set the value of the original item for pricing
void mda_SetupAppearanceChanger(object oPC)
{
	// Get the items in the PC's slots
	object oPC_Helm = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
	object oPC_Cloak = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
	object oPC_Boots = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
	object oPC_Gloves = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
	object oPC_Armor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
	object oPC_RightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
	object oPC_LeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

	int nValue;
	// if there is a valid item in the slot, set is as a local object on the PC
	// get the value for later costing
	// enable the buttons for cycling through appearances
	
	if (GetIsObjectValid(oPC_Helm))
	{
		SetLocalObject(oPC,"PC_Helm",oPC_Helm);
		nValue = GetGoldPieceValue(oPC_Helm);
		SetLocalInt(oPC,"PC_Helm_Value",nValue);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_HELM",FALSE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_HELM",FALSE);
	}
	else
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_HELM",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_HELM",TRUE);
	}
	if (GetIsObjectValid(oPC_Cloak))
	{
		SetLocalObject(oPC,"PC_Cloak",oPC_Cloak);
		nValue = GetGoldPieceValue(oPC_Cloak);
		SetLocalInt(oPC,"PC_Cloak_Value",nValue);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_CLOAK",FALSE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_CLOAK",FALSE);		
	}
	else
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_CLOAK",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_CLOAK",TRUE);
	}
	if (GetIsObjectValid(oPC_Boots))
	{
		SetLocalObject(oPC,"PC_Boots",oPC_Boots);
		nValue = GetGoldPieceValue(oPC_Boots);
		SetLocalInt(oPC,"PC_Boots_Value",nValue);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_BOOTS",FALSE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_BOOTS",FALSE);
	}
	else
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_BOOTS",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_BOOTS",TRUE);
	}
	if (GetIsObjectValid(oPC_Gloves))
	{
		SetLocalObject(oPC,"PC_Gloves",oPC_Gloves);
		nValue = GetGoldPieceValue(oPC_Gloves);
		SetLocalInt(oPC,"PC_Gloves_Value",nValue);

		// might be gloves or bracers
		// Dan: 03Jul07
		int nBaseType = GetBaseItemType(oPC_Gloves);
		if (nBaseType == BASE_ITEM_BRACER)
		{
			SetLocalString(oPC,"mdaBaseItemOnArms", "bracer");
			// Bracer appearance can't change.
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_GLOVES",TRUE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_GLOVES",TRUE);		
		}
		else if (nBaseType == BASE_ITEM_GLOVES)
		{
			SetLocalString(oPC,"mdaBaseItemOnArms", "gloves");
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_GLOVES",FALSE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_GLOVES",FALSE);		
		}
		else 
		{ 
			// nothing is there that we can modify
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_GLOVES",TRUE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_GLOVES",TRUE);
		}
		
	}
	else
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_GLOVES",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_GLOVES",TRUE);
	}
	
	// For armor we need to find the type i.e. leather/cloth, so that we can offer
	// the right armor for appearance changing - this is worked out through the value
	// of the current armor (minus any properties) so it's important that the base items
	// used as appearance templates haven't had their values adjusted
	
	if (GetIsObjectValid(oPC_Armor))
	{
		SetLocalObject(oPC,"PC_Armor",oPC_Armor);	
		nValue = GetGoldPieceValue(oPC_Armor);
		SetLocalInt(oPC,"PC_Armor_Value",nValue);
		
		// need to copy the armor
		object oCheckChest = GetObjectByTag(CHECK_CHEST);
		object oTestArmor = CopyItem(oPC_Armor,oCheckChest);
		
		// strip any properties from the copy - they could change the AC and confuse us.
		itemproperty ip = GetFirstItemProperty(oTestArmor);
		while (GetIsItemPropertyValid(ip))
		{
			RemoveItemProperty(oTestArmor, ip);
			ip = GetNextItemProperty(oTestArmor);
		}

		DelayCommand(0.5,mda_SetupArmorStats(oPC, oTestArmor));

	}
	else // shouldn't be naked, but who know's!!!!
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_ARMOR",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_ARMOR",TRUE);
	}
	
	if (GetIsObjectValid(oPC_RightHand))
	{
		SetLocalObject(oPC,"PC_RightHand",oPC_RightHand);
		nValue = GetGoldPieceValue(oPC_RightHand);
		SetLocalInt(oPC,"PC_RightHand_Value",nValue);
		int nBaseType = GetBaseItemType(oPC_RightHand);
		string sBaseRightHand = mda_GetItemInHand(oPC_RightHand);
		if (sBaseRightHand == "error")
		{  // nothing is there that we can mod
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_RIGHTHAND",TRUE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_RIGHTHAND",TRUE);	
		}
		else
		{
			SetLocalString(oPC,"BaseRightHand",sBaseRightHand);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_RIGHTHAND",FALSE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_RIGHTHAND",FALSE);				
		}
				
	}
	else
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_RIGHTHAND",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_RIGHTHAND",TRUE);	
	}
	
	if (GetIsObjectValid(oPC_LeftHand))
	{
		SetLocalObject(oPC,"PC_LeftHand",oPC_LeftHand);
		nValue = GetGoldPieceValue(oPC_LeftHand);
		SetLocalInt(oPC,"PC_LeftHand_Value",nValue);
		int nBaseType = GetBaseItemType(oPC_LeftHand);
		string sBaseLeftHand = mda_GetItemInHand(oPC_LeftHand);
		if (sBaseLeftHand == "error")
		{ // nothing is there that we can mod
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_LEFTHAND",TRUE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_LEFTHAND",TRUE);		
		}
		else
		{		
			SetLocalString(oPC,"BaseLeftHand",sBaseLeftHand);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_LEFTHAND",FALSE);
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_LEFTHAND",FALSE);				
		}
				
	}
	else
	{
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","NEXT_LEFTHAND",TRUE);
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER","PREV_LEFTHAND",TRUE);	
	}	
	
}