/*
Filename:           hcr2_campfiredeath_e
System:             player rest (campfire destroyed event)
Author:             Edward Beck (0100010)
Date Created:       Nov. 26th, 2006
Summary:
HCR2 campfire destroyed event script.
This script is attached to the on destroyed event of the hcr2_campfire placeable.

-----------------
Revision: 

*/

#include "hcr2_playerrest_i"

void main()
{
		h2_DestroyCampfire(OBJECT_SELF);
}