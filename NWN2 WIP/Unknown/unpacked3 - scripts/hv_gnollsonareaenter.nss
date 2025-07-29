//#include "hcr2_core_i"
#include "ginc_param_const" 
#include "ginc_actions"
 
void main()
{
   /* int playercount = GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA);
    SetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA, playercount + 1);    
    h2_RunObjectEventScripts(H2_AREAEVENT_ON_CLIENT_ENTER, OBJECT_SELF);
	//SpawnScriptDebugger();
*/
	object oEnteringPC = GetEnteringObject();
	// check if it has the right quest part
	if (GetObjectByTag("hv_prisoner_d")==OBJECT_INVALID)
	{
		if ((GetJournalEntry("hv_captured_dryad",oEnteringPC) == 6) || (GetJournalEntry("hv_captured_dryad",oEnteringPC) == 7)) {
		string sTemplate = "hv_prisoner_d";
	
		object oLocation = GetObjectByTag("prisonerWP");
    	location lLocation = GetLocation(oLocation);
		
    	int iObjType = GetObjectTypes("C");
		
		// create the dryad in new area
    	DelayCommand(1.0, ActionCreateObject(iObjType, sTemplate, lLocation));		
		}
	}
}