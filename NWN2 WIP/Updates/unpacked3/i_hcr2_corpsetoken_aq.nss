/*
Filename:           i_hcr2_corpsetoken_aq
System:             pc corpse (token corpse item script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 10th, 2006
Summary:
pccorpse item event script. (alternate item acquire script)
This script fires whenever the hcr2_corpsetoken items are aquired, unaquired, activated
or had a spell cast at it.

-----------------
Revision:

*/

void main()
{
	ExecuteScript("hcr2_corpsetoken", GetModule());
}