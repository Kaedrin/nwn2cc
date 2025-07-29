/*

    Script:			This is the MASTER on spawn script.  It goes on all NPC's and monsters or is called from an
					existing script via ExecuteScript function.  Like all Master Run Scripts, this script examines which
					plugins are available and active and calls them.
	Version:		1.60
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A

	Change Log:		12/17/2010 - MV - Initial Revision
					10/17/2011 - MV 1.60 - Added fix for new loot plugin.		
*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Master System for OnSpawn events for Legends Modules.  This needs to be called from either the NWN2 stock
	// on death event for monsters or called from a custom on death event script or optionally called directly AS
	// the on death script.  First we determine if we were passed from another script or if we are called be the event.	
	object oTarget = OBJECT_SELF;

	// If the LOOT Plugin is active.
	if (GetLocalInt(GetModule(), "LEG_LOOT_ACTIVE") && GetLocalInt(GetModule(), "LEG_LOOT_ONSPAWN"))
	{
		object oParent = GetLocalObject(OBJECT_SELF, "SPAWN_Parent");
		if (!GetIsObjectValid(oParent))
			oParent = OBJECT_SELF;
		else
		{
			if (GetLocalString(oParent, "LEG_LOOT_ID") != "")
				oParent = OBJECT_SELF;
		}
		AddScriptParameterObject(oTarget);
		AddScriptParameterObject(oParent);
		ExecuteScriptEnhanced("leg_loot_makeloot", oTarget);
	}
}