// =============================================================
//
//    File: row_inc_chest
//    Desc: Rowell's FairPlay Chest - Include File
//  Author: Michael Marzilli
//    Site: http://www.engliton.org
//
// Created: Jan 04, 2007
// Updated: Jan 04, 2007
// Version: 1.0.0
//
// =============================================================


void ChestInit(object oChest) {
	int    iCount = 0;
	object oItem  = GetFirstItemInInventory(oChest);
	
	// IF THE CHEST IS PRE-POPULATED, SAVE WHICH ITEMS ARE IN THE CHEST
	// THESE ITEMS WILL ALWAYS BE GIVEN TO ALL PLAYERS WHEN THE CHEST IS OPENED
	/*while (oItem != OBJECT_INVALID) {
		iCount++;
		SetLocalString(oChest, "ITEM_" + IntToString(iCount), GetResRef(oItem));
		oItem = GetNextItemInInventory(oChest);
	}*/
	
	// SAVE THE CHEST STATE INTO LOCAL VARIABLES 
	SetLocalInt(oChest, "ITEM_COUNT", iCount);
	SetPlotFlag(oChest, TRUE);
	SetLocalInt(oChest, "IsTrapped", GetIsTrapped(oChest));
	SetLocalInt(oChest, "IsLocked", GetLocked(oChest));
	SetLocalInt(oChest, "CurHP", GetMaxHitPoints(oChest));
	SetLocalInt(oChest, "IsInitialized", 1);

}