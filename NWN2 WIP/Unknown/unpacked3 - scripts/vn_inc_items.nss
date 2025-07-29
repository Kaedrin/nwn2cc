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
//  Script Name: vn_inc_items
//  Description: Generic Functions for items
//------------------------------------------------------------------------------
#include "vn_inc_constants"

//------------------------------------------------------------------------------
//                     Definitions
//------------------------------------------------------------------------------
// GetILRByValue: Retern the level required to use an item of value iNewValue.
int GetILRByValue(int iNewValue);

// find the gold piece value of nCopies of the item specified by sItemResRef
int GetGoldPieceValueFromResRef(string sItemResRef, int nCopies);

// get the value of a single item even if in stack
float GetSingleItemGoldPieceValue(object oInventoryItem);

// GetRequiredLoreSkill: Retern the level required to id an item.
int GetRequiredLoreSkill(int nItemValue);

// Uses CHECK_CHEST to test if an item is stackable
// If the item is stackable, returns the max stack size
// if the item is not stackable returns 0 (FALSE)
int GetIsStackableItem(object oItem);

// give to oTarget nToGive of sResRef
void GiveStackable(string sResRef, object oTarget, int nToGive);

// void wrapper for CreateObject
void CreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="");

// CreateItemOnObjectVoid: Void wrapper for CreateItemOnObject so it can be used
// with DelayCommand()
void CreateItemOnObjectVoid(string sItemTemplate, object oTarget=OBJECT_SELF, int nStackSize=1);

// Destroy a container, and it's inventory 
// Use where destroy object leaves loot you don't want.
void DestroyObjectAndInventory(object oObject);

// Destroy an object, 
// even if set to undestroyable, 
// including its inventory,
// including its whole stack
void ForceDestroyObject(object oObject);

// take nGold from oTarget.
// return TRUE on success or FALSE on error (doesn't have enough gold)
int SurrenderGold(object oTarget, int nGold);

// Take nStackSize of sTag from oPC
// if bDestroy the items are destroyed, otherwise they are given to OBJECT_SELF
// on success return TRUE, on error (not enough) return FALSE
int SurrenderItem(object oPC, string sTag, int nStackSize = 1, int bDestroy = TRUE);

// Get the total number of items (including stacked items)
// possessed by oPC, matching sItemTag.
// don't use inside of Loop!!
int GetNumHeldItems(object oPC, string sItemTag);

// Find how many items of type in objects inventory
// if items are stacked it counts the number in the stack
// items can have the same tag when created by module, but still be different
// because they have been adjust by mda / mdp / fournoi treasure
// don't use inside of Loop!!
int GetNumItemsOfType(object oInventoryObject,string sSearchItemTag, string sSearchItemName);

// Finds num of items in an inventory
// Finds num unidentified items in inventory
// Can Identify Unidentified items
// Can return the num of Unidentified Items
// Default - return num of all items and doesn't identify
int CountAndIdentifyItems(object oInventoryObject, int bReturnNumUnidentifiedItems = FALSE, int bIdentify = FALSE);

// Find and return an object from oPC's inventory
// returns OBJECT_INVALID if no object has sTag
object GetItemInInventory(object oPC, string sTag);

void DebugShowItemProperty(itemproperty ip, object oPC);

// returns the number of properties on an item
int GetNumProperties(object oModifyItem);

// return the nNth property of oItem
itemproperty GetItemProperty(object oItem, int nNth = 1);

// Makes a string of the total IP names for GUI display
string GetItemPropertyName(object oModifyItem, int nPropNum);

// Get a description of an item from it's itemproperties
string GetItemDesc(object oItem);

//------------------------------------------------------------------------------
//                     Implementation
//------------------------------------------------------------------------------
// GetILRByValue: Retern the level required to use an item of value iNewValue.
int GetILRByValue(int iNewValue)
{
    if (iNewValue > 4000000) return 40;
    else if (iNewValue > 3800000) return 39;
    else if (iNewValue > 3600000) return 38;
    else if (iNewValue > 3400000) return 37;
    else if (iNewValue > 3200000) return 36;
    else if (iNewValue > 3000000) return 35;
    else if (iNewValue > 2800000) return 34;
    else if (iNewValue > 2600000) return 33;
    else if (iNewValue > 2400000) return 32;
    else if (iNewValue > 2200000) return 31;
    else if (iNewValue > 2000000) return 30;
    else if (iNewValue > 1800000) return 29;
    else if (iNewValue > 1600000) return 28;
    else if (iNewValue > 1400000) return 27;
    else if (iNewValue > 1200000) return 26;
    else if (iNewValue > 1000000) return 25;
    else if (iNewValue > 750000)  return 24;
    else if (iNewValue > 500000)  return 23;
    else if (iNewValue > 250000)  return 22;
    else if (iNewValue > 130000)  return 21;
    else if (iNewValue > 110000)  return 20;
    else if (iNewValue > 90000)   return 19;
    else if (iNewValue > 75000)   return 18;
    else if (iNewValue > 65000)   return 17;
    else if (iNewValue > 50000)   return 16;
    else if (iNewValue > 40000)   return 15;
    else if (iNewValue > 35000)   return 14;
    else if (iNewValue > 30000)   return 13;
    else if (iNewValue > 25000)   return 12;
    else if (iNewValue > 19500)   return 11;
    else if (iNewValue > 15000)   return 10;
    else if (iNewValue > 12000)   return 9;
    else if (iNewValue > 9000)    return 8;
    else if (iNewValue > 6500)    return 7;
    else if (iNewValue > 5000)    return 6;
    else if (iNewValue > 3500)    return 5;
    else if (iNewValue > 2500)    return 4;
    else if (iNewValue > 1500)    return 3;
    else if (iNewValue > 1000)     return 2;
    else return 1;

} // GetILRByValue

// find the gold piece value of nCopies of the item specified by sItemResRef
int GetGoldPieceValueFromResRef(string sItemResRef, int nCopies)
{
    // get the check chest
    object oCheckChest = GetObjectByTag(CHECK_CHEST);

    // make a copy of the item
    object oItem = CreateItemOnObject(sItemResRef, oCheckChest);

    // Get the value of one of the item
    int nGoldPieceValue = GetGoldPieceValue(oItem);

    // Multiply by nCopies
    nGoldPieceValue *= nCopies;

    return nGoldPieceValue;
}

// get the value of a single item even if in stack
float GetSingleItemGoldPieceValue(object oInventoryItem)
{
	float fItemValue = 0.0;
	// only returning the value of 1 item in stack - for stacks of base ammo returning 0
	// if the value is 0 will have to check it it's a stack item like base ammo and work
	// cost from baseitems.2da
		
	int nItemValue = GetGoldPieceValue(oInventoryItem);
	int nStackSize = GetItemStackSize(oInventoryItem);
	if (nStackSize > 1)
		nItemValue = nItemValue/nStackSize;

	if (nItemValue < 1)
	{
		int nBaseItemType = GetBaseItemType(oInventoryItem);
		float fBaseCost = StringToFloat(Get2DAString("baseitems","BaseCost",nBaseItemType));
		float fStackSize = StringToFloat(Get2DAString("baseitems","Stacking",nBaseItemType)); 		
		fItemValue = fBaseCost / fStackSize;
	}
	else
		fItemValue = IntToFloat(nItemValue);
		

	return fItemValue;
}

// GetRequiredLoreSkill: Retern the level required to id an item.
int GetRequiredLoreSkill(int nItemValue)
{
    if (nItemValue<=  5 )return 0 ;
    else if (nItemValue<=  10 )return 1 ;
    else if (nItemValue<=  50 )return 2 ;
    else if (nItemValue<=  100 )return 3 ;
    else if (nItemValue<=  150 )return 4 ;
    else if (nItemValue<=  200 )return 5 ;
    else if (nItemValue<=  300 )return 6 ;
    else if (nItemValue<=  400 )return 7 ;
    else if (nItemValue<=  500 )return 8 ;
    else if (nItemValue<=  1000 )return 9 ;
    else if (nItemValue<=  2500 )return 10 ;
    else if (nItemValue<=  3750 )return 11 ;
    else if (nItemValue<=  4800 )return 12 ;
    else if (nItemValue<=  6500 )return 13 ;
    else if (nItemValue<=  9500 )return 14 ;
    else if (nItemValue<=  13000 )return 15 ;
    else if (nItemValue<=  17000 )return 16 ;
    else if (nItemValue<=  20000 )return 17 ;
    else if (nItemValue<=  30000 )return 18 ;
    else if (nItemValue<=  40000 )return 19 ;
    else if (nItemValue<=  50000 )return 20 ;
    else if (nItemValue<=  60000 )return 21 ;
    else if (nItemValue<=  80000 )return 22 ;
    else if (nItemValue<=  100000 )return 23 ;
    else if (nItemValue<=  150000 )return 24 ;
    else if (nItemValue<=  200000 )return 25 ;
    else if (nItemValue<=  250000 )return 26 ;
    else if (nItemValue<=  300000 )return 27 ;
    else if (nItemValue<=  350000 )return 28 ;
    else if (nItemValue<=  400000 )return 29 ;
    else if (nItemValue<=  500000 )return 30 ;
    else if (nItemValue<=  600000 )return 31 ;
    else if (nItemValue<=  700000 )return 32 ;
    else if (nItemValue<=  800000 )return 33 ;
    else if (nItemValue<=  900000 )return 34 ;
    else if (nItemValue<=  1000000 )return 35 ;
    else if (nItemValue<=  1100000 )return 36 ;
    else if (nItemValue<=  1200000 )return 37 ;
    else if (nItemValue<=  1300000 )return 38 ;
    else if (nItemValue<=  1400000 )return 39 ;
    else if (nItemValue<=  1500000 )return 40 ;
    else if (nItemValue<=  1600000 )return 41 ;
    else if (nItemValue<=  1700000 )return 42 ;
    else if (nItemValue<=  1800000 )return 43 ;
    else if (nItemValue<=  1900000 )return 44 ;
    else if (nItemValue<=  2000000 )return 45 ;
    else if (nItemValue<=  2100000 )return 46 ;
    else if (nItemValue<=  2200000 )return 47 ;
    else if (nItemValue<=  2300000 )return 48 ;
    else if (nItemValue<=  2400000 )return 49 ;
    else if (nItemValue<=  2500000 )return 50 ;
    else if (nItemValue<=  2600000 )return 51 ;
    else if (nItemValue<=  3000000 )return 52 ;
    else if (nItemValue<=  5000000 )return 53 ;
    else if (nItemValue<=  6000000 )return 54 ;
    else if (nItemValue<=  9000000 )return 55 ;
    else if (nItemValue<=  12000000 )return 56 ;
    else return 57;

} // GetRequiredLoreSkill

int GetIsStackableItem(object oItem)
// changed to use 2DA
// if the item is not stackable returns 0 (FALSE)
{
	int bStack;
	int nBaseItemType = GetBaseItemType(oItem);
	int nStackSize = StringToInt(Get2DAString("baseitems","Stacking",nBaseItemType)); 

    // If the stack size is 1, set it to 0 (FALSE)
    if (nStackSize == 1) 
		bStack = 0;
	else
		bStack = nStackSize;

    // Return bStack which is TRUE if item is stackable
    return bStack;
}

void GiveStackable(string sResRef, object oTarget, int nToGive)
{

    int nGiven = 0;
    object oStack;
    for (nGiven = 0; nGiven < nToGive; nGiven++)
    {
        CreateItemOnObject(sResRef, oTarget, 1);
    }


}// give stackable

void CreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="")
// void wrapper for CreateObject
{
    CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);
}

// CreateItemOnObjectVoid: Void wrapper for CreateItemOnObject so it can be used
// with DelayCommand()
void CreateItemOnObjectVoid(string sItemTemplate, object oTarget=OBJECT_SELF, int nStackSize=1)
{
    CreateItemOnObject(sItemTemplate, oTarget, nStackSize);
}

// Use where destroy object leaves loot you don't want.
void DestroyObjectAndInventory(object oObject)
{
	if (GetHasInventory(oObject))
	{
		object oItem = GetFirstItemInInventory(oObject);
		while (GetIsObjectValid(oItem))
		{
			// SendMessageToPC(GetFirstPC(), "destroyed " + GetName(oItem));
			ForceDestroyObject(oItem);
			oItem = GetNextItemInInventory(oObject);
		}
	}
	
	// don't use ForceDestroyObject here, or you will create an infinite loop
	DestroyObject (oObject);
}


// Destroy an object, 
// even if set to undestroyable, 
// including its inventory,
// including its whole stack
void ForceDestroyObject(object oObject)
{
	AssignCommand(oObject, SetIsDestroyable(TRUE));
	SetItemStackSize(oObject, 1);
	DestroyObjectAndInventory (oObject);
}

int SurrenderGold(object oTarget, int nGold)
// take nGold from oTarget.
// return TRUE on success or FALSE on error (doesn't have enough gold)
{
    int nPCGold = GetGold(oTarget);
    if (nGold <= nPCGold)
    {
        TakeGoldFromCreature(nGold, oTarget, TRUE);
        return TRUE;
    }
    return FALSE;
}

int SurrenderItem(object oPC, string sTag, int nStackSize = 1, int bDestroy = TRUE)
// Take nStackSize of sTag from oPC
// if bDestroy the items are destroyed, otherwise they are given to OBJECT_SELF
// on success return TRUE, on error (not enough) return FALSE
{

    if (sTag == "") return TRUE; // surrender nothing
    if (nStackSize < 1) return TRUE; // surrender nothing

    // see how many of sTag oPC has
    int nItemsOnHand = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (oItem != OBJECT_INVALID)
    {
        if (GetTag(oItem) == sTag)
        {
            nItemsOnHand += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }//while: items

    // is it enough?
    if (nItemsOnHand < nStackSize) return FALSE;

    // take the items
    int nItemsInThisStack;
    int nToTake = nStackSize;
    object oCopy;
    oItem = GetFirstItemInInventory(oPC);
    while (oItem != OBJECT_INVALID && nToTake > 0)
    {
        if (sTag == GetTag(oItem))
        {
            nItemsInThisStack = GetNumStackedItems(oItem);
            if (nItemsInThisStack > nToTake)
            {
                SetItemStackSize(oItem, nItemsInThisStack - nToTake);
                if ( ! bDestroy)
                {
                    oCopy = CopyItem(oItem, OBJECT_SELF, TRUE);
                    SetItemStackSize(oCopy, nToTake);
                }
                nToTake = 0;
            } else {
                nToTake -= nItemsInThisStack;
                if (bDestroy)
                    DestroyObject(oItem);
                else
                    ActionTakeItem(oItem, oPC);
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }

    return TRUE;
}// surredner item


// Get the total number of items (including stacked items)
// possessed by oPC, matching sItemTag.
// don't use inside of Loop!!
int GetNumHeldItems(object oPC, string sItemTag)
{
    int nCopies = 0; // count of copies held
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == sItemTag)
        {
            nCopies += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return nCopies;
}


// Find how many items of type in objects inventory
// if items are stacked it counts the number in the stack
// items can have the same tag when created by module, but still be different
// because they have been adjust by mda / mdp / fournoi treasure
// don't use inside of Loop!!
int GetNumItemsOfType(object oInventoryObject,string sSearchItemTag, string sSearchItemName)
{
	int nNumItemsOfType;
	// cycles through containers inventory in object inventory automatically
	object oInventoryItem = GetFirstItemInInventory(oInventoryObject);

	
	while (GetIsObjectValid(oInventoryItem))
	{
		string sItemTag = GetTag(oInventoryItem);
		string sItemName = GetName(oInventoryItem);

		if (sItemTag == sSearchItemTag && sItemName == sSearchItemName)
		{
			nNumItemsOfType += GetNumStackedItems(oInventoryItem);
		}

		oInventoryItem = GetNextItemInInventory(oInventoryObject);
	}
	return nNumItemsOfType;
}

// Finds num of items in an inventory
// Finds num unidentified items in inventory
// Can Identify Unidentified items
// Can return the num of Unidentified Items
// Default - return num of all items and doesn't identify
int CountAndIdentifyItems(object oInventoryObject, int bReturnNumUnidentifiedItems = FALSE, int bIdentify = FALSE)
{
	int nNumItems = 0;
	int nItemsToIdentify = 0;

	// cycles through containers inventory in object inventory automatically
	object oInventoryItem = GetFirstItemInInventory(oInventoryObject);
	
	while (GetIsObjectValid(oInventoryItem))
	{
		if (!GetIdentified(oInventoryItem))
		{
	 		nItemsToIdentify++;
			SetIdentified(oInventoryItem,bIdentify);
		}

		nNumItems++;
		oInventoryItem = GetNextItemInInventory(oInventoryObject);
	}
	
	if (bReturnNumUnidentifiedItems)
		return nItemsToIdentify;
	else
		return nNumItems;
}


// Find and return an object from oPC's inventory
// returns OBJECT_INVALID if no object has sTag
object GetItemInInventory(object oPC, string sTag)
{
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == sTag) return oItem;
        oItem = GetNextItemInInventory(oPC);
    }
    return OBJECT_INVALID;
}

void DebugShowItemProperty(itemproperty ip, object oPC)
{
    int iPropType = GetItemPropertyType(ip);
    int iPropSubType = GetItemPropertySubType(ip);
    int iCostTableValue = GetItemPropertyCostTableValue(ip);

   // Debug("Type: " + IntToString(iPropType), oPC);
   // Debug("SubType: " + IntToString(iPropSubType), oPC);
   // Debug("CostTableValue: " + IntToString(iCostTableValue), oPC);

}

// returns the number of properties on an item
int GetNumProperties(object oModifyItem)
{
	int iTotalProperties;
	itemproperty ipPropertyList = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipPropertyList))
	{
		iTotalProperties++;
		ipPropertyList = GetNextItemProperty(oModifyItem);
	}
	return iTotalProperties;
}

// return the nNth property of oItem
itemproperty GetItemProperty(object oItem, int nNth = 1)
{
    if (nNth <1)
		return GetFirstItemProperty(OBJECT_INVALID);
	itemproperty ip = GetFirstItemProperty(oItem);
    int iCount = 1;

    while (iCount < nNth && GetIsItemPropertyValid(ip))
    {
        ip = GetNextItemProperty(oItem);
        iCount++;
    }

    return ip;
}

// Makes a string of the total IP names for GUI display
string GetItemPropertyName(object oModifyItem, int nPropNum)
{
	// See http://nwn.bioware.com/developers/Bioware_Aurora_Item_Format.pdf
	// PropertyName : Subtype [CostValue] [Param1: Param1Value]
	string sPropertyDescription;
	
	itemproperty ipPropertyList=GetItemProperty(oModifyItem,nPropNum);
	if (GetIsItemPropertyValid(ipPropertyList))
	{
		
		// Note: The above names are given to variables refering to parts of the
		// property description, i.e. PropertyName, Subtype, CostValue, Param1 &
		// Param1Value. 
		
		// The following suffixes are used:
		// 2da - for a variable containing the name of a 2da table
		// Index - for a variable containing a 2da row number
		// StrRef - for a variable refering to a row in dialog.tlk (talk table)
		
		/* PropertyName
		Look up the StrRef stored in column 0 (should be Name) of itempropdef.2da 
		(Table 5.2), at the row indexed by the ItemProperty Struct's PropertyName 
		Field (see Table 2.1.3). This StrRef points to the name of the Item 
		Property (eg., "Damage Bonus vs. Racial Type", "On Hit", "Light")
		*/
		int nPropertyNameIndex = GetItemPropertyType(ipPropertyList);
		string sPropertyNameStrRef = Get2DAString("itempropdef", "Name", nPropertyNameIndex);
		int nPropertyNameStrRef = StringToInt(sPropertyNameStrRef);
		string sPropertyName = GetStringByStrRef(nPropertyNameStrRef);
		sPropertyDescription = sPropertyName;
		
		/* Subtype
		In itempropdef.2da, look up the SubTypeResRef column value at the row 
		indexed by the ItemProperty Struct's PropertyName Field. If it is ****, 
		then there are no subtypes for this Item Property, so there is no subtype 
		portion of the Item Property description. Otherwise, the string under this 
		column is the ResRef of the subtype table 2da.
		
		If there is a subtype table, load it and use the ItemProperty Struct's 
		Subtype Field as an index into the 2da. Get the StrRef from the name column. 
		This StrRef points to the name of the Subtype (eg., "Dragon", "Daze").
		*/
		
		int nSubTypeIndex = GetItemPropertySubType(ipPropertyList);
		string sSubType2DA = Get2DAString("itempropdef", "SubTypeResRef", nPropertyNameIndex);
		
		if (sSubType2DA != "")
		{
			string sSubTypeStrRef = Get2DAString(sSubType2DA, "Name", nSubTypeIndex);
			int nSubTypeStrRef = StringToInt(sSubTypeStrRef);
			string sSubType = GetStringByStrRef(nSubTypeStrRef);
			sPropertyDescription += " : " + sSubType;
		}
		
		/* CostTable Value
		In itempropdef.2da, look up the CostTableResRef number at the row indexed 
		by the ItemProperty Struct's PropertyName Field. This should be the same as 
		the ItemProperty Struct's CostTable Field.
		
		Use the CostTableResRef value as an index into iprp_costtable.2da and get 
		the string under the Name column. This is the ResRef of the cost table 2da 
		to use.
		
		Load the cost table 2da. Using the ItemProperty Struct's CostValue Field 
		as an index into the cost table, get the Name column StrRef. This StrRef 
		points to the name of the Cost value 
		(eg., "1 Damage", "DC = 14", "Dim (5m)")
		*/
		
		int nCostTableIndex = GetItemPropertyCostTable(ipPropertyList);
		if (nCostTableIndex > 0) // 0 is invalid for a cost table index. It leads to iprp_base1.2da, which is empty.
		{
			string sCostTable2DA = Get2DAString("iprp_costtable", "Name", nCostTableIndex);
			
			int nCostTableValueIndex = GetItemPropertyCostTableValue(ipPropertyList);
			string sCostTableValueStrRef = Get2DAString(sCostTable2DA, "Name", nCostTableValueIndex);
			int nCostTableValueStrRef = StringToInt(sCostTableValueStrRef);
			string sCostTableValue = GetStringByStrRef(nCostTableValueStrRef);
			
			sPropertyDescription += " " + sCostTableValue;
		}
		
		
		/* Param
		Get the ResRef of the Param Table.
		
		If the ItemProperty has a subtype table (see Section 4.3.2), then look for 
		a Param1ResRef column in the subtype table. This column contains the param 
		table index, and should be identical the Param1 Field of the ItemProperty 
		Struct.
		*/
		string sParam1Index = "";
		if (sSubType2DA != "")
		{
			sParam1Index = Get2DAString(sSubType2DA, "Param1ResRef", nSubTypeIndex);
		}
		
		/*
		If the ItemProperty does not have a subtype table, or the subtype table 
		does not have a Param1ResRef column, then look under the Param1ResRef 
		column in itempropdef.2da, and use that as the param table index. In this 
		case as well, the index should equal the Param1 Field of the ItemProperty 
		Struct.
		*/
		if (sParam1Index == "")
		{
			sParam1Index = Get2DAString("itempropdef", "Param1ResRef", nPropertyNameIndex);
		}
		
		if (sParam1Index != "")
		{
			/*
			Use the param table index as an index into iprp_paramtable.2da. Look under 
			the Name column for a StrRef, and look under the TableResRef column for a 
			string. The Name StrRef points to the text for the name of the parameter 
			(eg., "Type", "Duration", "Color"). The TableResRef string is the ResRef 
			of the param table 2da.
			*/
			int nParam1Index = StringToInt(sParam1Index); // == GetItemPropertyParam1(ipPropertyList);
			string sParam1StrRef = Get2DAString("iprp_paramtable", "Name", nParam1Index);
			int nParam1StrRef = StringToInt(sParam1StrRef);
			string sParam1 = GetStringByStrRef(nParam1StrRef);
			string sParam1Value2DA = Get2DAString("iprp_paramtable", "TableResRef", nParam1Index);
		
			/*
			Use the ItemProperty Struct's Param1Value as an index into the param table 
			found above, and get the StrRef under the "Name" column. This StrRef points 
			to the name of the param value (eg., "Acid", "50% / 2 Rounds", "Red")
			*/
			int nParam1ValueIndex = GetItemPropertyParam1Value(ipPropertyList);
			string sParam1ValueStrRef = Get2DAString(sParam1Value2DA, "Name", nParam1ValueIndex);
			int nParam1ValueStrRef = StringToInt(sParam1ValueStrRef);
			string sParam1Value = GetStringByStrRef(nParam1ValueStrRef);
			
			sPropertyDescription += " " + sParam1 + ": " + sParam1Value;
		
		}// if there is a Param1
		
	}
	return sPropertyDescription;
}//GetItemPropertyName

// Get a description of an item from it's itemproperties
string GetItemDesc(object oItem)
{
	string sDesc;
	string sPropDesc = "";
	string sPropDivider = " \n";
	int nPropCount = 1;
	itemproperty ipPropertyTest = GetFirstItemProperty(oItem);

	if (! GetIsItemPropertyValid(ipPropertyTest))
		sDesc = GetName(oItem);
	else
	{
		while (GetIsItemPropertyValid(ipPropertyTest))
		{	
			sPropDesc += sPropDivider;
			sPropDesc += GetItemPropertyName(oItem, nPropCount);
			
			ipPropertyTest = GetNextItemProperty(oItem);
			nPropCount++;
		}
	
		sDesc = GetName(oItem) + sPropDesc;	
	}
	return sDesc;
}