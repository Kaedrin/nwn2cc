/*
	nar_onexit
	
	Decrements the number of players in an area.
	
	After a period of time, if the area is empty of players:
	 - the types and positions of all monsters in the area are remembered
	 - the area is cleared of monsters
	This is done in script "nar_tryclear".
	
	Possible bug to make monsters clear earlier:
	  - monster clear delay is set to 1 minute
	  - 0:00 player leaves area, delaycommand (A) is fired
	  - 0:30 player enters area then leaves area, delaycommand (B) is fired
	  - 1:00 (A) fires, area is empty of players, monsters are cleared
	  - 1:15 player returns to area then leaves, delaycommand (C) is fired
	  - 1:30 (B) fires, area is empty of players, monsters are cleared (too early!)
	  - 2:25 (C) fires, area has cleared flag set, ignore
	Not important enough to fix.
	
	Another bug:
	 - monster clear delay is set to 1 minute
	 - current reset timer is at 1 heartbeat before a reset
	 - 0:00 player leaves area, delaycommand (A) is fired
	 - 0:06 area is reset
	 - 1:00 area is cleared of monsters as there are no players
	Also not important enough to fix.
	
	18/01/2011 - Narks 
*/

void main()
{
	if (GetIsPC(GetExitingObject()))
	{
		int nPlayerCount = GetLocalInt(OBJECT_SELF, "nar_nPlayerCount");
		SetLocalInt(OBJECT_SELF, "nar_nPlayerCount", nPlayerCount - 1);
		
		// If this is the last player, and the area is not already marked as cleared.
		if (nPlayerCount == 1)
		{
			DelayCommand(120., ExecuteScript("nar_tryclear", OBJECT_SELF));
		}
	}
}