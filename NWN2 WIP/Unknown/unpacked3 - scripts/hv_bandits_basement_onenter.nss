#include "hv_bandits_inc"
#include "hcr2_core_i"

// Bandits basement - on area enter
void main()
{	
	// Once per reset add random items to store
	if (GetLocalInt(OBJECT_SELF, "store_init") == 0) {
	
		ExecuteScript("hv_bandits_add_random_items", OBJECT_SELF);
		SetLocalInt(OBJECT_SELF, "store_init", 1);
	}


	object oPC = GetEnteringObject();
		
	// I want PCs only!
	if (!GetIsPC(oPC))
		return;
		
	// Generate password if needed
	if (GetLocalInt(oPC, DIGIT_1) == 0)
		GeneratePassword(oPC);
	
	// Do the rest only if we're the only PC in the area
	if (GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) > 1)
		return;
	
	ResetTraps(OBJECT_SELF);
}