#include "hv_domains_enforcement"


// On Gate Guardian conversation, 
// if it's a cleric with wrong domain inform player
// and DM channel
int StartingConditional()
{
	object oPC = GetPCSpeaker();
	
	// Check if has Cleric levels
	if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0) {
	
		// Check if has right domains
		if (CheckClericDomains(oPC) != 1) {
		
			SendMessageToAllDMs(GetName(oPC) + " has wrong domains.");
			return TRUE; // Yes, it has wrong domains
		}
	}
	
	return FALSE;
}
	