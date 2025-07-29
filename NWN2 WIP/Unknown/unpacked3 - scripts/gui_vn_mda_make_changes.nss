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
// Script Name: gui_vn_mda_make_changes
// Description: put any properties on PC's item onto item of new appearance
//
////////////////////////////////////////////////////////////////////////////////

#include "vn_mda_gui"
#include "vn_inc_main"

void main(string sItemName)
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oArea=GetArea(oPC);
	object oModule=GetModule();
	
	object oTemporaryHelm = GetLocalObject(oPC,"Temporary_Helm");
	object oTemporaryCloak = GetLocalObject(oPC,"Temporary_Cloak");
	object oTemporaryBoots = GetLocalObject(oPC,"Temporary_Boots");
	object oTemporaryGloves = GetLocalObject(oPC,"Temporary_Gloves");
	object oTemporaryArmor = GetLocalObject(oPC,"Temporary_Armor");
	object oTemporaryRightHand = GetLocalObject(oPC,"Temporary_RightHand");
	object oTemporaryLeftHand = GetLocalObject(oPC,"Temporary_LeftHand");
	
	object oPC_Helm = GetLocalObject(oPC,"PC_Helm");
	object oPC_Cloak = GetLocalObject(oPC,"PC_Cloak");
	object oPC_Boots = GetLocalObject(oPC,"PC_Boots");
	object oPC_Gloves = GetLocalObject(oPC,"PC_Gloves");
	object oPC_Armor = GetLocalObject(oPC,"PC_Armor");
	object oPC_RightHand = GetLocalObject(oPC,"PC_RightHand");
	object oPC_LeftHand = GetLocalObject(oPC,"PC_LeftHand");
	
	int nHelmChanged = GetLocalInt(oPC,"Helm_TryingNew");
	int nCloakChanged = GetLocalInt(oPC,"Cloak_TryingNew");
	int nBootsChanged = GetLocalInt(oPC,"Boots_TryingNew");
	int nGlovesChanged = GetLocalInt(oPC,"Gloves_TryingNew");
	int nArmorChanged = GetLocalInt(oPC,"Armor_TryingNew");
	int nRightHandChanged = GetLocalInt(oPC,"RightHand_TryingNew");
	int nLeftHandChanged = GetLocalInt(oPC,"LeftHand_TryingNew");
	
	string sName;

	
	int nCost = mda_GetAppearanceChangeCost(oPC);
	int bPaid = FALSE;

	if (GetIsDM(oPC) || GetIsDMPossessed(oPC))
		bPaid = TRUE;
	else if (SurrenderGold(oPC,nCost))
		bPaid = TRUE; 

	if (bPaid)
	{
		if(nHelmChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_Helm,oTemporaryHelm);
			// have to unequip then reequip so you can see the name is the name of the original item
			ActionUnequipItem(oTemporaryHelm);
			DelayCommand(0.1,ActionEquipItem(oTemporaryHelm,INVENTORY_SLOT_HEAD));
			DestroyObject(oPC_Helm);
			SetPlotFlag(oTemporaryHelm, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_Helm,INVENTORY_SLOT_HEAD);
			DestroyObject(oTemporaryHelm);
		}

		if(nCloakChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_Cloak,oTemporaryCloak);
			ActionUnequipItem(oTemporaryCloak);
			DelayCommand(0.1,ActionEquipItem(oTemporaryCloak,INVENTORY_SLOT_CLOAK));
			DestroyObject(oPC_Cloak);
			SetPlotFlag(oTemporaryCloak, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_Cloak,INVENTORY_SLOT_CLOAK);
			DestroyObject(oTemporaryCloak);
		}
		
		if(nBootsChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_Boots,oTemporaryBoots);
			sName = GetName(oPC_Boots);
			ActionUnequipItem(oTemporaryBoots);
			DelayCommand(0.1,ActionEquipItem(oTemporaryBoots,INVENTORY_SLOT_BOOTS));
			DestroyObject(oPC_Boots);
			SetPlotFlag(oTemporaryBoots, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_Boots,INVENTORY_SLOT_BOOTS);
			DestroyObject(oTemporaryBoots);
		}
				
		if(nGlovesChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_Gloves,oTemporaryGloves);
			ActionUnequipItem(oTemporaryGloves);
			DelayCommand(0.1,ActionEquipItem(oTemporaryGloves,INVENTORY_SLOT_ARMS));
			DestroyObject(oPC_Gloves);
			SetPlotFlag(oTemporaryGloves, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_Gloves,INVENTORY_SLOT_ARMS);
			DestroyObject(oTemporaryGloves);
		}
		
		if(nArmorChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_Armor,oTemporaryArmor);
			ActionUnequipItem(oTemporaryArmor);
			DelayCommand(0.1,ActionEquipItem(oTemporaryArmor,INVENTORY_SLOT_CHEST));
			DestroyObject(oPC_Armor);
			SetPlotFlag(oTemporaryArmor, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_Armor,INVENTORY_SLOT_CHEST);
			DestroyObject(oTemporaryArmor);
		}
		
		if(nRightHandChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_RightHand,oTemporaryRightHand);
			ActionUnequipItem(oTemporaryRightHand);
			DelayCommand(0.1,ActionEquipItem(oTemporaryRightHand,INVENTORY_SLOT_RIGHTHAND));
			DestroyObject(oPC_RightHand);
			SetPlotFlag(oTemporaryRightHand, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_RightHand,INVENTORY_SLOT_RIGHTHAND);
			DestroyObject(oTemporaryRightHand);
		}

		if(nLeftHandChanged)
		{	// apply any properties from our existing item on to the new one
			// equip the temporary as it's now ours
			// destroy the original
			mda_ApplyExistingPropertiesToNewObject(oPC_LeftHand,oTemporaryLeftHand);
			ActionUnequipItem(oTemporaryLeftHand);
			DelayCommand(0.1,ActionEquipItem(oTemporaryLeftHand,INVENTORY_SLOT_LEFTHAND));
			DestroyObject(oPC_LeftHand);
			SetPlotFlag(oTemporaryLeftHand, FALSE);
		}
		else
		{	// destroy the temporary and re-equip our item
			ActionEquipItem(oPC_LeftHand,INVENTORY_SLOT_LEFTHAND);
			DestroyObject(oTemporaryLeftHand);
		}								

	}
	else
		 SendMessageToPC(oPC,"You don't seem to have enough gold");


	// all changes are made at the one time so we can remove all pointers and variables		 	
	DeleteLocalObject(oPC,"Temporary_Helm");
	DeleteLocalObject(oPC,"Temporary_Cloak");
	DeleteLocalObject(oPC,"Temporary_Boots");
	DeleteLocalObject(oPC,"Temporary_Gloves");
	DeleteLocalObject(oPC,"Temporary_Armor");
	DeleteLocalObject(oPC,"Temporary_RightHand");
	DeleteLocalObject(oPC,"Temporary_LeftHand");
	
	DeleteLocalObject(oPC,"PC_Helm");
	DeleteLocalObject(oPC,"PC_Cloak");
	DeleteLocalObject(oPC,"PC_Boots");
	DeleteLocalObject(oPC,"PC_Gloves");
	DeleteLocalObject(oPC,"PC_Armor");
	DeleteLocalObject(oPC,"PC_RightHand");
	DeleteLocalObject(oPC,"PC_LeftHand");
	
	DeleteLocalString(oPC,"BaseArmorType");
	DeleteLocalString(oPC,"BaseRightHand");
	DeleteLocalString(oPC,"BaseLeftHand");
	DeleteLocalString(oPC,"mdaBaseItemOnArms");
	
	DeleteLocalInt(oPC,"PC_Helm_Value");
	DeleteLocalInt(oPC,"PC_Cloak_Value");
	DeleteLocalInt(oPC,"PC_Boots_Value");
	DeleteLocalInt(oPC,"PC_Gloves_Value");
	DeleteLocalInt(oPC,"PC_Armor_Value");
	DeleteLocalInt(oPC,"PC_RightHand_Value");
	DeleteLocalInt(oPC,"PC_LeftHand_Value");
	
	DeleteLocalInt(oPC,"Helm_TryingNew");
	DeleteLocalInt(oPC,"Cloak_TryingNew");	
	DeleteLocalInt(oPC,"Boots_TryingNew");
	DeleteLocalInt(oPC,"Gloves_TryingNew");	
	DeleteLocalInt(oPC,"Armor_TryingNew");	
	DeleteLocalInt(oPC,"RightHand_TryingNew");	
	DeleteLocalInt(oPC,"LeftHand_TryingNew");	
	
	mda_UpdateGUIState(oPC);
	DelayCommand(0.2,mda_SetupAppearanceChanger(oPC)); 


}