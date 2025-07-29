/*

    Script:			This is the magical despawn script for placeable objects.  Often used in an on-closed situation
					or sometimes in an onused situation.  Can be called via an execute script function in a custom
					on-closed or on-used.  The sole purpose is to trigger the de-spawn timer for the object.
	Version:		1.04
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		11/24/2010 - 1.00 MV - Initial Release
					11/26/2010 - 1.01 MV - Updated for the Legends Plugin System
					11/27/2010 - 1.02 MV - Changed name of script to be part of spawn system.
					12/21/2010 - 1.03 MV - Added support for Despawn timer of -1 to despawn right away
					09/19/2011 - 1.04 MV - Updated to support Spawn 1.42

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_spawn_include"





// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Should I despawn after I am closed?
	object oParent = GetLocalObject(OBJECT_SELF, "SPAWN_Parent");
	float fDespawn = IntToFloat(GetLocalInt(oParent, "LEG_SPAWN_OnUsedDeSpawnMins"));
	
	// If I'm 0.0 then I won't despawn at all.  Or, I may have already been told to despawn so don't do anything.
	if (fDespawn != 0.0 && GetLocalInt(OBJECT_SELF, "SPAWN_DeSpawnActive") == FALSE)
	{
		// if fDesspawn is -1.0 then we want to destroy this immediatly (or at least within 5 seconds).
		if (fDespawn < 0.0)
			fDespawn = 0.0;
			
		// Blow me up!  Yes, we are making plot go away when the timer starts but oh well LOL
		SetPlotFlag(OBJECT_SELF,FALSE);
		AssignCommand(OBJECT_SELF, SetIsDestroyable(TRUE, FALSE, FALSE));
		
		// Are we supposed to blow away my inventory?
		if (!GetLocalInt(oParent, "LEG_SPAWN_DropMyLoot"))
			DelayCommand(fDespawn * 60.0, LEG_COMMON_DestroyInventory(OBJECT_SELF));
			
		// Send me swimming with the fishes after the proper time has passed.
		DestroyObject(OBJECT_SELF, (fDespawn * 60.0) + 5.0);
		
		string sIndex = GetLocalString(OBJECT_SELF, "SPAWN_Index");
		SetLocalObject(oParent, "SPAWN_" + sIndex, OBJECT_INVALID);		
		LEG_COMMON_TimeOfDeath(OBJECT_SELF, oParent);
		
		// Don't let me timer reset over and over on multiple closes
		SetLocalInt(OBJECT_SELF, "SPAWN_DeSpawnActive", TRUE);
	}	
}
	