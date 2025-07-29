/*
Filename:           hcr2_playerretire_a
System:             core (hcr2_playermenuconv menu node action script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

Action script that is fired when the retire pc menu item in the
player menu conversation is selected.

-----------------
Revision:

*/


#include "hcr2_core_i"

void main()
{
    AssignCommand(OBJECT_SELF, ActionStartConversation(OBJECT_SELF, H2_RETIRE_PC_MENU_CONV, TRUE, FALSE, TRUE));
}