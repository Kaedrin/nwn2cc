/*
Filename:           hcr2_playerroot_s
System:             core (hcr2_playermenuconv root node starting conditional)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

Starting conditional script that is fired when the
player menu conversation is first opened.

-----------------
Revision:

*/


#include "hcr2_core_i"

int StartingConditional()
{
	SetCustomToken(2147483600, H2_TEXT_PLAYER_DATA_ITEM_CONV_ROOT_NODE);
    SetCustomToken(2147483599, H2_TEXT_RETIRE_PC_MENU_OPTION);
    SetCustomToken(2147483598, H2_TEXT_PLAYER_DATA_MENU_NOTHING);
    return TRUE;
}