/*
Filename:           hcr2_bleedtimer
System:             bleed system (timer hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 10th, 2006
Summary:
Called via ExecuteScript as a timer that is created and started when the hcr2_bleedsysopd
script is fired. Simulates blood loss for a dying player character.

-----------------
Revision: v1.05
Added checks for PartyMembersDyingFlag and custom H2_HP_ON_DEATH config variable.

Revision: v1.05b
Fixed error with bleeding and HPartyMembersDying campaign flag.
*/

#include "hcr2_bleedsystem_i"

void main()
{
	object oPC = OBJECT_SELF;
    int nPlayerState = h2_GetPlayerState(oPC);
	if (nPlayerState != H2_PLAYER_STATE_DYING && nPlayerState != H2_PLAYER_STATE_STABLE &&
        nPlayerState != H2_PLAYER_STATE_RECOVERING)
    {
		int nTimerID = GetLocalInt(oPC, H2_BLEED_TIMER_ID);
        DeleteLocalInt(oPC, H2_BLEED_TIMER_ID);
        DeleteLocalInt(oPC, H2_TIME_OF_LAST_BLEED_CHECK);
        h2_KillTimer(nTimerID);
    }
    else
    {
        int nCurrHitPoints = GetCurrentHitPoints(oPC);
		if (nCurrHitPoints > 0)
        {
            h2_MakePlayerFullyRecovered(oPC);
            return;
        }
        int nLastHitPoints = GetLocalInt(oPC, H2_LAST_HIT_POINTS);
		if (nCurrHitPoints > nLastHitPoints)
        {
			//h2_StabilizePlayer(oPC);
            return;
        }
		int nMinHP = -10;
		if (GetPartyMembersDyingFlag() == 1)
			nMinHP = GetMaxHitPoints(oPC) / -2;		
		if (nCurrHitPoints >= H2_HP_ON_DEATH && nCurrHitPoints > nMinHP)
		{       
			h2_CheckForSelfStabilize(oPC);        
		}
        else
        {
            h2_SetPlayerState(oPC, H2_PLAYER_STATE_DEAD);				
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);								
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPC);	
        }
    }
}