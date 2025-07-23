/*

    Script:			This is the MASTER module on death script for when a player dies.  It will call the REST
					system for death penalties as well as optionally store the PC's state.
	Version:		1.00
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		07/22/2011 - 1.00 MV - Initial Release

*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Who died?
	object oPC = GetLastPlayerDied();

	// If the Rest Plugin is active, then do this....
	if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
	{
		// Fire the death script
		ExecuteScript("leg_rest_onpcdeath", oPC);
			
		// If the Legends Resting Plugin is being used and the Death Systems are active in it.
		ExecuteScript("leg_rest_savepc", oPC);
	}
}