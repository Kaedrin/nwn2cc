/*
Filename:           hcr2_savelocation
System:             core (timer script to save location)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
An example for an executed Timer event
which saves the PC's location each time the script is fired from the elapsed timer.

-----------------
Revision: v1.02
Removed redundant code.

*/

#include "hcr2_core_i"

void main()
{
	h2_SavePCLocation(OBJECT_SELF);		    
}