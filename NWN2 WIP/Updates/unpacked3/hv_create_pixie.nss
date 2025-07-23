#include "ginc_param_const"
#include "ginc_actions"

void main()
{	
	string sTemplate = "hv_pixie";
	object oLocation = GetObjectByTag("foe_wp");
    location lLocation = GetLocation(oLocation);
	
    int iObjType = GetObjectTypes("C");
	
	// create the foe in new area
    DelayCommand(1.0, ActionCreateObject(iObjType, sTemplate, lLocation));		
}