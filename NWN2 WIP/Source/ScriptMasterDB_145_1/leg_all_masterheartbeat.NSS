/*

    Script:			This is the MASTER on heartbeat script.  It goes on all NPC's and monsters or is called from an
					existing heartbeat script via ExecuteScript function.  Like all Master Run Scripts, this script 
					examines which plugins are available and active and calls them.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		11/26/2010 - 1.00 - MV - Initial Release
					12/21/2010 - 1.01 - MV - Added support for criers
	
*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Master System for OnHeartbeat events for Legends Modules.  This needs to be called from either the NWN2 stock
	// on heartbeat event for monsters or called from a custom on heartbeat event script or optionally called directly AS
	// the on heartbeat script.  First we determine if we were passed from another script or if we are called be the event.	
   	object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   	object oVariables = OBJECT_SELF;
   	object oTarget = OBJECT_SELF;

	// Make sure we are the player and not some familiar
	object oMaster = GetMaster(oPC);
	if (GetIsObjectValid(oMaster))
		oPC = oMaster;
	
	// Only run these events if there is a player nearby.  This may have to be removed for some
	// plugins in the heartbeat needs to fire even when there are no players around.
	if (GetIsPC(oPC))
	{
		// If the BANTER Plugin is active.
		if (GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
			ExecuteScript("leg_banter_daynight", oTarget);

		// If the INFO Plugin is active for criers.
		if (GetLocalInt(GetModule(), "LEG_INFO_ACTIVE"))
			ExecuteScript("leg_info_crierspeak", oTarget);
		
	}
}