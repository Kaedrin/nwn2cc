#include "hv_cq_inc"
#include "hcr2_core_i"

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	// Do the rest only if we're the only PC in the area
	if (GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) > 1)
		return;
	
	// Clean old setup
	CleanLeftovers(OBJECT_SELF);
	
	
	// (MOVED TO TRIGGER) //
	// Create new setup
	//CreateGuards();
	//object oBoss = CreateBoss();
	//CreateCrystals(oBoss);
	//CreatePrisoners();
}