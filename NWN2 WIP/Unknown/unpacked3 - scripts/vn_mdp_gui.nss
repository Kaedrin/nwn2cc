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
//  Script Name: vn_mdp_gui
//  Description: GUI Screen update functions for the property modifier system
//		Please DO NOT modify these functions. These functions are responsible
//      for the correct appearance of property names on the GUI and correct
//      GUI button selections.  These functions DO NOT effect what properties
//      are valid or allowed in the module, but if changed will cause the GUI
//      to work incorrectly or NOT AT ALL.
//------------------------------------------------------------------------------

#include "vn_mdp__inc"
#include "vn_mdp_check_allow"

//-------------------------  DECLARATIONS  -------------------------------------


// On compleation of the item property selection, apply the new property
// to the tempory item.
void mdp_IMS_DoSelectionFinish(object oPC, object oModifyItem);

// Hide all the item modifier property selection buttons
void mdp_IMS_ClearButtons(object oPC);

//-----------------------  IMPLEMENTAION  --------------------------------------

void mdpUpdateGUIStateItemInformation (object oPC)
{
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");

	// copies of the original item were taken before the GUI is opened.
	// This is used for all information on the GUI so that it can update
	// correctly.
		
	
	int nModifiedValue = GetGoldPieceValue(oModifyItem); 
	int nRemovalValue = GetGoldPieceValue(oRemovalModifyItem);
	int nOriginalValue = GetGoldPieceValue(oOriginalItem);
	int nPCsGold = GetGold(oPC);
	int nILR = GetILRByValue(nModifiedValue);
	int nModCost = VerifyModificationCost(oPC);
	int nChanged = GetLocalInt(oPC,"ITEM_CHANGED");
	int nCharges = GetItemCharges(oModifyItem);
	string sCharges = "Current Charges : " + IntToString(nCharges);
	string sProperty;

	Debug("Original value is : "+IntToString(nOriginalValue),MDP,3);		   
	Debug("Modified value is : "+IntToString(nModifiedValue),MDP,3);
	Debug("Removal value is : "+IntToString(nRemovalValue),MDP,3);
	
	SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",2,IntToString(nILR));
	SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",3,IntToString(nModCost));
	SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",5,sCharges);

	
	SetGUIObjectHidden(oPC,"SCREEN_VN_ITEM_PROPERTIES","BTN_MDP_RECHARGE_HALF",FALSE);
	SetGUIObjectHidden(oPC,"SCREEN_VN_ITEM_PROPERTIES","BTN_MDP_RECHARGE_FULL",FALSE);
	
	if (nChanged == FALSE )
	{
		// no change
		SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_PROPERTIES","BTN_MDP_MAKE_CHANGE",TRUE);
		SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",4,"Choose the changes you'd like");	
	}
	else if (nModCost >= 0)
	{
		if ((nModCost > nPCsGold) && (!GetIsDM(oPC)) && (!GetIsDMPossessed(oPC)) && (!MDP_FOR_FREE))		// Single Line Edit
		{
			// can't afford it
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_PROPERTIES","BTN_MDP_MAKE_CHANGE",TRUE);
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",4,"You can't afford these changes");
		}
		else
		{
			// ready to make change
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_PROPERTIES","BTN_MDP_MAKE_CHANGE",FALSE);
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",4,"Make changes to the item");	
		}
	}
	else
	{
		// cost overflow
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",3,"Item Value Limit Exceeded");
			SetGUIObjectDisabled(oPC,"SCREEN_VN_ITEM_PROPERTIES","BTN_MDP_MAKE_CHANGE",TRUE);
			SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_PROPERTIES",4,"Item value too high. Please remove some properties.");		
	}
	// list box info
	string sScreenName = "SCREEN_VN_ITEM_PROPERTIES";
	string sListBox = "MDP_PROPERTY_LIST";
	string sRowName = "";
	string sTextFields = "";
	string sTextures = "";
	string sVariables = "";
	string sHideUnHide = "";
	// empty any existing list
	ClearListBox(oPC,sScreenName,sListBox);

	int iTotalProperties = GetNumProperties(oModifyItem);// so we only try and get prop names for props that exist
	int iPropNum = 1;
	while (iPropNum <= iTotalProperties)
	{
		sRowName = GetItemPropertyName(oModifyItem,iPropNum);
		sTextFields = "TXT_REMOVE_BTN=Remove;TXT_PROPERTY_1="+sRowName;
		AddListBoxRow( oPC, sScreenName, sListBox, sRowName, sTextFields, sTextures, sVariables, sHideUnHide);
		iPropNum++;
	}
}	

//------------------------------------------------------------------------------
//         mdp_IMS: MoDify Property Item Modification Selection ( The Buttons )
//------------------------------------------------------------------------------




// Hide all the item modifier property selection buttons
void mdp_IMS_GenerateButtons(object oPC, object oModifyItem, string s2DA, string sColumn)
{

	// list box info
	string sScreenName = "SCREEN_VN_ITEM_MODIFICATIONS";
	string sListBox = "MDP_ADD_PROPERTY_LIST";
	string sRowName = "";
	string sTextFields = "";
	string sTextures = "";
	string sVariables = "";
	string sHideUnHide = "";
// clear old properties available list
	ClearListBox(oPC,sScreenName,sListBox);
	string sEntry;
	int nGUIRowNum = 0; 
	int n2DARowNumber;
	int nIndex;
	string sButtonText;
	s2DA = GetStringLowerCase(s2DA);
	int nMax2DARowNum;
	int bValidRow = FALSE;
	if (s2DA == "iprp_spells")
		nMax2DARowNum = GetNum2DARows("vn_mdp_iprp_spells");
	else if (s2DA == "iprp_feats")
		nMax2DARowNum = GetNum2DARows("vn_mdp_iprp_feats");
	else
		nMax2DARowNum = GetNum2DARows(s2DA);
	
	for (n2DARowNumber = 0; n2DARowNumber < nMax2DARowNum; n2DARowNumber++)
	{
		// for non-modified 2DA's the 2DA row number is used to get all info needed. iprp_spells and
		// iprp_feats are long 2DA's and not in alphabetical order. To make it easier for PC's and the
		// script quicker we culled feats and spells of padding and deleted entries and then alphabetised
		// them. We want them to appear on the buttons in the order we have provided, but need to store them
		// against the order they appear in the original 2DA for all other information.
		if (s2DA == "iprp_spells")
		{
			nIndex = StringToInt(Get2DAString("vn_mdp_iprp_spells","Index",n2DARowNumber));
			bValidRow = TRUE;
		}
		else if (s2DA == "iprp_feats")
		{
			nIndex = StringToInt(Get2DAString("vn_mdp_iprp_feats","Index",n2DARowNumber));
			bValidRow = TRUE;
		}
		else
		{
			nIndex = n2DARowNumber;
			bValidRow = mdpGetIs2DARowValid(s2DA, n2DARowNumber);
		}

		if ( bValidRow && ModificationTypeAllowed(oModifyItem, oPC, s2DA, nIndex))
		{
			sEntry = Get2DAString(s2DA, sColumn, nIndex);
			sRowName = GetStringByStrRef(StringToInt(sEntry));
			sTextFields = "TXT_ADD_PROPERTY="+sRowName;
			AddListBoxRow( oPC, sScreenName, sListBox, sRowName, sTextFields, sTextures, sVariables, sHideUnHide);
			nGUIRowNum++;
			SetArrayInt(oPC, "ROW_PROPERTY_CHOICE_", nGUIRowNum, nIndex);
		}	
		
	} // for
	if (nGUIRowNum == 0)
	//hide error message
	{
		string sError = "This crafter can't add any properties to this type of item.";
		SetGUIObjectHidden(oPC,sScreenName,"ERROR_NO_PROPERTIES",FALSE);
		SetGUIObjectText(oPC,sScreenName,"ERROR_NO_PROPERTIES",-1,sError);
	}

} // mdp_IMS_GenerateButtons


// Set up the itemmodifier property selection buttons, dynamicly from 
// local data tables and state information on the PC.
// If the selection process is finished, apply the property and reset.
void mdp_IMS_ResetButtons(object oPC, object oModifyItem)
{
	int nSelectionLevel = GetLocalInt(oPC, "MDP_SelectionLevel");
	int nTableLevel = GetLocalInt(oPC, "MDP_IMS_TableLevel");

	// Cancel Button
	if (nSelectionLevel > 0)
			SetGUIObjectHidden(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "BTN_PROPERTY_CANCEL", FALSE);
		else
			SetGUIObjectHidden(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "BTN_PROPERTY_CANCEL", TRUE);	
				
	if (nSelectionLevel > 0)
	{
		SetGUIObjectHidden(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "BTN_PROPERTY_UP", FALSE);
		SetGUIObjectDisabled(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "BTN_PROPERTY_UP", FALSE);
	}
	else
	{
		SetGUIObjectHidden(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "BTN_PROPERTY_UP", TRUE);
		SetGUIObjectDisabled(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "BTN_PROPERTY_UP", TRUE);
	}	
	
	// PropertyName : Subtype [CostValue] [Param1: Param1Value]
	// Note: The above names are given to variables refering to parts of the 
	// property description, i.e. PropertyName, Subtype, CostValue, Param1 &
	// Param1Value. 
	
	// The following suffixes are used:
	// 2da - for a variable containing the name of a 2da table
	// Index - for a variable containing a 2da row number
	// StrRef - for a variable refering to a row in dialog.tlk (talk table)	
	
	int nPropertyNameIndex; // index for itempropdef.2da, == GetItemPropertyType()
	string sSubType2DA; // the 2da table the subtype is listed in
	int nSubTypeIndex; // index for <sSubType2DA>.2da, == GetItemPropertySubType()
	string sParam1Index; // index for iprp_paramtable.2da	
	int nParam1Index;
	string sParam1Value2DA; // name of the 2da table found in iprp_paramtable.2da. This is the table that lists possible Param1Values
	string sCostTableIndex; // index for iprp_costtable.2da (string)
	int nCostTableIndex;    // index for iprp_costtable.2da (int)
	string sCostValue2DA; // 2da listing the CostValue
	
	switch (nTableLevel)
	{
		case 0:
		{
			// PropertyName, the base property, 
			// (eg., "Damage Bonus vs. Racial Type", "On Hit", "Light")
			// This is the index to itempropdef.2da
			// This will be the same as the value returned by GetItemPropertyType()
			SetLocalString(oPC, "MDP_IMS_2DA", "itempropdef");
			mdp_IMS_GenerateButtons(oPC, oModifyItem, "itempropdef", "Name");
			break;
		}
		case 1:
		{
			// SubType (eg., "Dragon", "Daze")
			// The SubType is an index to the SubType 2DA.
			// The SubType 2DA is specified by the 'SubTypeResRef' column in itempropdef.2da
			// The SubType will be the same as the value returned by GetItemPropertySubType()

			nPropertyNameIndex = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 0);
			sSubType2DA = Get2DAString("itempropdef", "SubTypeResRef", nPropertyNameIndex);
			sSubType2DA = GetStringLowerCase(sSubType2DA);
			if (sSubType2DA != "" && sSubType2DA != "iprp_ammotype")
			{
				SetLocalString(oPC, "MDP_IMS_2DA", sSubType2DA);
				mdp_IMS_GenerateButtons(oPC, oModifyItem, sSubType2DA, "Name");
				SetLocalInt(oPC, "MDP_IMS_Previous_TableLevel", nTableLevel-1);
				SetLocalInt(oPC, "MDP_IMS_TableLevel", 1);
				break;
			}
		}
		case 2:
		{
			// CostValue (eg., "1 Damage", "DC = 14", "Dim (5m)")
			// This is the index to the CostTable 2DA
			// The CostTable 2DA is specified in iprp_costtable.2da, 
			// The index for iprp_costable.2da is specified by the 'CostTableResRef' in itempropdef.2da
			// The CostValue will be the same as the value returned by GetItemPropertyCostTableValue()
			nPropertyNameIndex = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 0);
			Debug(
				"vn_gui__inc: mdp_IMS_ResetButtons() - " + 
				"Level " + IntToString(nSelectionLevel) + 
				", nPropType = " + IntToString(nPropertyNameIndex)
				, MDP
				, 3
			);
			
			sCostTableIndex = Get2DAString("itempropdef", "CostTableResRef", nPropertyNameIndex);
			if (sCostTableIndex != "" && sCostTableIndex != "padding")
			{
				nCostTableIndex = StringToInt(sCostTableIndex);
				Debug("vn_gui__inc: nCostTableIndex " + IntToString(nCostTableIndex), MDP, 3);
				if (nCostTableIndex) // 0 is invalid for a cost table index. It leads to iprp_base1.2da, which is empty.
				{
					sCostValue2DA = GetStringLowerCase(Get2DAString("iprp_costtable", "Name", nCostTableIndex)); // the name of the 2DA containing the next sub prorperty
					
					SetLocalString(oPC, "MDP_IMS_2DA", sCostValue2DA);
					mdp_IMS_GenerateButtons(oPC, oModifyItem, sCostValue2DA, "Name");
					SetLocalInt(oPC, "MDP_IMS_Previous_TableLevel", nTableLevel-1);
					SetLocalInt(oPC, "MDP_IMS_TableLevel", 2);
					break;
				}
			}
		}
		case 3:
		{
			// Param1Value, (eg., "Acid", "50% / 2 Rounds", "Red")
			// This will be the same as the value returned by GetItemPropertyParam1Value
			// This is an index into a Param1 2DA
			// The Param1 2DA is specified in iprp_paramtable.2da
			// There are two possible ways to get an index to the Param1 2DA, 
			//   this case deals with the first.
			// The Param1 Index may be specified as "Param1ResRef" in the SubType 2DA, as found in case 1
			
			nPropertyNameIndex = GetArrayInt(oPC, "MDP_PropertySelectionIndex",0);
			nSubTypeIndex = GetArrayInt(oPC,"MDP_PropertySelectionIndex",1);
			sSubType2DA = Get2DAString("itempropdef", "SubTypeResRef", nPropertyNameIndex);
			if (sSubType2DA != "")
			{
				sParam1Index = Get2DAString(sSubType2DA,"Param1ResRef",nSubTypeIndex);
				if (sParam1Index != "")
				{
					sParam1Value2DA = GetStringLowerCase(Get2DAString("iprp_paramtable","TableResRef",StringToInt(sParam1Index)));			

					SetLocalString(oPC, "MDP_IMS_2DA", sParam1Value2DA);
			
					mdp_IMS_GenerateButtons(oPC,oModifyItem,sParam1Value2DA,"Name");
					SetLocalInt(oPC, "MDP_IMS_Previous_TableLevel", nTableLevel-1);
					SetLocalInt(oPC,"MDP_IMS_TableLevel",3);
					break;
				}
			}
		}	
		case 4:
		{
			// Param1Value, as above in case 3, exept this time we are looking for
			// an index specified in itempropdef.2da in the column 'Param1ResRef'
			
			nPropertyNameIndex = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 0);
			sParam1Index = Get2DAString("itempropdef", "Param1ResRef", nPropertyNameIndex);
			if (sParam1Index != "" && sParam1Index != "padding")
			{
				nParam1Index = StringToInt(sParam1Index);
				Debug("vn_gui__inc: nParamIndex = " + IntToString(nParam1Index), MDP, 3);
				sParam1Value2DA = GetStringLowerCase(Get2DAString("iprp_paramtable", "TableResRef", nParam1Index));
				SetLocalString(oPC, "MDP_IMS_2DA", sParam1Value2DA);
				mdp_IMS_GenerateButtons(oPC,oModifyItem, sParam1Value2DA, "Name");
				SetLocalInt(oPC, "MDP_IMS_Previous_TableLevel", nTableLevel-1);
				SetLocalInt(oPC, "MDP_IMS_TableLevel", 4);
				break;
			}
			
		}
		default:
		{
			// By the time we get here, we have checked all possible sources of
			// information for the item property. Therefore we can now create it!
			mdp_IMS_DoSelectionFinish(oPC, oModifyItem);
		}
		
	} // switch
	
	
} // mdpResetItemModificationSelectionButtons

// On compleation of the item property selection, apply the new property
// to the tempory item.
void mdp_IMS_DoSelectionFinish(object oPC, object oModifyItem)
{
	Debug("vn_gui_inc: End of property selection.", MDP, 2);
	
	// Fetch the property info
	
	int nType = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 0); 
	int nSubType1 = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 1);
	int nSubType2 = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 2);
	int nSubType3 = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 3);
	
	int bPropertyValid = TRUE; 
	int nSelectionLevel = 0;
	for (nSelectionLevel = 0; nSelectionLevel < 4; nSelectionLevel++)
	{
		string s2DA = GetArrayString(oPC, "MDP_PropertySelection2DA", nSelectionLevel);
		if (s2DA == "") break;
		int n2DAIndex = GetArrayInt(oPC, "MDP_PropertySelectionIndex", nSelectionLevel);
    	if ( ! ModificationTypeAllowed(oModifyItem, oPC, s2DA, n2DAIndex)) 
		{
			// somehow the player has managed to generate an invalid property.
			Error("vn_mdp_gui: mdp_IMS_DoSelectionFinish - Invalid property generation detected for " + GetName(oPC));
			bPropertyValid = FALSE;

		}
	
	} // for : validate
	

	
	Debug(
		"vn_gui_inc: mdp_IMS_DoSelectionFinish() -" +
		" nType1 = " + IntToString(nType) +
		" nSubType1 = " + IntToString(nSubType1) +
		" nSubType2 = " + IntToString(nSubType2) +
		" nSubType3 = " + IntToString(nSubType3)
		, MDP
		, 3
	);

	if (bPropertyValid)
	{
	
		// set charges is a cast spell charges/use property is added
		if ( nType == IP_CONST_CAST_SPELL && nSubType2 != 0 && nSubType2 <=6)
			SetItemCharges(oModifyItem,50);
				
		itemproperty ip = ItemPropertyUniversal(nType, nSubType1, nSubType2, nSubType3);
		
		// itemproperty ip = ItemPropertyAbilityBonus(ABILITY_STRENGTH, 1);
		
		// Update the item-copy
		CustomAddProperty(oModifyItem, ip);
		
		// Add a Clear Sequencer property if a sequencer property was added.
		if 
		( 
			nType == IP_CONST_CAST_SPELL && 
			(
				nSubType1 == ACTIVATE_ITEM_SEQUENCER_1 ||
				nSubType1 == ACTIVATE_ITEM_SEQUENCER_2 ||
				nSubType1 == ACTIVATE_ITEM_SEQUENCER_3
			)	
		)
		// then
		{
			ip = ItemPropertyCastSpell(CLEAR_SEQUENCER, IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE);
			CustomAddProperty(oModifyItem, ip);
		}
	
		// set the item as changed
		SetLocalInt(oPC,"ITEM_CHANGED", TRUE);
	} // add valid property
	
	// Remove set variables
	DeleteLocalInt(oPC, "MDP_SelectionLevel");
	DeleteLocalInt(oPC, "MDP_IMS_TableLevel");
	DeleteLocalInt(oPC, "MDP_PropertySelectionPageOffset");	
		
	DeleteLocalString(oPC, "MDP_PropertySelection2DA0");
	DeleteLocalString(oPC, "MDP_PropertySelection2DA1");
	DeleteLocalString(oPC, "MDP_PropertySelection2DA2");
	DeleteLocalString(oPC, "MDP_PropertySelection2DA3");
	
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex0"); 
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex1"); 
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex2"); 
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex3"); 


	
	// Now that it is done, set up the property selection as it first was
	mdp_IMS_ResetButtons(oPC, oModifyItem);	// recursive call
}//mdpDoItemModificationSelectionFinish

//------------------------------------------------------------------------------
//                   End of mdp_IMS functions
//------------------------------------------------------------------------------


void mdpUpdateGUIStateItemModifications(object oPC)
{
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	// Update the property selection buttons
	mdp_IMS_ResetButtons(oPC, oModifyItem); // clear and hide all buttons

} // mdpUpdateGUIStateItemModifications


//	void main(){}