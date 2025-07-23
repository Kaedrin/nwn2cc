/*
Filename:           i_hcr2_corpsetoken_ci
System:             pc corpse (corpse token item script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 10th, 2006
Summary:
pccorpse item event script. (alternate item spell cast at script)
This script fires whenever the hcr2_corpsetoken item had a spell cast 
at it.

-----------------
Revision:

*/

void main()
{	
	ExecuteScript("hcr2_corpsetoken", OBJECT_SELF);
}