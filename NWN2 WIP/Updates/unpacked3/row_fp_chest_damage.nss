// =============================================================
//
//    File: row_fp_chest_damage
//    Desc: Rowell's Fair Play Chest - Damage Event
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
	object oChest = OBJECT_SELF;
	object oPC    = GetLastAttacker(oChest);
	int    iMaxHP = GetMaxHitPoints(oChest);
	int    iCurHP = GetCurrentHitPoints(oChest);
	int    iDmg   = GetTotalDamageDealt();
	
	// CHECK IF CHEST IS INITIALIZED
	if (GetLocalInt(oChest, "IsInitialized") != 1) {
		ChestInit(oChest);
	}
	
	// IF OBJECT IS UNLOCKED, THEN EXIT
	if (GetLocked(oChest) == FALSE) {
		FloatingTextStringOnCreature("The lock is already broken.", oPC, FALSE);
		return;
	}
	
	// APPLY BASE BASHING DAMAGE IF OBJECT IS PLOT
	if (iDmg < 1) { 
		iDmg = (GetHitDice(oPC) / 2) + d6() + GetAbilityModifier(ABILITY_STRENGTH, oPC);
		if (iDmg < 1) { iDmg = 1; }
		FloatingTextStringOnCreature("You damage the lock for " + IntToString(iDmg) + " points of damage.", oPC, FALSE);		
	}
	
	// CALCULATE DAMAGE TO DEATH RATIO
	iCurHP = GetLocalInt(oChest, "CurHP");
	iCurHP = iCurHP - iDmg;
	if (iCurHP < 1) {
		SetLocked(oChest, FALSE);
		FloatingTextStringOnCreature("You have broken the lock.", oPC, FALSE);
		AssignCommand(oPC, ClearAllActions(TRUE));
		iCurHP = iMaxHP;
	}

	// DO NOT LET THE CHEST GET DESTROYED
	SetLocalInt(oChest, "CurHP", iCurHP);
		
	// CHESTS MAKE NOISE WHEN BASHED, ATTRACTING MONSTERS
	AssignCommand(oChest, ActionSpeakString("HELP",  TALKVOLUME_SILENT_TALK));
	
}