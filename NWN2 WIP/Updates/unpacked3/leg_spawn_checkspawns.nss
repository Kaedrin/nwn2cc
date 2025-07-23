/*

    Script:			This script allows other plugins to force a Check Spawn immediately rather than wait for the 
					HBMAN to fire which can take up to one minute.  Handy for when Quest Based Spawns need to appear
					as soon as a PC accepts a quest.
	Version:		1.00
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		12/16/2010 - Initial Release
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
	// Get the Area of the Caller if we need to spawn this in this area.  Otherwise, nothing will
	// happen and the spawn will activate when the PC enters the appropriate area.
	object oArea = GetArea(OBJECT_SELF); 

	// Now we should see about spawning new stuff.
	LEG_SPAWN_CheckSpawns(oArea);
}