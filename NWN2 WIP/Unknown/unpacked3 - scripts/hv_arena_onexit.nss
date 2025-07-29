#include "hv_arena_inc"
#include "hcr2_core_i"

// On Exit of the arena - if there exiting PC has the challenger varibable
// and she is the last challenger - clean the arena and stop the challenge
void main()
{
	object oArea = OBJECT_SELF;
	object oPC = GetExitingObject();
	
	if (GetIsPC(oPC)) {
	
		int playercount = GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA);
        SetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA, playercount - 1);
	
		if ((GetLocalInt(oPC, ARENA_CHALLENGE_VAR) == 1)) {
			int nChallengersLeft = GetLocalInt(oArea, CHALLENGERS_COUNT);
			nChallengersLeft--;
			if (nChallengersLeft < 0)
				nChallengersLeft == 0;
			SetLocalInt(oArea, CHALLENGERS_COUNT, nChallengersLeft);
		
			// Check if the highest HD player left
			int nMaxHD = GetLocalInt(oArea, MAX_HD);
			int nPlayerHD = GetHitDice(oPC);
			if (nPlayerHD == nMaxHD)
				SetLocalInt(oArea, MAX_HD, 1);
		
			if (nChallengersLeft == 0) {
				CleanArena();
				SetLocalInt(oArea, CHALLENGE_RUNNING, FALSE);
				Announce("<C=teal>Where are the challengers?!");
			}
		}
	}
   h2_RunObjectEventScripts(H2_AREAEVENT_ON_EXIT, OBJECT_SELF);
}