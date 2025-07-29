// =============================================================
//
//    File: row_fp_chest_disarm
//    Desc: Rowell's Fair Play Chest - Disarm Trap Event
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
	object oPC        = GetLastDisarmed();
	string sID        = GetPCPlayerName(oPC) + GetName(oPC) + "dFPC";
	string sText      = "";
	int    iReward    = GetSkillRank(SKILL_DISABLE_TRAP , oPC);
	int	   iMinReward = 5;
	int    iMaxReward = 25;
			
	// CHECK IF CHEST IS INITIALIZED
	if (GetLocalInt(oChest, "IsInitialized") != 1) {
		ChestInit(oChest);
	}
	
	// GIVE A REWARD FOR DISARMING THE TRAP
	if (iReward > 0 && GetLocalInt(oChest, sID) != 1) {
		//iReward = ((GetTrapDisarmDC(oChest) - 10) - iReward) * 5;
		iReward = iReward - GetTrapDisarmDC(oChest);
		if (iReward > iMaxReward) { iReward = iMaxReward; }
		if (iReward < iMinReward) { iReward = iMinReward; }
		AssignCommand(oPC, GiveXPToCreature(oPC, iReward));
		sText = "You earned " + IntToString(iReward) + "xp for disarming the trap.";
		AssignCommand(oPC, FloatingTextStringOnCreature(sText, oPC, FALSE));
		SetLocalInt(oChest, sID, 1);
	}
	
}