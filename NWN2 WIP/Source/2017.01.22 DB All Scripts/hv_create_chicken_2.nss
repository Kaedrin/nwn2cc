#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	object oEnteringPC = GetEnteringObject();
	// check if it has the right quest part
	if (GetJournalEntry("ellas_uber_chicken",oEnteringPC) == 3 && GetObjectByTag("hv_uber_chicken2")==OBJECT_INVALID) {
		string sTemplate = "hv_uber_chicken2";
	
		object oLocation = GetObjectByTag("uber_wp");
    	location lLocation = GetLocation(oLocation);
		
    	int iObjType = GetObjectTypes("C");
		
		// create the chicken in new area
		if(GetObjectByTag("hv_uber_chicken2")==OBJECT_INVALID)
		{	
    		DelayCommand(1.0, ActionCreateObject(iObjType, sTemplate, lLocation));
		}		
	}
}