/*
Author: 		DM_Nocturne
Created: 		September 26, 2013
Last Modified:	September 26, 2013
Description:

Sends a message to the speaking PC's player (should be attached to a conversation)
informing them of their last saved location (generally where they logged out).
*/

#include "hcr2_persistence_c"

void main()
{
	object oPC = GetPCSpeaker();
    location lLoc = h2_GetSavedPCLocation(oPC);
	if (GetIsObjectValid(GetAreaFromLocation(lLoc)))
        {
			string areaName = GetName(GetAreaFromLocation(lLoc));
	    	SendMessageToPC(oPC, "Your last saved location was " + areaName + ".");
	    }
	    else
	    {
        	SendMessageToPC(oPC, "No saved location or invalid saved location.");	  
	    }
}