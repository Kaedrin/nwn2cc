//Default NESS script for disarmed NESS traps

#include "spawn_functions"
//
void main()
{
    // Retrieve Script Number
    int TrapDisarmScript = GetLocalInt(OBJECT_SELF, "TrapDisarmScript");
	

    // Invalid Script
    if (0 >= TrapDisarmScript)
    {
        return;
    }

    if (TrapDisarmScript > 0)
    {
//
// Only Make Modifications Between These Lines
//
        // Script 00
        // Dummy Script - Never Use
        if (TrapDisarmScript == 0)
        {
            return;
        }
		
		//sample disarm Script
		if (TrapDisarmScript == 1)
		{
			//give 25xp for disarming this trapy
			object oPC = GetLastDisarmed();
			if(GetIsObjectValid(oPC) && GetIsPC(oPC))
			{
				GiveXPToCreature(oPC, 25);
			}
		}

// -------------------------------------------
// Only Make Modifications Between These Lines
//
	}
}