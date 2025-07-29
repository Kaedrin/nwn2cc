/*
Filename:           cwhit_tracking
System:            
Author:             Chris Whitaker
Date Created:       Feb 15, 2011
Summary:
*/

#include "cwhit_tracking_core"

void main()
{
    object oPC = GetFirstPC();
	
    while(GetIsObjectValid(oPC) == TRUE)
    {
//	    SendMessageToPC(oPC, "Leaving Tracks");
		doTracking(oPC, GetLocalInt(oPC, "SHOW_TRACKING"));
		
        oPC = GetNextPC();
	}
}