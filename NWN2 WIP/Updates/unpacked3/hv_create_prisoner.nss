#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	object oEnteringPC = GetEnteringObject();
	// check if it has the right quest part
	if (GetJournalEntry("hv_captured_dryad",oEnteringPC) == 6) {
		string sTemplate = "hv_prisoner_d";
	
		object oLocation = GetObjectByTag("prisonerWP");
    	location lLocation = GetLocation(oLocation);
		
    	int iObjType = GetObjectTypes("C");
		
		// create the dryad in new area
    	DelayCommand(1.0, ActionCreateObject(iObjType, sTemplate, lLocation));		
	}
}