/*
Filename:           hcr2_retirepc_a
System:             core (action script on dialog hcr2_retirepc)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

Action script for a dialog option that results in the PC getting retired.

-----------------
Revision:			Nocturne
Modified by:		August 16th, 2016
Summary:			Added hotfix to properly delete the PC and remove from the server vault. Duplicate script used rather than the proper 'nwnx_character'
					due to unresolved compilation error. Temporary hotfix; should be revised once 'nwnx_character' is sorted out.
*/

#include "hcr2_core_i"
//#include "noc_PC_delete_hotfix" // Added to call for the proper delete method
#include "nwnx_character"

// This method deletes the player character object.

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
    AssignCommand(GetModule(), DelayCommand( 1.0f, DeleteCharacter( oPC ) )); //Added: Actually deletes the PC
	
	//h2_BootPlayer(oPC, H2_TEXT_RETIRED_PC_BOOT, 10.0); - No longer needed. Kept for record/posterity.
}