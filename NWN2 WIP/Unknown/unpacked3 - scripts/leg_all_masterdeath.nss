/*

    Script:			This is the MASTER on death script.  It goes on all Dynamic Placeables, NPC's and monsters or 
					is called from an existing script via ExecuteScript function.  Like all Master Run Scripts, 
					this script examines which plugins are available and active and calls them.
	Version:		1.04
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		12/17/2010 - MV - Added support for Quest Plugin
					12/19/2010 - 1.02 MV - Added support for Info Plugin
					12/21/2010 - 1.03 MV - Added support for Info Criers
					07/08/2011 - 1.04 MV - Added support for Craft Plugin
	
*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_all_masterinclude"

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Master System for OnDeath events for Legends Modules.  This needs to be called from either the NWN2 stock
	// on death event for mobs/placeables or called from a custom on death event script or optionally called directly AS
	// the on death script.  First we determine if we were passed from another script or if we are called be the event.	
	object oPC = GetLastKiller();
	object oTarget = OBJECT_SELF;
	SetLocalObject(OBJECT_SELF, "XP_Winner", oPC);
		
	// Make sure we are the player and not some familiar
	object oMaster = GetMaster(oPC);
	if (GetIsObjectValid(oMaster))
		oPC = oMaster;

	// Only run these events if the killer was a player.  Well, that seemed like a good idea until we discovered PC's may
	// not kill ESCORTED dudes!
	//if (GetIsPC(oPC))
	//{
		
		// If the LOOT Plugin is active.
		if (GetLocalInt(GetModule(), "LEG_LOOT_ACTIVE") && GetLocalInt(GetModule(), "LEG_LOOT_ONDEATH"))
		{
			object oParent = GetLocalObject(OBJECT_SELF, "SPAWN_Parent");
			if (!GetIsObjectValid(oParent))
				oParent = OBJECT_SELF;
			else
			{
				if (GetLocalString(oParent, "LEG_LOOT_ID") != "")
					oParent = OBJECT_SELF;
			}
		
			// If the Spawn plugin says to not Drop Loot on Death, then we don't make loot at all here.
			// Of course if we are not using the spawn plugin at all, then go ahead and make loot.
			if (!GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE") || !GetLocalInt(GetLocalObject(oTarget, "SPAWN_Parent"),"LEG_SPAWN_DoNotDropMyLoot"))
			{
				AddScriptParameterObject(oPC);
				AddScriptParameterObject(oParent);
				ExecuteScriptEnhanced("leg_loot_makeloot", oTarget);
			}
		}
		
		// If the BANTER Plugin is active.
		if (GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
		{
			string sBanterDeathID = GetLocalString(oTarget, "LEG_BANTER_OnDeath");
			int iBanterDeathChance = GetLocalInt(oTarget, "LEG_BANTER_OnDeathChance");
			AddScriptParameterString(sBanterDeathID);
			AddScriptParameterInt(iBanterDeathChance);
			AddScriptParameterString("Death");
			ExecuteScriptEnhanced("leg_banter_speak", oTarget);
		}
		
		// If we are using the SPAWN Plugin we want to set some respawn times and other things.
		if (GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
		{
			ExecuteScriptEnhanced("leg_spawn_ondeath", oTarget);
		}
		
		// If the QUEST plugin is active, we have things to do when mobs die!
		if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		{
			ExecuteScript("leg_quest_ondeath", oTarget);
		}
		
		// If the CRAFT plugin is active, we have things to do when mobs die!
		if (GetLocalInt(GetModule(), "LEG_CRAFT_ACTIVE"))
		{
			ExecuteScript("leg_craft_ondeath", oTarget);
		}
		
		// If the INFO plugin is active.
		if (GetLocalInt(GetModule(), "LEG_INFO_ACTIVE"))
		{
			// Fire off any triggers.
			ExecuteScript("leg_info_trigger", oTarget);
			
			// See if we have to add this death event to any criers.
			if (GetLocalInt(OBJECT_SELF, "LEG_INFO_CrierAddMyDeath"))
			{
				AddScriptParameterString("At " + LEG_COMMON_GetTimeNon24(GetTimeHour(), LEG_COMMON_GetGameTimeMinute()) + " on " + LEG_COMMON_GetMonthName(GetCalendarMonth()) + " " + IntToString(GetCalendarDay()) + ", " + IntToString(GetCalendarYear()));
				AddScriptParameterString(GetName(oPC) + " defeated " + GetName(OBJECT_SELF) + "!  Well done!");
				AddScriptParameterString("");
				ExecuteScriptEnhanced("leg_info_crieradd", OBJECT_SELF);
			}	
		}
			
	//}
}