/*
Filename:           hcr2_retirepc_a
System:             core (action script on dialog hcr2_retirepc)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

Action script for a dialog option that results in the PC getting retired.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    object oPC = GetPCSpeaker();
    h2_MovePossessorInventory(oPC, TRUE);
    h2_MoveEquippedItems(oPC);
    h2_SetPlayerState(oPC, H2_PLAYER_STATE_RETIRED);    
	int nRegisteredCharCount = h2_GetRegisteredCharCount(oPC);
    h2_SetRegisteredCharCount(oPC, nRegisteredCharCount - 1);
    SendMessageToPC(oPC, H2_TEXT_TOTAL_REGISTERED_CHARS + IntToString(nRegisteredCharCount - 1));
    SendMessageToPC(oPC, H2_TEXT_MAX_REGISTERED_CHARS + IntToString(H2_REGISTERED_CHARACTERS_ALLOWED));
    h2_BootPlayer(oPC, H2_TEXT_RETIRED_PC_BOOT, 10.0);
}