#include "hv_domains_enforcement"

// Go over all PCs on server.
// Return a list of Clerics and their domain status (ok / not ok)
void main()
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	object oDM = OBJECT_SELF;
	int nCheckResult;
	
	object oPC = GetFirstPC();
	while (GetIsObjectValid(oPC)) {
	
		// Check if has Cleric levels
		if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0) {
		
			// Check domains
			nCheckResult = CheckClericDomains(oPC);
			
			// Passed check
			if (nCheckResult == 1) {
				
				// Inform DM cleric is good
				SendMessageToPC(oDM, "<C=lightgreen>" + GetName(oPC) + " has right domains.");
			}
			// Wrong domains
			else if (nCheckResult == 2) {
			
				// Bad cleric!
				SendMessageToPC(oDM, "<C=red>" + GetName(oPC) + " has wrong domains!");
			}
			// More or less than 2 domains
			else if (nCheckResult == 3) {
			
				SendMessageToPC(oDM, "<C=red>" + GetName(oPC) + " does not have 2 domains! Initiate investigation!");
			}
		}
					
		// Get next pc
		oPC = GetNextPC();
	}		
}