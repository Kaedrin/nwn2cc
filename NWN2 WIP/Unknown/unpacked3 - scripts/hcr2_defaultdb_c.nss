/*
Filename:           hcr2_defaultdb_c
System:             core  (default database persistence)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 core external database function user-configuration script.
This script should be consumed by h2_persistence_c as an include directive, if
the builder desires to use the default database as their means of campaign database storage.

-----------------
Revision: v1.02
Added h2_LogIn and h2_LogOut functions.
Adjusted player data saving to use database derived from
player name, in order to seperate per player character data
more effectively.

Revision: v1.05
Added some logging.
Fixed Get & SetPlayerState error, when possessing companions
*/

#include "hcr2_debug_i"

//A user defined constant that specifies the name of the database system being used.
//Examples: "Default Database",  "NWNX-MySQL",   etc..
const string H2_PERSISTENCE_SYSTEM_NAME = "Default Database";

//A user defined constant that specifies the name of the campaign associated
//with external database variable storage. This value will be used whenever
//any of the h2_Get\SetExternal functions are called and the campaign name is not specified.
const string H2_DEFAULT_CAMPAIGN_NAME = "HCR2_PWDATA";

//Begin generic external DB functions.
void h2_InitializeDatabase()
{
	PackCampaignDatabase(H2_DEFAULT_CAMPAIGN_NAME) ;
    return;
}

float h2_GetExternalFloat(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return GetCampaignFloat(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

int h2_GetExternalInt(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return GetCampaignInt(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

location h2_GetExternalLocation(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return GetCampaignLocation(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

string h2_GetExternalString(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return GetCampaignString(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

vector h2_GetExternalVector(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return GetCampaignVector(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

object h2_GetExternalObject(string sVarOrColumnName, location locLocation, object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return RetrieveCampaignObject(sCampaignOrTableName, sVarOrColumnName, locLocation, oOwner, oPlayer);
}

void h2_DeleteExternalVariable(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    DeleteCampaignVariable(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

void h2_SetExternalFloat(string sVarOrColumnName, float flFloat, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		h2_LogMessage(H2_LOG_WARN, "Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");		
    SetCampaignFloat(sCampaignOrTableName, sVarOrColumnName, flFloat, oPlayer);
}

void h2_SetExternalInt(string sVarOrColumnName, int nInt, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		h2_LogMessage(H2_LOG_WARN, "Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");	
    SetCampaignInt(sCampaignOrTableName, sVarOrColumnName, nInt, oPlayer);
}

void h2_SetExternalLocation(string sVarOrColumnName, location locLocation, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		h2_LogMessage(H2_LOG_WARN, "Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");	    
    SetCampaignLocation(sCampaignOrTableName, sVarOrColumnName, locLocation, oPlayer);
}

void h2_SetExternalString(string sVarOrColumnName, string sString, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		h2_LogMessage(H2_LOG_WARN, "Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");	
    SetCampaignString(sCampaignOrTableName, sVarOrColumnName, sString, oPlayer);
}

void h2_SetExternalVector(string sVarOrColumnName, vector vVector, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		h2_LogMessage(H2_LOG_WARN, "Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");	
    SetCampaignVector(sCampaignOrTableName, sVarOrColumnName, vVector, oPlayer);
}

int h2_SetExternalObject(string sVarOrColumnName, object oObject, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		h2_LogMessage(H2_LOG_WARN, "Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");	
    int bSuccess = StoreCampaignObject(sCampaignOrTableName, sVarOrColumnName, oObject, oPlayer);
    if (!bSuccess)
        h2_LogMessage(H2_LOG_WARN, "StoreCampaignObject failed on object " + GetResRef(oObject) + " to variable " + sVarOrColumnName);
    return bSuccess;
}
//end generic external DB functions

//Begin Custom defineable core function constants
//If you want to seperate the HCR2 core PW data into multiple DB files
//for this special information then change the value of the following constants.
//By default they are set equal to the existing default campaign name
const string H2_SERVER_DATE_INFO = H2_DEFAULT_CAMPAIGN_NAME;
const string H2_BANNED_LIST_INFO = H2_DEFAULT_CAMPAIGN_NAME;

//These constant merely represent variable names, you can alter their values if you wish but don't need to.
const string H2_PLAYER_STATE = "H2_PLAYER_STATE";
const string H2_SAVED_PC_LOCATION = "H2_SAVED_PC_LOCATION";
const string H2_REGISTERED_CHARS = "H2_REGISTERED_CHARS";
const string H2_CURRENT_YEAR = "H2_CURRENTYEAR";
const string H2_CURRENT_MONTH = "H2_CURRENTMONTH";
const string H2_CURRENT_DAY = "H2_CURRENTDAY";
const string H2_CURRENT_HOUR = "H2_CURRENTHOUR";
const string H2_CURRENT_MIN = "H2_CURRENTMIN";
const int H2_BAN_BY_CDKEY  = 0;
const int H2_BAN_BY_PLAYER_NAME = 1;
const int H2_BAN_BY_IPADDRESS = 2;
const string H2_BANNED_CD_KEY = "H2_BANNED_CD_KEY_";
const string H2_BANNED_NAME = "H2_BANNED_NAME_";
const string H2_BANNED_IPADDRESS = "H2_BANNED_IPADDRESS_";

//Begin core custom definable specialty functions
int h2_GetPlayerState(object oPC)
{
	if (GetIsOwnedByPlayer(oPC))
	{
		string sPlayerName = GetPCPlayerName(oPC);
		return h2_GetExternalInt(H2_PLAYER_STATE, oPC, sPlayerName);	
	}
	string sCompanionName = GetTag(oPC) + "_" + GetName(oPC);
	return h2_GetModLocalInt(H2_PLAYER_STATE + sCompanionName);
}

void h2_SetPlayerState(object oPC, int nPlayerState)
{
	if (!GetIsObjectValid(oPC))
		return;	
	if (GetIsOwnedByPlayer(oPC))
	{
		string sPlayerName = GetPCPlayerName(oPC);	
		h2_LogPlayerState( oPC, nPlayerState);
		h2_SetExternalInt(H2_PLAYER_STATE, nPlayerState, oPC, sPlayerName);
		return;
	}
	string sCompanionName = GetTag(oPC) + "_" + GetName(oPC);
	h2_SetModLocalInt(H2_PLAYER_STATE + sCompanionName, nPlayerState);
}

location h2_GetSavedPCLocation(object oPC)
{
	string sPlayerName = GetPCPlayerName(oPC);
	return h2_GetExternalLocation(H2_SAVED_PC_LOCATION, oPC, sPlayerName);
}

void h2_SavePCLocation(object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
		return;			
	if (GetIsObjectValid(GetArea(oPC)))
	{
		string sPlayerName = GetPCPlayerName(oPC);
		location loc = GetLocation(oPC);
		h2_SetExternalLocation(H2_SAVED_PC_LOCATION, loc, oPC, sPlayerName);
	}
	else
		DelayCommand(0.1, h2_SavePCLocation(oPC));		
}

int h2_GetRegisteredCharCount(object oPC)
{
	string sPlayerName = GetPCPlayerName(oPC);
	return h2_GetExternalInt(H2_REGISTERED_CHARS, OBJECT_INVALID, sPlayerName); 
}

void h2_SetRegisteredCharCount(object oPC, int nRegisteredChars)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
		return;
	string sPlayerName = GetPCPlayerName(oPC);		
	h2_SetExternalInt(H2_REGISTERED_CHARS, nRegisteredChars, OBJECT_INVALID, sPlayerName); 
}

void h2_SaveCurrentCalendar(int nYear = -1, int nMonth = -1, int nDay = -1, int nHour = -1, int nMinute = -1)
{
	if (nYear == -1)
		nYear = GetCalendarYear();
	if (nMonth == -1)
		nMonth = GetCalendarMonth();
	if (nDay == -1)
		nDay = GetCalendarDay();
	if (nHour == -1)
		nHour = GetTimeHour();
	if (nMinute == -1)
		nMinute = GetTimeMinute();								
    h2_SetExternalInt(H2_CURRENT_HOUR, nHour, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    h2_SetExternalInt(H2_CURRENT_DAY, nDay, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    h2_SetExternalInt(H2_CURRENT_MONTH, nMonth, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    h2_SetExternalInt(H2_CURRENT_YEAR, nYear, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    h2_SetExternalInt(H2_CURRENT_MIN, nMinute, OBJECT_INVALID, H2_SERVER_DATE_INFO);
}

void h2_RestoreSavedCalendar()
{
    int iCurYear = h2_GetExternalInt(H2_CURRENT_YEAR, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    int iCurMonth = h2_GetExternalInt(H2_CURRENT_MONTH, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    int iCurDay = h2_GetExternalInt(H2_CURRENT_DAY, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    int iCurHour = h2_GetExternalInt(H2_CURRENT_HOUR, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    int iCurMin = h2_GetExternalInt(H2_CURRENT_MIN, OBJECT_INVALID, H2_SERVER_DATE_INFO);
    if(iCurYear) 
	{
        SetTime(iCurHour, iCurMin, 0, 0);
        SetCalendar(iCurYear, iCurMonth, iCurDay);
    }
}

void h2_BanPC(object oPCToBan, object oBannedBy, int nBanMethod = H2_BAN_BY_CDKEY)
{
	string sMessage = GetPCPlayerName(oPCToBan) + "_" + GetName(oPCToBan) + " banned by: " + GetPCPlayerName(oBannedBy) + "_" + GetName(oBannedBy);    
	switch (nBanMethod)
	{
		case H2_BAN_BY_CDKEY:
			h2_SetExternalString(H2_BANNED_CD_KEY + GetPCPublicCDKey(oPCToBan), sMessage, OBJECT_INVALID, H2_BANNED_LIST_INFO);   
			break;
		case H2_BAN_BY_PLAYER_NAME:
			h2_SetExternalString(H2_BANNED_NAME + GetPCPlayerName(oPCToBan), sMessage, OBJECT_INVALID, H2_BANNED_LIST_INFO);   
			break;
		case H2_BAN_BY_IPADDRESS:
			h2_SetExternalString(H2_BANNED_IPADDRESS + GetPCIPAddress(oPCToBan), sMessage, OBJECT_INVALID, H2_BANNED_LIST_INFO);   
			break;
	}
	h2_LogMessage(H2_LOG_WARN, sMessage);
   	BootPC(oPCToBan);
}

int h2_GetIsBanned(object oPC)
{
	string sBannedByCDKey = h2_GetExternalString(H2_BANNED_CD_KEY + GetPCPublicCDKey(oPC), OBJECT_INVALID, H2_BANNED_LIST_INFO);
	string sBannedByName = h2_GetExternalString(H2_BANNED_NAME + GetPCPlayerName(oPC), OBJECT_INVALID, H2_BANNED_LIST_INFO);
	string sBannedByIPAddress = h2_GetExternalString(H2_BANNED_IPADDRESS + GetPCIPAddress(oPC), OBJECT_INVALID, H2_BANNED_LIST_INFO);

	if (sBannedByCDKey != "" || sBannedByName != "" || sBannedByIPAddress != "")
		return TRUE;
	return FALSE;		
}

//Updates appropriate persistent data on PC log-in.
void h2_LogInPC(object oPC)
{
	string sPlayerName = GetPCPlayerName(oPC);
	string sKey_IP = "KEYIP " + GetPCPublicCDKey(oPC) + "_" + GetPCIPAddress(oPC);
	h2_SetExternalString(sKey_IP, "~", OBJECT_INVALID, sPlayerName);
	int nPriorPCLogin = h2_GetExternalInt("DateCreated", oPC, sPlayerName);
	if (nPriorPCLogin == 0)
	{
		h2_SetExternalInt("DateCreated", 1, oPC, sPlayerName);
		h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
	}
	h2_SetExternalInt("Last Log-In", 1, oPC, sPlayerName);
}

//Updates appropriate persistent data on PC log-out.
void h2_LogOutPC(object oPC)
{
	string sPlayerName = GetLocalString(oPC, H2_PC_PLAYER_NAME);
	h2_SetExternalInt("Last Log-Off", 0, OBJECT_INVALID, sPlayerName);	
}

//End core custom definable specialty functions