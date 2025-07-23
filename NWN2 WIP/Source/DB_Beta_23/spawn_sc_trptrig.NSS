//Default NESS script for triggered NESS traps
//Trigger scripts "replace" any damage or effects
//
#include "spawn_functions"
//
void main()
{
    // Retrieve Script Number
    int TrapTriggerScript = GetLocalInt(OBJECT_SELF, "TrapTriggerScript");
	

    // Invalid Script
    if (0 >= TrapTriggerScript)
    {
        return;
    }

    if (TrapTriggerScript > 0)
    {
//
// Only Make Modifications Between These Lines
//
        // Script 00
        // Dummy Script - Never Use
        if (TrapTriggerScript == 0)
        {
            return;
        }
		
		//sample trigger script
		if (TrapTriggerScript == 1)
		{
			//Fire an average projectile bolt (default script
			ExecuteScript("x0_trapavg_bolt", OBJECT_SELF);
		}

// -------------------------------------------
// Only Make Modifications Between These Lines
//
	}
}