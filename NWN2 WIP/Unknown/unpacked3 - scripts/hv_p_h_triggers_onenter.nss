#include "hv_p_h_inc"
#include "hcr2_core_i"

void main()
{
	object oPC = GetEnteringObject();
	
	// I want PCs only!
	if (!GetIsPC(oPC))
		return;
		
	// Do the rest only if we're the only PC in the area
	if (GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) > 1)
		return;
	
	DisarmPuzzleTriggersRandomly(GetArea(oPC));
}