#include "hv_bandits_inc"

// Activate trap if needed
void main()
{
	object oPC = GetEnteringObject();
	
	if (GetIsPC(oPC))
		ActivateStatueTrap(OBJECT_SELF, oPC);
}