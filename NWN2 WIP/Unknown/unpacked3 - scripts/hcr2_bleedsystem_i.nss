/*
Filename:           hcr2_bleedsystem_i
System:             bleed system (include script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 10th, 2006
Summary:
HCR2 h2_bleedsystem system function definition file.

-----------------
Revision: v1.01
Added support for ceasing hostile NPC actions when dying.

Revision: v1.03
Disabled StayDownFool animation fix. 
It causes too much lag.
Enabled support for forced bleeding.

Revision: v1.04
Re-enabled StayDownFool with configurable variable to 
turn it on or off (default is off)

Revision: v1.05
Made adjustments to work with companion bleeding

*/

#include "hcr2_core_i"
#include "hcr2_bleedsystem_c"
#include "NW_I0_GENERIC"

const string H2_BLEED_TIMER_SCRIPT = "hcr2_bleedtimer";
const string H2_LAST_HIT_POINTS = "H2_LASTHITPOINTS";
const string H2_BLEED_TIMER_ID = "H2_BLEEDTIMERID";
const string H2_TIME_OF_LAST_BLEED_CHECK = "H2_TIME_OF_LAST_BLEED_CHECK";
const string H2_LONG_TERM_CARE = "H2_LONG_TERM_CARE";
const string H2_BLEED_OUT = "H2_BLEED_OUT";
const string H2_SELF_STABILIZE = "H2_SELF_STABILIZE";
const string H2_SELF_RECOVERY = "H2_SELF_RECOVERY";

//Keeps the player down when in a dying state, 
//Workaround for animation bug.
void h2_StayDownFool(object oPC)
{
	if (GetIsDead(oPC))
	{
		PlayCustomAnimation(oPC, "proneB", TRUE);
		DelayCommand(0.01, h2_StayDownFool(oPC));
	}
	else
	{
		PlayCustomAnimation(oPC, "standupB", FALSE);  
		PlayCustomAnimation(oPC, "idle", TRUE);
	}	
}

//Gets the Self stabilization chance assigned to oPC)
int h2_GetSelfStabilizeChance(object oPC)
{
	return GetLocalInt(oPC, H2_SELF_STABILIZE);
}

//Gets the Self recovery chance assigned to oPC)
int h2_GetSelfRecoveryChance(object oPC)
{
	return GetLocalInt(oPC, H2_SELF_RECOVERY);
}

//Gets the Self stabilization chance assigned to oPC)
void h2_SetSelfStabilizeChance(object oPC, int nChance)
{
	if (nChance < 0) nChance = 0;
	if (nChance > 100) nChance = 100;
	SetLocalInt(oPC, H2_SELF_STABILIZE, nChance);
}

//Gets the Self stabilization chance assigned to oPC)
void h2_SetSelfRecoveryChance(object oPC, int nChance)
{
	if (nChance < 0) nChance = 0;
	if (nChance > 100) nChance = 100;
	SetLocalInt(oPC, H2_SELF_RECOVERY, nChance);
}

//Creates and starts a timer to track the bleeding of oPC.
void h2_BeginPlayerBleeding(object oPC)
{
	int nCurrentHitPoints = GetCurrentHitPoints(oPC);
	if (H2_FORCED_BLEED && nCurrentHitPoints < 0)
	{
		effect eHeal = EffectHeal(abs(nCurrentHitPoints));	
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);		
		nCurrentHitPoints = 0;
	}	
	SetLocalInt(oPC, H2_BLEED_OUT, TRUE);
    SetLocalInt(oPC, H2_LAST_HIT_POINTS, nCurrentHitPoints);
	SetLocalInt(oPC, "Bleeding", 0);
	if (GetLocalInt(oPC, H2_BLEED_TIMER_ID) == 0)
	{
    	int nTimerID = h2_CreateTimer(oPC, H2_BLEED_TIMER_SCRIPT, H2_BLEED_DELAY);
    	SetLocalInt(oPC, H2_BLEED_TIMER_ID, nTimerID);
    	DelayCommand(H2_BLEED_DELAY, h2_StartTimer(nTimerID));	
	}
	else
	{
		h2_LogMessage(H2_LOG_DEBUG, "Bleed timer already present.");
	}
}

//Makes the player oPC fully recover from a dying or stable state.
//This brings oPC to 1 HP and sets their player state to H2_PLAYER_STATE_ALIVE.
void h2_MakePlayerFullyRecovered(object oPC)
{
    int nCurrHitPoints = GetCurrentHitPoints(oPC);		
    if (nCurrHitPoints <= 0)
    {
        effect eHeal = EffectHeal(1 - nCurrHitPoints);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    }
    SendMessageToPC(oPC,  H2_TEXT_RECOVERED_FROM_DYING);
    DeleteLocalInt(oPC, H2_TIME_OF_LAST_BLEED_CHECK);
    h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
	DeleteLocalInt(oPC, H2_BLEED_OUT);
	int nTimerID = GetLocalInt(oPC, H2_BLEED_TIMER_ID);
    DeleteLocalInt(oPC, H2_BLEED_TIMER_ID);
    DeleteLocalInt(oPC, H2_TIME_OF_LAST_BLEED_CHECK);
	h2_KillTimer(nTimerID);
	//TODO: make monsters go hostile to PC again?
}

//Sets oPC's player state to H2_PLAYER_STATE_STABLE if oPC's player state was H2_PLAYER_STATE_DYING
//or makes oPC fully recovered if the oPC's player state was H2_PLAYER_STATE_STABLE
//and bDoFullRecovery is TRUE.
void h2_StabilizePlayer(object oPC, int bNaturalHeal = FALSE)
{
    int nPlayerState = h2_GetPlayerState(oPC);
    int nCurrentHitPoints = GetCurrentHitPoints(oPC);
    SetLocalInt(oPC, H2_LAST_HIT_POINTS, nCurrentHitPoints);
    if (nPlayerState == H2_PLAYER_STATE_DYING)
    {
        SendMessageToPC(oPC,  H2_TEXT_PLAYER_STABLIZED);
        if (bNaturalHeal)
		{
			h2_LogMessage(H2_LOG_DEBUG, GetName(oPC) + " has stabilized.");
            h2_SetPlayerState(oPC, H2_PLAYER_STATE_STABLE);
		}
        else
		{
			h2_LogMessage(H2_LOG_DEBUG, GetName(oPC) + " is recovering.");
            h2_SetPlayerState(oPC, H2_PLAYER_STATE_RECOVERING);
		}
        int nTimeOfBleedCheck = h2_GetSecondsSinceServerStart();
        SetLocalInt(oPC, H2_TIME_OF_LAST_BLEED_CHECK, nTimeOfBleedCheck);
    }
    else if (bNaturalHeal)
    {
        h2_MakePlayerFullyRecovered(oPC);
    }
    else
        h2_SetPlayerState(oPC, H2_PLAYER_STATE_RECOVERING);
}

//Causes bleed damage to oPC.
void h2_DoBleedDamageToPC(object oPC)
{
	int nTimeOfBleedCheck = h2_GetSecondsSinceServerStart();
    SetLocalInt(oPC, H2_TIME_OF_LAST_BLEED_CHECK, nTimeOfBleedCheck);	
	int nCurrentHitPoints = GetCurrentHitPoints(oPC);
	if(nCurrentHitPoints < GetLocalInt(oPC, H2_LAST_HIT_POINTS) || GetLocalInt(oPC, "Bleeding") == 0)
	{
		SetLocalInt(oPC, H2_LAST_HIT_POINTS, nCurrentHitPoints);
		SetLocalInt(oPC, "Bleeding", 1);
	    int nPlayerState = h2_GetPlayerState(oPC);
	    if (nPlayerState == H2_PLAYER_STATE_RECOVERING)
	        return;
	    switch(d6())
	    {
	        case 1: PlayVoiceChat(VOICE_CHAT_HELP, oPC); break;
	        case 2: PlayVoiceChat(VOICE_CHAT_PAIN1, oPC); break;
	        case 3: PlayVoiceChat(VOICE_CHAT_PAIN2, oPC); break;
	        case 4: PlayVoiceChat(VOICE_CHAT_PAIN3, oPC); break;
	        case 5: PlayVoiceChat(VOICE_CHAT_HEALME, oPC); break;
	        case 6: PlayVoiceChat(VOICE_CHAT_NEARDEATH, oPC); break;
	    }
	    SendMessageToPC(oPC, H2_TEXT_WOUNDS_BLEED);
	    effect eBloodloss = EffectDamage(H2_BLEED_BLOOD_LOSS, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_ENERGY, TRUE);
	    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBloodloss, oPC);
	}
	else
	{
		SetLocalInt(oPC, H2_LAST_HIT_POINTS, nCurrentHitPoints);
		SendMessageToPC(oPC, "Your wounds are recovering from near death.");
		effect eRecovery = EffectHeal(1);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eRecovery, oPC);
	}		
}

//Checks to see if oPC was able to stabilize on their own, if not
//bleed damage is done to oPC.
void h2_CheckForSelfStabilize(object oPC)
{
    int nPlayerState = h2_GetPlayerState(oPC);
    int nStabilizeChance = h2_GetSelfStabilizeChance(oPC);
    if (nPlayerState == H2_PLAYER_STATE_STABLE || nPlayerState == H2_PLAYER_STATE_RECOVERING)
        nStabilizeChance = h2_GetSelfRecoveryChance(oPC);

    int nLastCheck = GetLocalInt(oPC, H2_TIME_OF_LAST_BLEED_CHECK);
    int nSecondsSinceLastCheck = h2_GetSecondsSinceServerStart() - nLastCheck;
    if (nPlayerState == H2_PLAYER_STATE_DYING || nSecondsSinceLastCheck >= FloatToInt(H2_STABLE_DELAY))
    {
		//SendMessageToPC(oPC, "Self Stabilize is " + IntToString(nStabilizeChance));
        //if (d100() <= nStabilizeChance)
		
		/*
		int random = d20();
		SendMessageToPC(oPC, "Fortitude Save Roll " + IntToString(random) + " + " + IntToString(GetFortitudeSavingThrow(oPC)));
		if(((GetFortitudeSavingThrow(oPC) + random) > 25 && random > 1) || random==20 ) 
		{
            h2_StabilizePlayer(oPC, TRUE);
			SendMessageToPC(oPC, "You slightly recover from the bleeding.");
		}
        else
		{*/
			//SendMessageToPC(oPC, "Your body nears closer to death.");
            h2_DoBleedDamageToPC(oPC);
		//}
    }
}

//Handles when the healing skill widget is used on a target.
void h2_UseHealSkillOnTarget(object oTarget, object oUser, object oItemUsed)
{
    int nRollResult;
	int nRollBonus = 0;
	if (GetTag(oItemUsed) == H2_HEALERS_KIT)	
			nRollBonus = 2;
    if (GetIsPC(oTarget) || GetIsOwnedByPlayer(oTarget) || GetIsRosterMember(oTarget))
    {
        if (oTarget == oUser)
        {
            SendMessageToPC(oUser, H2_TEXT_CANNOT_USE_ON_SELF);
            return;
        }
        int nPlayerState = h2_GetPlayerState(oTarget);				
        switch (nPlayerState)
        {
            case H2_PLAYER_STATE_DEAD:
                SendMessageToPC(oUser, H2_TEXT_CANNOT_RENDER_AID);
                break;
            case H2_PLAYER_STATE_DYING:
            case H2_PLAYER_STATE_STABLE:
                nRollResult = h2_SkillCheck(SKILL_HEAL, oUser, nRollBonus);
                if (nRollResult >= H2_FIRST_AID_DC)
                {
                    h2_SetPlayerState(oTarget, H2_PLAYER_STATE_RECOVERING);
                    SendMessageToPC(oTarget,  H2_TEXT_PLAYER_STABLIZED);
                    SendMessageToPC(oUser, H2_TEXT_FIRST_AID_SUCCESS);
                }
                else
                    SendMessageToPC(oUser, H2_TEXT_FIRST_AID_FAILED);
                break;
            case H2_PLAYER_STATE_RECOVERING:
                SendMessageToPC(oUser, H2_TEXT_ALREADY_TENDED);
                break;
            case H2_PLAYER_STATE_ALIVE:
            	if (GetCurrentHitPoints(oTarget) >= GetMaxHitPoints(oTarget))
            	{
                    SendMessageToPC(oUser, H2_TEXT_DOES_NOT_NEED_AID);
                    return;
                }
                nRollResult = h2_SkillCheck(SKILL_HEAL, oUser, nRollBonus, 0);
                if (nRollResult >= H2_LONG_TERM_CARE_DC)
                    SetLocalInt(oTarget, H2_LONG_TERM_CARE, 1);
                SendMessageToPC(oUser, H2_TEXT_ATTEMPT_LONG_TERM_CARE);
                SendMessageToPC(oTarget, H2_TEXT_RECEIVE_LONG_TERM_CARE);
                break;
        }
    }
    else //Target was not a PC, just Roll result and let DM decide what happens
        h2_SkillCheck(SKILL_HEAL, oUser, nRollBonus);
}

void h2_SignalAttackerTargetIsDown(object oBleeder)
{
	object oAttacker = GetLastDamager(oBleeder);
	if (GetIsPC(oAttacker))
		return;
	if (H2_CEASE_NPC_ATTACKS_ON_DYING && GetIsObjectValid(oAttacker))
	{
		AssignCommand(oAttacker, ClearAllActions());
		AssignCommand(oAttacker, DetermineCombatRound());
	}
	SignalEvent(oAttacker, EventUserDefined(H2_TARGET_IS_DOWN_EVENT_NUMBER));
}