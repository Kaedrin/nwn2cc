/*
Filename:           i_hcr2_firewood_ac
System:             player rest (firewood item script)
Author:             Edward Beck (0100010)
Date Created:       Dec 10th, 2006
Summary:
HCR2 h2_firewood item script. (alternate item activation script)
This script fires via tag based scripting for the OnActivate events for this item.

-----------------
Revision:

*/

void main()
{
    ExecuteScript("hcr2_firewood", GetModule());
}