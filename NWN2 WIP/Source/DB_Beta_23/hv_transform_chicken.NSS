#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	// chicken turns into a gnome!
	ActionCastFakeSpellAtObject(SPELL_WAIL_OF_THE_BANSHEE, OBJECT_SELF);
	DestroyObject(OBJECT_SELF, 5.0, 1);
	
	string sTemplate = "hv_uber_gnome";	
	object oLocation = GetObjectByTag("hv_uber_chicken2");
    location lLocation = GetLocation(oLocation);
	
    int iObjType = GetObjectTypes("C");
	
	if(GetObjectByTag("hv_uber_gnome")==OBJECT_INVALID)
	{
		// create the chicken in new area
    	DelayCommand(5.0, ActionCreateObject(iObjType, sTemplate, lLocation));
	}	
}	