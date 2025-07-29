/*

    Script:			This script spawns in what I like to call Mr. HBMAN.  He is an invisible placeable that acts as a
					controller for all spawning in an area.  If there are no people in an area, he does not exist.  This
					script is called from the Master Enter script when the spawning system is active.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		11/26/2010 - Updated to support Legends Master Modular Systems
	
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
		// Count the PC's and spawn Mr HB Man.
		object oArea = GetArea(OBJECT_SELF);
		if (!GetLocalInt(oArea, "SPAWN_AreaInit"))
			LEG_SPAWN_InitializeWPs(oArea);
		LEG_SPAWN_SpawnHBMan(oArea);
		int iTotalPC = GetLocalInt(oArea, "SPAWN_PCS");		
		iTotalPC++;
		if (iTotalPC <= 0)
			iTotalPC = 1;
		SetLocalInt(oArea, "SPAWN_PCS", iTotalPC);
}