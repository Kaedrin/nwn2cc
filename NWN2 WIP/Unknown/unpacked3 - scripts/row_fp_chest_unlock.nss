// =============================================================
//
//    File: row_fp_chest_unlock
//    Desc: Rowell's Fair Play Chest - Unlock Event
//  Author: Michael Marzilli
//    Site: http://www.engliton.org
//
// Created: Oct 02, 2006
// Updated: Jan 04, 2007
// Version: 1.0.0
//
// =============================================================

#include "row_inc_chest"

void main() {
	object oChest     = OBJECT_SELF;
	object oPC        = GetLastUnlocked();
	string sID        = GetPCPlayerName(oPC) + GetName(oPC) + "uFPC";
	string sText      = "";
	
	//int iReward = 5;
	int    iReward    = GetSkillRank(SKILL_OPEN_LOCK , oPC);
	int	   iMinReward = 5;
	int    iMaxReward = 25;
		
	// CHECK IF CHEST IS INITIALIZED
	if (GetLocalInt(oChest, "IsInitialized") != 1) {
		ChestInit(oChest);
	}

		// GIVE A REWARD FOR UNLOCKING THE CHEST
	if (iReward > 0 && GetLocalInt(oChest, sID) != 1) {
		//iReward = ((GetLockUnlockDC(oChest) - 15) - iReward) * 5;
		iReward = iReward - 10 - GetLockUnlockDC(oChest);
		if (iReward > iMaxReward) { iReward = iMaxReward; }
		if (iReward < iMinReward) { iReward = iMinReward; }
		AssignCommand(oPC, GiveXPToCreature(oPC, iReward));
		sText = "You earned " + IntToString(iReward) + "xp for unlocking this chest.";
		AssignCommand(oPC, FloatingTextStringOnCreature(sText, oPC, FALSE));
		SetLocalInt(oChest, sID, 1);
	}
	
}