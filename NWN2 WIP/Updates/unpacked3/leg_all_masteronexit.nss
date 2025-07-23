/*

    Script:			This is the MASTER on exit script.  It is called on by an existing On Area Exit event script or
					by simply placing it in the event itself.  This script will check for active plugins and run any 
					that require an exit routine when a player leaves the area.
	Version:		1.60
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A

	Change Log:		11/26/2010 - 1.00 MV - Initial Release
					11/28/2010 - 1.01 MV - Bug fix in the event this script is called by another.
					10/16/2011 - 1.60 MV - Fixed major bug with area de-spawning call.
*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// This should be placed in the OnExit script field or called from there.  First we find out if
	// we were called via someone elses OnClientEnter script for the area or if we are the actual script for
	// that event.
	object oPC = OBJECT_SELF;		
	object oArea = OBJECT_SELF;
	
	// Make sure we are the player and not some familiar
	object oMaster = GetMaster(oPC);
	if (GetIsObjectValid(oMaster))
		oPC = oMaster;

	// Use this is we are called direct, otherwise use what we were passed.
	if (!GetIsPC(oPC))
		oPC = GetExitingObject();
				
	if (GetIsPC(oPC))
	{
		// Check for the Legends SPAWN Module (also used in various other modules such as LOOT)
		if (GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
		{
			AddScriptParameterObject(oArea);
			ExecuteScriptEnhanced("leg_spawn_onexit", oPC);					
		}

	}
}