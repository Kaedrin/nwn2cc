/*

    Script:			This is the MASTER initialization script.  It goes in all areas OnClientEnter script OR is called
					from an existing OnClientEnter script. The purpose of this script is 3 fold.  First is to 
					initialize any system that requires a one-time initialization routine after a server reset.
					This could also be done during Module OnLoad but I find this to be more reliable.  The second 
					section is to initialize anything for a player since the last reset that requires a one time
					run - such as caching database variables for quests.  Lastly it performs any AreaOnEnter routines 
					that have to run whenever a player enters a new area such as activating spawns etc.
	Version:		1.60
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		11/26/2010 - 1.00 MV - Initial Release
					11/28/2010 - 1.01 MV - Bug fix in the event this script is called by another.	
					12/17/2010 - 1.02 MV - Added support for Quest Plugin
					12/19/2010 - 1.03 MV - Added support for Infobox Plugin
					06/23/2011 - 1.04 MV - Added support for Rest Plugin
					06/23/2011 - 1.05 MV - Added support for Tele Plugin
					06/27/2011 - 1.06 MV - Fixed bug, INFO pcinit was not being called.  Script name wrong.
					10/16/2011 - 1.60 MV - Fixed major bug in area despawn routines.

*/
#include "ginc_time"
// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// This should be placed in the OnClientEnter script field or called from there.  First we find out if
	// we were called via someone elses OnClientEnter script for the area or if we are the actual script for
	// that event.
	object oPC = OBJECT_SELF;		

	// Make sure we are the player and not some familiar
	object oMaster = GetMaster(oPC);
	if (GetIsObjectValid(oMaster))
		oPC = oMaster;

	// Use this is we are called direct, otherwise use what we were passed.
	if (!GetIsPC(oPC))
		oPC = GetFirstEnteringPC();

				
	if (GetIsPC(oPC))
	{
		SetGlobalInt(CAMPAIGN_SWITCH_ONLY_SHOW_TIME, TRUE);
		SetClockOnForPlayer(oPC, TRUE, FALSE);
		UpdateClockForAllPlayers();
		
		// Check for each module currently supported that requires an onload initialization.  These will only
		// run when the first player enters the world since the last server reset.  We put it here because
		// from my personal experience, OnModuleLoad events work sporadically at best.
		if (!GetLocalInt(GetModule(), "LEG_SYSTEMS_INIT"))
		{
			// Set the systems to initalized.
			SetLocalInt(GetModule(), "LEG_SYSTEMS_INIT", 1);
			
			// Check for the Legends BANTER Module
			if (GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
				ExecuteScript("leg_banter_init", GetModule());
				
			// Check for the Legends CRAFT plugin.
			if (GetLocalInt(GetModule(), "LEG_CRAFT_ACTIVE"))
				ExecuteScript("leg_craft_init", GetModule());
		}

		
		// Run any modules that require code applied to each entering player for the first time and 
		// only one time per server reset (like caching quest variables).
		if (!GetLocalInt(oPC, "LEG_PLAYER_INIT"))
		{
			if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
				ExecuteScript("leg_quest_pcinit", oPC);
			
			// See if the Infobox plugin is active
			if (GetLocalInt(GetModule(), "LEG_INFO_ACTIVE"))
				ExecuteScript("leg_info_pcinit", oPC);
			
			// See if the Crafting plugin is active
			if (GetLocalInt(GetModule(), "LEG_CRAFT_ACTIVE"))
				ExecuteScript("leg_craft_pcinit", oPC);
			
			// Set the Player to Initialized.
			SetLocalInt(oPC, "LEG_PLAYER_INIT", 1);
		}
		
		
		// Run any On Area Enter code for modules that need to run each time an area is entered.
		// SOD_LOOT, LEG_SPAWN etc

		// Check for the Legends SPAWN Module (also used in various other modules such as LOOT)
		if (GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
			ExecuteScript("leg_spawn_onenter", oPC);			
	
		// Check for the Quest Plugin.
		if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
			ExecuteScript("leg_quest_onenter", oPC);

		// Check for the Rest Plugin.
		if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
			ExecuteScript("leg_rest_onenter", oPC);

		// Check for the Tele Plugin.
		if (GetLocalInt(GetModule(), "LEG_TELE_ACTIVE"))
			ExecuteScript("leg_tele_onenter", oPC);
					
	}
}