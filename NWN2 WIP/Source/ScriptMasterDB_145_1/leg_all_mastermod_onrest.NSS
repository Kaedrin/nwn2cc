/*

    Script:			This is the MASTER on rest script.  It is primarily used for the Resting Plugin but
					can be used for other things if we ever come up with something to use for it.
	Version:		1.00
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		06/22/2011 - 1.00 MV - Initial Release

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Let's get the Item, the person that acquired it and the ResRef/Tag of it.
	object oPC = GetLastPCRested();	
	
	// As long as we're a playah.
	if (GetIsPC(oPC))
	{
		// Check for the Quest Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
		{
			ExecuteScriptEnhanced("leg_rest_restevent", oPC);		
		}
	}
}