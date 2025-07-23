/*

    Script:			This is the MASTER item activated script for the module event.  Used for quest tools
					on targets and other items such as camping kits etc.
	Version:		1.03
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		12/29/2010 - 1.00 MV - Initial Release
					06/22/2011 - 1.01 MV - Added support for Rest Plugin
					07/17/2011 - 1.02 MV - Added support for Secret Plugin
					08/24/2011 - 1.03 MV - Added support for Craft Plugin

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Let's get the Item, the person that activated etc.
	object oItem = GetItemActivated();
	object oPC = GetItemActivator();
	location lLoc = GetItemActivatedTargetLocation();
	object oArea = GetArea(oPC);
	object oTarget = GetItemActivatedTarget();	

	// As long as we're a playah.
	if (GetIsPC(oPC))
	{
		// Check for the Quest Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			AddScriptParameterObject(oItem);
			AddScriptParameterObject(oTarget);
			ExecuteScriptEnhanced("leg_quest_itemactivated", oPC);		
		}
		
		// Check for the Rest Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			AddScriptParameterObject(oItem);
			ExecuteScriptEnhanced("leg_rest_itemactivated", oPC);		
		}
		
		// Check for the Secret Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_SECRET_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			AddScriptParameterObject(oItem);
			ExecuteScriptEnhanced("leg_secret_itemactivated", oPC);		
		}

		// Check for the Secret Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_CRAFT_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			AddScriptParameterObject(oItem);
			ExecuteScriptEnhanced("leg_craft_itemactivated", oPC);		
		}
				
	}
}