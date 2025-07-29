/*

    Script:			This script is the spawning system on Exit script called from the Master On Exit script when the
					spawning plugin is active.  It performs a cleanup of all creatures and placeable objects in an
					area that uses the spawning system as well as cleaning up the HBMan himself.
	Version:		1.60
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		11/26/2010 - Initial Release
					10/16/2011 - 1.60 MV - Fixed major bug in area despawn routines.
	
*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_spawn_include"





// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(object oArea)
{
		//object oArea = GetArea(OBJECT_SELF);
		int iTotalPC = GetLocalInt(oArea, "SPAWN_PCS");
		iTotalPC--;
		
		// If there are no more PC's in the area, tell the heartbeat manager for the area
		// to blow himself to kingdom come.
		if (iTotalPC == 0)
		{
			if (!GetLocalInt(GetModule(), "INSTANCE"))
				LEG_SPAWN_DeSpawnArea(oArea);
				DelayCommand(10.0, LEG_SPAWN_DeSpawnHBMan(oArea));	
		}
		SetLocalInt(oArea, "SPAWN_PCS", iTotalPC);


}