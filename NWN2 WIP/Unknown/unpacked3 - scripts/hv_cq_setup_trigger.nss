#include "hv_cq_inc"

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	if (GetLocalInt(GetArea(OBJECT_SELF), SETUP_COMPLETED) == TRUE)
		return;
		
	// Make sure PC has the quest
	if (GetJournalEntry("hv_cq", oPC) != 560)
		return;
		
	// Create new setup
	CreateGuards();
	object oBoss = CreateBoss();
	CreateCrystals(oBoss);
	CreatePrisoners();
	SetLocalInt(GetArea(OBJECT_SELF), SETUP_COMPLETED, TRUE);
}