/*
Filename:           hcr2_debug_i
System:             core (debugging include script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 core function definitions for special debugging functions.
This file holds the commonly used  debugging functions, used throughout the core HCR2 system.
It is accessible from hcr2_timers_i and hcr2_core_i.

-----------------
Revision: v1.05
Added Log level constants and enhacined log reporting functions.
Adjusted include orders.
*/

#include "hcr2_locals_i"

string h2_ScriptName = "";
string h2_TestFunctionName;
int h2_TestPassed;

const int H2_LOG_ERROR = 1;
const int H2_LOG_WARN = 2;
const int H2_LOG_INFO = 3;
const int H2_LOG_DEBUG = 4;
const string H2_LOGLEVEL = "H2_LOGLEVEL";

void h2_SendMessageToAllPCs(string message)
{
    object oPC = GetFirstPC(FALSE);
    while (GetIsObjectValid(oPC)) {
        SendMessageToPC(oPC,message);
        oPC = GetNextPC(FALSE);
    }
}

void h2_LogUnitTestMessage(string message)
{	
    WriteTimestampedLogEntry(message);
    h2_SendMessageToAllPCs(message);
}

void h2_RunTestSuite(string sTestSuiteScriptName, object oTarget=OBJECT_SELF)
{
	h2_LogUnitTestMessage("Now Running " + sTestSuiteScriptName);
	ExecuteScript(sTestSuiteScriptName, oTarget);
}

void h2_SetUp(string functionName)
{
    h2_TestFunctionName = functionName;
    h2_TestPassed = TRUE;    
}

void h2_TearDown()
{
    if (h2_TestPassed) 
		h2_LogUnitTestMessage(h2_TestFunctionName + " PASSED.");
    else 
		h2_LogUnitTestMessage(h2_TestFunctionName + " FAILED.");
}

void h2_LogCompareFailure(string sActual, string sExpected, string sDataType)
{
	h2_TestPassed = FALSE;
    string message = h2_TestFunctionName + " FAILED. Expected " + sDataType + " " + sExpected + " but was " + sActual;
    h2_LogUnitTestMessage(message);
}

int h2_TestCompareInts(int nActual, int nExpected, int bIgnoreFailure = FALSE)
{    
    if (nActual == nExpected)
		return TRUE;
	if (!bIgnoreFailure)		
		h2_LogCompareFailure(IntToString(nActual), IntToString(nExpected), "integer");
    return FALSE;
}

int h2_TestCompareStrings(string sActual, string sExpected, int bIgnoreFailure = FALSE)
{
    if (sActual == sExpected)
		return TRUE;
	if (!bIgnoreFailure)
    	h2_LogCompareFailure(sActual, sExpected, "string");
    return FALSE;
}

int h2_TestCompareFloats(float fActual, float fExpected, int bIgnoreFailure = FALSE)
{
    if (fActual == fExpected)
		return TRUE;
	if (!bIgnoreFailure)
    	h2_LogCompareFailure(FloatToString(fActual), FloatToString(fExpected), "float");
    return FALSE;
}

int h2_TestCompareLocations(location locActual, location locExpected, int bIgnoreFailure = FALSE)
{
	 if (locActual == locExpected)
		return TRUE;
 	if (!bIgnoreFailure)
	{  
		h2_TestPassed = FALSE;        
		h2_LogUnitTestMessage(h2_TestFunctionName + " FAILED location equality test.");
		string message = "Area of Actual location: " + GetTag(GetAreaFromLocation(locActual));
		h2_LogUnitTestMessage(message);
		message = "Area of Expected location: " + GetTag(GetAreaFromLocation(locExpected));
		h2_LogUnitTestMessage(message);
		vector vActual = GetPositionFromLocation(locActual);
		vector vExpected = GetPositionFromLocation(locExpected);
		message = "Vector of Actual location: " + FloatToString(vActual.x) + "," +  FloatToString(vActual.y) + "," + FloatToString(vActual.z);
		h2_LogUnitTestMessage(message);
		message = "Vector of Expected location: " + FloatToString(vExpected.x) + "," +  FloatToString(vExpected.y) + "," + FloatToString(vExpected.z);
		h2_LogUnitTestMessage(message); 
	}       
	return FALSE;
}

int h2_TestCompareObjects(object oActual, object oExpected, int bIgnoreFailure = FALSE)
{
	 if (oActual == oExpected)
		return TRUE;
	if (!GetIsObjectValid(oActual)	&& !GetIsObjectValid(oExpected))	
		return TRUE;
  	if (!bIgnoreFailure)
	{
	 	h2_TestPassed = FALSE;        
		h2_LogUnitTestMessage(h2_TestFunctionName + " FAILED object equality test.");	
		string message;
		if (GetIsObjectValid(oActual))
		    message = "Actual Object: " + GetName(oActual) + "|" + GetTag(oActual) + "|" + GetResRef(oActual) + " |" + ObjectToString(oActual);
		else
		    message = "Actual Object: OBJECT_INVALID";
		h2_LogUnitTestMessage(message);
		
		if (GetIsObjectValid(oExpected))
		    message = "Expected Object: " + GetName(oExpected) + "|" + GetTag(oExpected) + "|" + GetResRef(oExpected) + " |" + ObjectToString(oExpected);
		else
		    message = "Expected Object: OBJECT_INVALID";
		h2_LogUnitTestMessage(message);       
	}
	return FALSE;
}

int h2_TestCompareVectors(vector vActual, vector vExpected, int bIgnoreFailure = FALSE)
{
	if (vActual == vExpected)
		return TRUE;
	if (!bIgnoreFailure)
	{
	 	h2_TestPassed = FALSE;        
		h2_LogUnitTestMessage(h2_TestFunctionName + " FAILED vector equality test.");
		string message = "Actual Vector: " + FloatToString(vActual.x) + "," +  FloatToString(vActual.y) + "," + FloatToString(vActual.z);
		h2_LogUnitTestMessage(message);
		message = "Expected Vector: " +  FloatToString(vExpected.x) + "," +  FloatToString(vExpected.y) + "," + FloatToString(vExpected.z);
		h2_LogUnitTestMessage(message);        
	}
	return FALSE;
}

//This function will prepend a message with "H2_LOG_{LOGLEVEL}: " and write the given
//message to the log file, as well as send it to the DM channel 
//nLogLevel can be H2_LOG_ERROR, H2_LOG_WARN, H2_LOG_INFO, or H2_LOG_DEBUG
//sMessage = debug message to write and/or send.
void h2_LogMessage(int nLogLevel, string sMessage)
{
	int nActiveLogLevel = h2_GetModLocalInt(H2_LOGLEVEL);
	if (nLogLevel > nActiveLogLevel)
		return;
		
	switch (nLogLevel)
	{
   		case H2_LOG_ERROR: sMessage = "HCR2_ERROR: " + sMessage; break;
		case H2_LOG_WARN: sMessage = "HCR2_WARN: " + sMessage; break;
		case H2_LOG_INFO: sMessage = "HCR2_INFO: " + sMessage; break;
		case H2_LOG_DEBUG: sMessage = "HCR2_DEBUG: " + sMessage; break;
		default: return;
	}
	WriteTimestampedLogEntry(sMessage);	
   	SendMessageToAllDMs(sMessage);
}

void h2_LogPlayerState(object oPC, int nPlayerState)
{
	string sPlayerState = "ALIVE";
	switch (nPlayerState)
	{
		case H2_PLAYER_STATE_DYING: sPlayerState = "DYING"; break;
		case H2_PLAYER_STATE_RECOVERING: sPlayerState = "RECOVERING"; break;
		case H2_PLAYER_STATE_STABLE: sPlayerState = "STABLE"; break;
		case H2_PLAYER_STATE_DEAD: sPlayerState = "DEAD"; break;
		case H2_PLAYER_STATE_RETIRED: sPlayerState = "RETIRED"; break;
	}
	string name = GetPCPlayerName(oPC) + "_" + GetName(oPC);
	if (!GetIsOwnedByPlayer(oPC))
		name = GetTag(oPC) + "_" + GetName(oPC);	
	h2_LogMessage(H2_LOG_DEBUG, "SetPlayerState " + name + " to " + sPlayerState);	
}