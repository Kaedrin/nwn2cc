/*
Filename:           i_hcr2_healerskit_ac
System:             bleed system (healer's kit item script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 22nd, 2006
Summary:
bleed system item event script. (alternate item activation script)
This script fires whenever the hcr2_healerskit items are  activated.

Revision Info should only be included for post-release revisions.
-----------------
Revision:

*/

void main()
{
	ExecuteScript("hcr2_healerskit", GetModule());
}