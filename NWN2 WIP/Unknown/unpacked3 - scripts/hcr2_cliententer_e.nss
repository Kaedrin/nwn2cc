/*
Filename:           hcr2_cliententer_e
System:             core (client enter event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnClientEnter Event.
This script should be attachted to the OnClientEnter event under
the scripts section of Module properties.

-----------------
Revision: v1.01
Dropped Max name length check as it was never needed.
Normal character creation limts first and last names to 15 
characters each.

*/
#include "hcr2_core_i"
//#include "mvd_02_init"

void main()
{
    object oPC = GetEnteringObject();
//	h2_SetAvailableSpellsToSavedValues(oPC);
    int bIsDM = GetIsDM(oPC);

	int bIsBanned = h2_GetIsBanned(oPC);
    if (bIsBanned)
    {
        SetLocalInt(oPC, H2_LOGIN_BOOT, TRUE);
        h2_BootPlayer(oPC, H2_TEXT_YOU_ARE_BANNED);
        return;
    }

    if (!bIsDM && h2_MaximumPlayersReached())
    {
        SetLocalInt(oPC, H2_LOGIN_BOOT, TRUE);
        h2_BootPlayer(oPC, H2_TEXT_SERVER_IS_FULL, 10.0);
        return;
    }

    if (!bIsDM && h2_GetModLocalInt(H2_MODULE_LOCKED))
    {
        SetLocalInt(oPC, H2_LOGIN_BOOT, TRUE);
        h2_BootPlayer(oPC, H2_TEXT_MODULE_LOCKED, 10.0);
        return;
    }

    int iPlayerState = h2_GetPlayerState(oPC);
    if (!bIsDM && iPlayerState == H2_PLAYER_STATE_RETIRED)
    {
        SetLocalInt(oPC, H2_LOGIN_BOOT, TRUE);
        h2_BootPlayer(oPC, H2_TEXT_RETIRED_PC_BOOT, 10.0);
        return;
    }

    if (!bIsDM && H2_REGISTERED_CHARACTERS_ALLOWED > 0 && GetXP(oPC) == 0)
    {
        int nRegisteredCharCount = h2_GetRegisteredCharCount(oPC);
        if (nRegisteredCharCount >= H2_REGISTERED_CHARACTERS_ALLOWED)
        {
            SetLocalInt(oPC, H2_LOGIN_BOOT, TRUE);
            h2_BootPlayer(oPC, H2_TEXT_TOO_MANY_CHARS_BOOT, 10.0);
            return;
        }
    }
    if (!bIsDM)
    {
        int iPlayerCount = h2_GetModLocalInt(H2_PLAYER_COUNT);
        h2_SetModLocalInt(H2_PLAYER_COUNT, iPlayerCount + 1);
    }

    SetLocalString(oPC, H2_PC_PLAYER_NAME, GetPCPlayerName(oPC));
    SetLocalString(oPC, H2_PC_CD_KEY, GetPCPublicCDKey(oPC));    

    h2_RunModuleEventScripts(H2_EVENT_ON_CLIENT_ENTER);

	//Mustang warning of spells
	/*
	int nSpellCount=0;
	int nSpell=0;
	while(nSpell<=2146)
	{
		if(GetSpellKnown(oPC, nSpell))
		{
			nSpellCount++;
		}
		nSpell++;
	}
	if(nSpellCount>=220)
	{
		SendMessageToPC(oPC, "Your spell count is currently at " + IntToString(nSpellCount) + ". Please contact a DM. A spellbook that contains over 240 spells will crash the server.");
		SendMessageToAllDMs(GetName(oPC) + " has currently " + IntToString(nSpellCount) + " spells in their spellbook. Speak to them so they don't crash the server.");
	}
	*/
	
	//Mustang Anti-Cheat
	//if(GetScale(oPC, SCALE_X) < 0.5 || GetScale(oPC, SCALE_Y) < 0.5 || GetScale(oPC, SCALE_Z) < 0.5)
	//{
	//	//cheater flag
	//}
	
	//hyper-vs addition
	// track spells
	int nSpellID;
	string sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK);
	while (sSpellTrack != "")
	{
	int index = FindSubString(sSpellTrack, ":");
	nSpellID = StringToInt(GetStringLeft(sSpellTrack, index));
	DecrementRemainingSpellUses(oPC, nSpellID);
	sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - (index+1));
	}
}