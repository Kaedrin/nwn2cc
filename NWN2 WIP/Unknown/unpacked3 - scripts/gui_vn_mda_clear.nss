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
//  Script Name: gui_vn_mda_clear
//  Description: removes temporary items from PC used for appearance changer
//------------------------------------------------------------------------------

void main()
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
	
	AssignCommand(oPC, ActionEquipItem(oPC_Helm,INVENTORY_SLOT_HEAD));
	AssignCommand(oPC, ActionEquipItem(oPC_Cloak,INVENTORY_SLOT_CLOAK));
	AssignCommand(oPC, ActionEquipItem(oPC_Boots,INVENTORY_SLOT_BOOTS));
	AssignCommand(oPC, ActionEquipItem(oPC_Gloves,INVENTORY_SLOT_ARMS));
	AssignCommand(oPC, ActionEquipItem(oPC_Armor,INVENTORY_SLOT_CHEST));
	AssignCommand(oPC, ActionEquipItem(oPC_RightHand,INVENTORY_SLOT_RIGHTHAND));
	AssignCommand(oPC, ActionEquipItem(oPC_LeftHand,INVENTORY_SLOT_LEFTHAND));
	
	DestroyObject(oTemporaryHelm);
	DestroyObject(oTemporaryCloak);
	DestroyObject(oTemporaryBoots);
	DestroyObject(oTemporaryGloves);
	DestroyObject(oTemporaryArmor);
	DestroyObject(oTemporaryRightHand);
	DestroyObject(oTemporaryLeftHand);
	
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
	
	
	CloseGUIScreen(oPC, "SCREEN_VN_ITEM_APPEARANCE_CHANGER");
	SendMessageToPC(oPC,"Closing Item Appearance Changer GUI");
}