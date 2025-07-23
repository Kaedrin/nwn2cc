/*
	nar_onexit
	
	Increments a tick if the area is empty.
	
	18/01/2011 - Narks 
*/

void main()
{
	if (GetLocalInt(OBJECT_SELF, "nar_nPlayerCount") == 0)
	{
		SetLocalInt(OBJECT_SELF, "nar_nResetTick", GetLocalInt(OBJECT_SELF, "nar_nResetTick") + 1);
	}
	
}