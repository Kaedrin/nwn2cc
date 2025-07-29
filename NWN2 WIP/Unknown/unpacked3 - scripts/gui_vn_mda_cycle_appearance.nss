///////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Script Name:gui_vn_mda_cycle_appearance
// Description:cycle through available appearances
////////////////////////////////////////////////////////////////////////////////
#include "vn_inc_gui"
#include "vn_mda__inc"
#include "vn_mda_gui"

void main(string sItem, string sStep, int nAppearanceChosen = 0)
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oArea=GetArea(oPC);
	object oModule=GetModule();
	
	int nInventorySlot;
	int nCurrentItemAppearance;
	int nNewAppearanceNum;
	int nVariations;
	int bPCPassAppearance;
	
	// need to get the variable for displaying appearance number as later we will change sItem depending
	// on the base item to differentiate resrefs for armor, weapons and shields.
	int nGUIVar = mda_GetGUILocalVariableNum(sItem);

	// we set up pointers to the temporary objects a PC is viewing
	// for cycling the appearance.  If the object doesn't exist yet
	// we know to start from the first in our list. If it does exist
	// we can use it to get what number variation of the item we are
	// up to for going forwards and backwards between them.
	object oTemporaryHelm = GetLocalObject(oPC,"Temporary_Helm");
	object oTemporaryCloak = GetLocalObject(oPC,"Temporary_Cloak");
	object oTemporaryBoots = GetLocalObject(oPC,"Temporary_Boots");
	object oTemporaryGloves = GetLocalObject(oPC,"Temporary_Gloves");
	object oTemporaryArmor = GetLocalObject(oPC,"Temporary_Armor");
	object oTemporaryRightHand = GetLocalObject(oPC,"Temporary_RightHand");		
	object oTemporaryLeftHand = GetLocalObject(oPC,"Temporary_LeftHand");	
	// we need to know the resref of the temporary items so we can decode
	// which number variation we are up to
	string sCurrentHelmResRef = GetResRef(oTemporaryHelm);
	string sCurrentCloakResRef = GetResRef(oTemporaryCloak);
	string sCurrentBootsResRef = GetResRef(oTemporaryBoots);
	string sCurrentGlovesResRef = GetResRef(oTemporaryGloves);
	string sCurrentArmorResRef = GetResRef(oTemporaryArmor);
	string sCurrentRightHandResRef = GetResRef(oTemporaryRightHand);
	string sCurrentLeftHandResRef = GetResRef(oTemporaryLeftHand);
		
	string sBaseArmorType = GetLocalString(oPC,"BaseArmorType");
	string sBaseRightHand = GetLocalString(oPC,"BaseRightHand");
	string sBaseLeftHand = GetLocalString(oPC,"BaseLeftHand");
	string sBaseArms = GetLocalString(oPC, "mdaBaseItemOnArms");
	string sBaseResRef = mda_GetBaseResRef(sItem);
	string sNewAppearanceResRef;
	string sNewAppearanceNum;
	string sTemporaryItem;
	object oNewAppearance;
	string sGUITextField;
	
	if (sItem == "helm")
	{
		sGUITextField="HELM_APP_NUM";
		nInventorySlot = INVENTORY_SLOT_HEAD; 
		sTemporaryItem = "Temporary_Helm";
		SetLocalInt(oPC,"Helm_TryingNew",1);
		// am i wearing my helm or am i checking a new appearance??
		// if I'm wearing a temporary helm destroy it before giving me the next to check
		if(GetIsObjectValid(oTemporaryHelm))
		{
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef, sCurrentHelmResRef);
			DestroyObject(oTemporaryHelm);
		}
		else
			nCurrentItemAppearance = 0;
		
		
		
	}
	else if (sItem == "cloak")
	{
		sGUITextField="CLOAK_APP_NUM";
		nInventorySlot = INVENTORY_SLOT_CLOAK; 
		sTemporaryItem = "Temporary_Cloak";
		SetLocalInt(oPC,"Cloak_TryingNew",1);

		if(GetIsObjectValid(oTemporaryCloak))
		{
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef, sCurrentCloakResRef);
			DestroyObject(oTemporaryCloak);
		}
		else
			nCurrentItemAppearance = 0;
	}
	else if (sItem == "boots")
	{
		sGUITextField="BOOTS_APP_NUM";
		nInventorySlot = INVENTORY_SLOT_BOOTS; 
		sTemporaryItem = "Temporary_Boots";
		SetLocalInt(oPC,"Boots_TryingNew",1);
		// am i wearing my helm or am i checking a new appearance??
		// if I'm wearing a temporary helm destroy it before giving me the next to check
		if(GetIsObjectValid(oTemporaryBoots))
		{
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef, sCurrentBootsResRef);
			DestroyObject(oTemporaryBoots);
		}
		else
			nCurrentItemAppearance = 0;
	}
	else if (sItem == "gloves")
	{
		sGUITextField="GLOVES_APP_NUM";		
		sItem = sBaseArms;
		sBaseResRef = mda_GetBaseResRef(sItem);	
		nInventorySlot = INVENTORY_SLOT_ARMS; 
		sTemporaryItem = "Temporary_Gloves";
		SetLocalInt(oPC,"Gloves_TryingNew",1);

		if(GetIsObjectValid(oTemporaryGloves))
		{
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef, sCurrentGlovesResRef);
			DestroyObject(oTemporaryGloves);
		}
		else
			nCurrentItemAppearance = 0;
	}	

	// armor and shield are special. The resrefs differ depending on the base type
	// so we need to find out what type of armor/shield we are looking at.
	else if (sItem == "armor")
	{
		sGUITextField="ARMOR_APP_NUM";		
		sItem = sBaseArmorType;
		sBaseResRef = mda_GetBaseResRef(sItem);
		nInventorySlot = INVENTORY_SLOT_CHEST; 
		sTemporaryItem = "Temporary_Armor";
		SetLocalInt(oPC,"Armor_TryingNew",1);

		if (GetIsObjectValid(oTemporaryArmor))
		{
			sBaseResRef = mda_GetBaseResRef(sItem);
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef,sCurrentArmorResRef);
			DestroyObject(oTemporaryArmor);		
		
		}
		else
			nCurrentItemAppearance = 0;
	}		
	else if (sItem == "righthand")
	{
		sGUITextField="RIGHTHAND_APP_NUM";		
		sItem = sBaseRightHand;
		sBaseResRef = mda_GetBaseResRef(sItem);
		
		nInventorySlot = INVENTORY_SLOT_RIGHTHAND; 
		sTemporaryItem = "Temporary_RightHand";
		SetLocalInt(oPC,"RightHand_TryingNew",1);

		if (GetIsObjectValid(oTemporaryRightHand))
		{
			sBaseResRef = mda_GetBaseResRef(sItem);
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef, sCurrentRightHandResRef);
			DestroyObject(oTemporaryRightHand);
		}			
		else
			nCurrentItemAppearance = 0;
				
	}
	else if (sItem == "lefthand")
	{
		sGUITextField="LEFTHAND_APP_NUM";
		sItem = sBaseLeftHand;
		sBaseResRef = mda_GetBaseResRef(sItem);
		
		nInventorySlot = INVENTORY_SLOT_LEFTHAND; 
		sTemporaryItem = "Temporary_LeftHand";
		SetLocalInt(oPC,"LeftHand_TryingNew",1);

		
		if (GetIsObjectValid(oTemporaryLeftHand))
		{
			sBaseResRef = mda_GetBaseResRef(sItem);
			nCurrentItemAppearance = DecodeGUIInt(sBaseResRef, sCurrentLeftHandResRef);
			DestroyObject(oTemporaryLeftHand);
		}
		else
			nCurrentItemAppearance = 0;
							
	}	
	// find the resref for the item with the next appearance
	// create and equip it on me
	// set the new appearance as my local object for clean up later
	nVariations = mda_GetBaseVariationsNumber(sItem);
	
	if (sStep == "next")
	{
		nNewAppearanceNum = nCurrentItemAppearance + 1;
		if (nNewAppearanceNum > nVariations)
			nNewAppearanceNum = 1;
	}
	else if (sStep == "previous")
	{
		nNewAppearanceNum = nCurrentItemAppearance - 1; 
		if (nNewAppearanceNum <= 0)
			nNewAppearanceNum = nVariations;
	}
			
	if (sStep == "setAppearance")
		nNewAppearanceNum = nAppearanceChosen;
				
	if (nNewAppearanceNum > nVariations)
		nNewAppearanceNum = nVariations;
			

				
	if (nNewAppearanceNum > 99)
		sNewAppearanceResRef = sBaseResRef + IntToString(nNewAppearanceNum);	
	else if (nNewAppearanceNum > 9)
		sNewAppearanceResRef = sBaseResRef + "0" + IntToString(nNewAppearanceNum);
	else 
		sNewAppearanceResRef = sBaseResRef + "00" +  IntToString(nNewAppearanceNum);
		
	sNewAppearanceNum = IntToString(nNewAppearanceNum);
	oNewAppearance = CreateItemOnObject(sNewAppearanceResRef,oPC,1);
	SetPlotFlag(oNewAppearance, TRUE); // prevent exploit by making it worthless
	AssignCommand(oPC, ActionEquipItem(oNewAppearance,nInventorySlot));
	SetLocalObject(oPC,sTemporaryItem,oNewAppearance);
	SetLocalGUIVariable(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",nGUIVar,sNewAppearanceNum);
	SetGUIObjectText(oPC,"SCREEN_VN_ITEM_APPEARANCE_CHANGER",sGUITextField,-1,sNewAppearanceNum);
	mda_UpdateGUIState(oPC);
	
	
}