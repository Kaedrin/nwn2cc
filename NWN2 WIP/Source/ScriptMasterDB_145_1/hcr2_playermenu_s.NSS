/*
Filename:           hcr2_playermenu_s
System:             core (hcr2_playermenuconv menu node starting conditional)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

Starting conditional script that is fired for each node
when the player menu conversation is opened.

-----------------
Revision:

*/


#include "hcr2_core_i"

int StartingConditional(int nIndex)
{
    string menutext = h2_GetModLocalString(H2_PLAYER_DATA_MENU_ITEM_TEXT + IntToString(nIndex));
    if (menutext == "")
        return FALSE;
    SetCustomToken(2147483600 + nIndex, menutext);
    return TRUE;
}