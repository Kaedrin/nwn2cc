 /*
Filename:           hcr2_pcloaded_e
System:             core (PC Loaded event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPCloaded event script.
This script should be attachted to the OnPCLoaded event under
the scripts section of Module properties.

-----------------
Revision: v1.01
Script is aborted if H2_LOGIN_BOOT on the PC is TRUE.

Revision: v1.02
Added call to h2_LogInPC.
Moved h2_RegisterPC out of h2_InitializePC. It is now called for
Players and DMs from this script.

Revision: v1.05
Added call to add player skin
*/
#include "hcr2_core_i"
#include "ginc_time"
#include "alex_countspells"
#include "nwnx_srvadmin"

void main()
{        
	object oPC = GetEnteringObject();
	string 	sCDKey		= GetPCPublicCDKey(oPC);
	string 	sPlayer		= SQLEncodeSpecialChars(GetPCPlayerName(oPC));
	string 	sIPAddress	= GetPCIPAddress(oPC);
	string  sFirstName = GetFirstName(oPC);
	string  sLastName = GetLastName(oPC);
	string  sFirstLetter = GetStringLeft(sPlayer, 1);
	int bIsDM = GetIsDM(oPC);
	
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
	
	//SendMessageToPC(oPC, "You have "+ IntToString(nSpellCount)+" spells.");
	if (nSpellCount > 240)
	{	
		BootPC(oPC);
		return;
	}
	*/
	WriteTimestampedLogEntry(sPlayer + " is connecting using CD-Key " + sCDKey + " and using IPAddress " + sIPAddress + " and character " + sFirstName + " " + sLastName); 

		 
	if(!bIsDM)
	{
		if(GetStringLeft(sCDKey, 1) != "K" && GetStringLeft(sCDKey, 1) != "Y")
		{
			//illegal key
			BanPlayerIP(sPlayer);
			BanPlayerCDKey(sPlayer);
			BootPC(oPC);
			WriteTimestampedLogEntry(sPlayer + " is trying to register illegal CD-Key " + sCDKey + " and is using IPAddress " + sIPAddress);
			return;
		}
		if(sFirstLetter == "." || sFirstLetter == "/")
		{
			//illegal account
			BanPlayerIP(sPlayer);
			BanPlayerCDKey(sPlayer);
			BootPC(oPC);
			WriteTimestampedLogEntry(sPlayer + " is trying to register illegal CD-Key " + sCDKey + " and is using IPAddress " + sIPAddress);
			return;
		}
		if(countPlayerSpells(oPC)==1)
		{
			if(sPlayer != "Smithers666"  && sPlayer != "cdnspr")
			{
				//BootPC(oPC);
				BanPlayerIP(sPlayer);
				BanPlayerCDKey(sPlayer);
				BootPC(oPC);
				WriteTimestampedLogEntry(sPlayer + " has too many spells and using CD-Key " + sCDKey + " and is using IPAddress " + sIPAddress);
				return;
			}
		}
		
		//if(IsNewPlayer(oPC, sCDKey)==1)
		//{
			// Brand new CD-Key
			//Temporary safe guard in place
			//BootPC(oPC);
			//BanPlayerIP(sPlayer);
			//BanPlayerCDKey(sPlayer);
			//WriteTimestampedLogEntry(sPlayer + " is trying to register new CD-Key " + sCDKey + " and is using IPAddress " + sIPAddress);
			//return;
		//}
	}
	
	if (GetLocalInt(oPC, H2_LOGIN_BOOT))
	{
		string sBootMessage = GetLocalString(oPC, H2_BOOT_MESSAGE);
		SendMessageToPC(oPC, sBootMessage);
        return;
	}


    if (!H2_READ_CHECK)
        SendMessageToPC(oPC, H2_TEXT_SETTINGS_NOT_READ);
    else
        SendMessageToPC(oPC, H2_TEXT_ON_LOGIN_MESSAGE);
    
	string sCurrentGameTime = h2_GetCurrentGameTime(H2_SHOW_DAY_BEFORE_MONTH_IN_LOGIN);		
	SendMessageToPC(oPC, sCurrentGameTime);
	
    if (!bIsDM) {
		h2_LogInPC(oPC);
        h2_InitializePC(oPC);    
	}
 
    h2_RunModuleEventScripts(H2_EVENT_ON_PC_LOADED);
	
	//Do this after pcloaded hook-in scripts are executed. in case one of them 
	//added a skin already
	h2_AddPlayerSkin(oPC);
	//object oPC = GetEnteringObject();
	ExecuteScript("cmi_pc_loaded",oPC);
	
	//Turn on the sundial.
	SetClockOnForPlayer(oPC, TRUE);
	ExecuteScript("dmfi_mod_pcload", GetModule());
}