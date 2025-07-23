/*
Filename:           hcr2_playerdeath_e
System:				core (player death event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerDeath Event.
This script should be attachted to the OnPlayerDeath event under
the scripts section of Module properties.

-----------------
Revision: v1.05
Altered logging code

*/

#include "hcr2_core_i"
#include "hv_arena_inc"

void main()
{
    object oPC = GetLastPlayerDied();

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
	
			// ressurect loser to 1 HP
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
		

			if (GetLocalInt(oPC, "PVP_KOd") == FALSE) { 
				// Knock them down with a shameful text over their head
				SetLocalInt(oPC, "PVP_KOd", TRUE); // we should only run this once otherwise players crash out.
				DelayCommand(300.0, SetLocalInt(oPC, "PVP_KOd", FALSE));
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 300.0);
				//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEthereal(), oPC, 30.0);
				AssignCommand(oPC, SpeakString("<C=red><b>**Knocked Out!**"));
				SendMessageToPC(oPC, "<C=red><b><i>You have been knocked out and unable to act. You are at the victor's mercy.");
			}
			return; // skip normal death system
		}
	}
	// @@@@@@@@@@@@@@@@@@@@@@ Ella out.
	
	
	
	SetLocalLocation(oPC, H2_LOCATION_LAST_DIED, GetLocation(oPC));
    h2_SetPlayerState(oPC, H2_PLAYER_STATE_DEAD);
    h2_RemoveEffects(oPC);
    object oKiller = GetLastHostileActor(oPC);
	string sDeathLog = GetName(oPC) + "_" + GetPCPlayerName(oPC) + H2_TEXT_LOG_PLAYER_HAS_DIED;
    sDeathLog += GetName(oKiller);
    if (GetIsPC(oKiller))
        sDeathLog += "_" + GetPCPlayerName(oKiller);
    sDeathLog += H2_TEXT_LOG_PLAYER_HAS_DIED2 + GetName(GetArea(oPC));
    h2_LogMessage(H2_LOG_INFO, sDeathLog);
    h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_DEATH);
}