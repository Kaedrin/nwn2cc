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
// Script Name: gui_vn_mda_cancel
// Description: cancel appearance change to single item
////////////////////////////////////////////////////////////////////////////////
#include "vn_inc_gui"
#include "vn_mda__inc"
#include "vn_mda_gui"

void main(string sItem)
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

	int nGUIVar = mda_GetGUILocalVariableNum(sItem);
	
	if (sItem == "helm")
	{
		if (GetIsObjectValid(oTemporaryHelm))
		{
			DestroyObject(oTemporaryHelm);
			DeleteLocalObject(oPC,"Temporary_Helm");
			DeleteLocalInt(oPC,"PC_Helm_Value");
		}
		if (GetIsObjectValid(oPC_Helm))
			AssignCommand(oPC, ActionEquipItem(oPC_Helm,INVENTORY_SLOT_HEAD));
		
		DeleteLocalInt(oPC,"Helm_TryingNew");
	}
	else if (sItem == "cloak")
	{
		if (GetIsObjectValid(oTemporaryCloak))
		{
			DestroyObject(oTemporaryCloak);
			DeleteLocalObject(oPC,"Temporary_Cloak");
			DeleteLocalInt(oPC,"PC_Cloak_Value");
		}
		if (GetIsObjectValid(oPC_Cloak))
			AssignCommand(oPC, ActionEquipItem(oPC_Cloak,INVENTORY_SLOT_CLOAK));
		
		DeleteLocalInt(oPC,"Cloak_TryingNew");
	}
	else if (sItem == "boots")
	{
		if (GetIsObjectValid(oTemporaryBoots))
		{
			DestroyObject(oTemporaryBoots);
			DeleteLocalObject(oPC,"Temporary_Boots");
			DeleteLocalInt(oPC,"PC_Boots_Value");
		}
		if (GetIsObjectValid(oPC_Boots))
			AssignCommand(oPC, ActionEquipItem(oPC_Boots,INVENTORY_SLOT_BOOTS));
		
		DeleteLocalInt(oPC,"Boots_TryingNew");
	}
	else if (sItem == "gloves")
	{
		if (GetIsObjectValid(oTemporaryGloves))
		{
			DestroyObject(oTemporaryGloves);
			DeleteLocalObject(oPC,"Temporary_Gloves");
			DeleteLocalInt(oPC,"PC_Gloves_Value");
		}
		if (GetIsObjectValid(oPC_Gloves))
			AssignCommand(oPC, ActionEquipItem(oPC_Gloves,INVENTORY_SLOT_ARMS));
		
		DeleteLocalInt(oPC,"Gloves_TryingNew");
	}
	else if (sItem == "armor")
	{
		if (GetIsObjectValid(oTemporaryArmor))
		{
			DestroyObject(oTemporaryArmor);
			DeleteLocalObject(oPC,"Temporary_Armor");
			DeleteLocalInt(oPC,"PC_Armor_Value");
		}
		if (GetIsObjectValid(oPC_Armor))
			AssignCommand(oPC, ActionEquipItem(oPC_Armor,INVENTORY_SLOT_CHEST));
		
		DeleteLocalInt(oPC,"Armor_TryingNew");
	}
	else if (sItem == "righthand")
	{
		if (GetIsObjectValid(oTemporaryRightHand))
		{
			DestroyObject(oTemporaryRightHand);
			DeleteLocalObject(oPC,"Temporary_RightHand");
			DeleteLocalInt(oPC,"PC_RightHand_Value");
		}
		if (GetIsObjectValid(oPC_RightHand))
			AssignCommand(oPC, ActionEquipItem(oPC_RightHand,INVENTORY_SLOT_RIGHTHAND));
		else
			SendMessageToPC(GetFirstPC(),"can't find right hand item");
			
		DeleteLocalInt(oPC,"RightHand_TryingNew");
	}	
	else if (sItem == "lefthand")
	{
		if (GetIsObjectValid(oTemporaryLeftHand))
		{
			DestroyObject(oTemporaryLeftHand);
			DeleteLocalObject(oPC,"Temporary_LeftHand");
			DeleteLocalInt(oPC,"PC_LeftHand_Value");
		}
		if (GetIsObjectValid(oPC_LeftHand))
			AssignCommand(oPC, ActionEquipItem(oPC_LeftHand,INVENTORY_SLOT_LEFTHAND));
		else
			SendMessageToPC(GetFirstPC(),"can't find left hand item");
		
		DeleteLocalInt(oPC,"LeftHand_TryingNew");
	}	
	
	mda_UpdateGUIState(oPC);
	
} // main