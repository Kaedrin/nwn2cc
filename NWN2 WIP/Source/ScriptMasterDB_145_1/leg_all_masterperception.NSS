/*

    Script:			This is the MASTER on perception script.  It goes on all NPC's and monsters or is called from an
					existing perception script via ExecuteScript function.  Like all Master Run Scripts, this script 
					examines which plugins are available and active and calls them.
	Version:		1.01
	Plugin Version: 1.7
	Last Update:	12/17/2010
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		12/17/2010 - MV - Added support for Quest Plugin
	
*/

void LEG_BANTER_PERCEP_CallSpeak(string sBanterPercepID, object oTarget)
{
		// Get the Chance for perception messages and speak.
		int iBanterPercepChance = GetLocalInt(oTarget, "LEG_BANTER_OnPercepChance");
		AddScriptParameterString(sBanterPercepID);
		AddScriptParameterInt(iBanterPercepChance);
		AddScriptParameterString("Percep");
		ExecuteScriptEnhanced("leg_banter_speak", oTarget);
}

void LEG_BANTER_PERCEP_Heard(object oTarget)
{
	// Function used to delay the Heard Action, allowing time enough for the NPC
	// to see the PC first.
	if (!GetLocalInt(oTarget, "BANTERPCSEEN"))
		LEG_BANTER_PERCEP_CallSpeak(GetLocalString(oTarget, "LEG_BANTER_OnPercepHeard"), oTarget);

}
// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Master System for OnPerception events for Legends Modules.  This needs to be called from either the NWN2 stock
	// on perception event for monsters or called from a custom on perception event script or optionally called directly AS
	// the on perception script.  First we determine if we were passed from another script or if we are called be the event.	
   	object oPC = GetLastPerceived();
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
		// If the LOOT Plugin is active.
		// LOOT Plugin does not have a heartbeat requirement.
		
		// If the BANTER Plugin is active.
		if (GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
		{
			// Don't do anything if we are in the middle of a fight for a perception BANTER.
			if (!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
			{
				// Find out which perception type we fired.
				string sBanterPercepID;
				if (GetLastPerceptionSeen() && !GetLocalInt(OBJECT_SELF, "BANTERPCHEARD"))
				{
					SetLocalInt(OBJECT_SELF, "BANTERPCSEEN", 1);
					LEG_BANTER_PERCEP_CallSpeak(GetLocalString(oTarget, "LEG_BANTER_OnPercep"), OBJECT_SELF);
				}
				else if (GetLastPerceptionHeard() && !GetLocalInt(OBJECT_SELF, "BANTERPCSEEN"))
				{
					// We only want to fire this if we are not about to see the PC.  Seems that
					// hearing the PC is fired pretty much the same time Seeing the PC is.  What a pain.
					DelayCommand(2.0, LEG_BANTER_PERCEP_Heard(OBJECT_SELF));
				}
				else if (GetLastPerceptionVanished())
				{
					SetLocalInt(OBJECT_SELF, "BANTERPCSEEN", 0);	
					LEG_BANTER_PERCEP_CallSpeak(GetLocalString(oTarget, "LEG_BANTER_OnPercepVanished"), OBJECT_SELF);
				}
			}
		}
		
		// Quest Plugin Perception.  The quest plugin will use the perception event strictly for
		// quest givers when the ICON configuration is active.
		if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			ExecuteScriptEnhanced("leg_quest_onperception", OBJECT_SELF);
		}
	}
}