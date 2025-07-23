/*
Filename:           hcr2_playerdying_e
System:             core (player dying event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerDying Event.
This script should be attachted to the OnPlayerDying event under
the scripts section of Module properties.

-----------------
Revision:

*/

#include "hcr2_core_i"
#include "hv_arena_inc"

void main()
{
    object oPC = GetLastPlayerDying();

	// Arena death
	object oArea = GetArea(oPC);
	if (GetTag(oArea) == "hv_arena") {
		//if (GetLocalInt(oPC, ARENA_CHALLENGE_VAR) == 1) {
			AssignCommand(oArea, RemoveChallengerFromArena(oPC));
			//ExecuteScript("hv_arena_onplayerdeath", oArea);
			return;
		//}
	}
	
	// Ella's addition - if attacker has KO mode on,
	// just knock the loser down and leave it at 1 HP.
	object oWinner = GetLastHostileActor(oPC);
	
	if (((GetIsPC(oWinner)) && (GetLocalInt(oWinner, "hv_ko_mode") == 0)) || ((GetIsPC(GetMaster(oWinner))) && (GetLocalInt(GetMaster(oWinner), "hv_ko_mode") == 0))) {
	
		// Added check - Not a DM or NPC possessed by one.
		if ((!GetIsDM(oWinner)) && (!GetIsDMPossessed(oWinner))) {
	
			// Clear all actions for both parties
			AssignCommand(oPC, ClearAllActions(TRUE));
			AssignCommand(oWinner, ClearAllActions(TRUE));
	
			// Heal loser to 1 HP
			int nCurrentHP = GetCurrentHitPoints(oPC);
			int nToHeal = (0 - nCurrentHP) + 1;
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nToHeal), oPC);
		
			// Kock them down with a shameful text
			// over their head
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 300.0);
			//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEthereal(), oPC, 30.0);
			AssignCommand(oPC, SpeakString("<C=red><b>**Knocked Out!**"));
			SendMessageToPC(oPC, "<C=red><b><i>You have been knocked out and unable to act. You are at the victor's mercy.");
			return; // skip normal death system
		}
	}
	// @@@@@@@@@@@@@@@@@@@@@@ Ella out.
	
    if (h2_GetPlayerState(oPC) != H2_PLAYER_STATE_DEAD)
        h2_SetPlayerState(oPC, H2_PLAYER_STATE_DYING);
    h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_DYING);
}