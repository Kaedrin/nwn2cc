/*
Filename:           gui_hcr2_playermenu
System:             core (executed script called from the context menu)
Author:             Edward Beck (0100010)
Date Created:       Nov. 7th, 2006.
Summary:

This script is called via the modified contextmenu.xml UI.
It makes the PC player menu conversation appear.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
	AssignCommand(OBJECT_SELF, ActionStartConversation(OBJECT_SELF, H2_PLAYER_MENU_CONV, TRUE, FALSE, TRUE, TRUE));	
}