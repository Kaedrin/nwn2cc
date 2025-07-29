/*

    Script:			This script is the HBMan's heartbeat.  He controls what goes on in an area with respect to spawns.
					Note, he only exists if players are in an area.  If the area is empty, he does not exist.  Think
					of him like a spawned wandering Orc that you can't interact with and is only around when players
					are near.
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
#include "leg_fixed_ginc_time"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	object oArea = GetArea(OBJECT_SELF); 

	// Run this only once every minute.
	int iCurrentTime = LEG_COMMON_TimeStamp();
	int iLastTime = GetLocalInt(OBJECT_SELF, "LastTime");
	UpdateClockForAllPlayers();	  	
	
	if (iCurrentTime >= iLastTime + REAL_MINUTES)
	{
		if (!GetLocalInt(OBJECT_SELF, "STOP"))
		{
			//SpeakString("Firing Heartbeat.  Running checkspawns", TALKVOLUME_SHOUT);
			// Now we should see about spawning new stuff.
			LEG_SPAWN_CheckSpawns(oArea);
			SetLocalInt(OBJECT_SELF, "LastTime", iCurrentTime);
		}
	}

}