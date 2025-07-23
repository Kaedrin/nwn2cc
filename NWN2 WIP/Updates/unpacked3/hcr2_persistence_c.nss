/*
Filename:           hcr2_persistence_c
System:	            core (persistence user configuration file)
Author:				Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

This script is consumed by h2_persistence_i as an include directive.

Contains user definable functions and constants for the persistance subsystem.
Should contains include directives for additional files needed by the user,
and any _t scripts (text string definition scripts).

This script is editable by the mod builder. It should not contain any h2 functions that should
not be overrideable by the user, put those in h2_persistence_i.

-----------------
Revision: v1.02
Added h2_LogIn and h2_LogOut functions.

Revision: v1.03
Uncommented Get/SetRegisteredCharCount
*/

#include "hcr2_mysqldb_c"
//#include "hcr2_defaultdb_c"

//------------------------DO NOT EDIT BELOW THIS LINE--------------------------------

//All below functions and constants may be overriden by the user, but do not alter the prototyped function
//signature or the name of the constants, merely edit the contents of the function within the include
//file that you have specified to use above.

//See h2_defaultdb_c as an example of how the internal code of the below functions is defined
//and how to what value the constants are set.

//The below commented out constants must be defined with the same variable name in the include
//file used above.
//
//const string H2_PERSISTENCE_SYSTEM_NAME = "Default Database";
//
//const string H2_DEFAULT_CAMPAIGN_NAME = "H2_TESTMODULE";

//Begin generic expternal database functions

//This function contains any code that needs to be  called to set up the database system you are using.
//It is called directly from hcr2_moduleload_e, and is called prior to any other module load scripts
//that have been set to be ran via the Event Script hook-ins.
void h2_InitializeDatabase();

//Gets an variable of type float from the database system being used.
//sVarNameOrColumnName = name of the variable to retrieve.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
float h2_GetExternalFloat(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Gets an variable of type int from the database system being used.
//sVarNameOrColumnName = name of the variable to retrieve.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
int h2_GetExternalInt(string sVarNameOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Gets an variable of type location from the database system being used.
//sVarNameOrColumnName = name of the variable to retrieve.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
location h2_GetExternalLocation(string sVarNameOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Gets an variable of type string from the database system being used.
//sVarNameOrColumnName = name of the variable to retrieve.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
string h2_GetExternalString(string sVarNameOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Gets an variable of type vector from the database system being used.
//sVarNameOrColumnName = name of the variable to retrieve.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
vector h2_GetExternalVector(string sVarNameOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Gets an variable of type object from the database system being used.
//sVarNameOrColumnName = name of the variable to retrieve.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
object h2_GetExternalObject(string sVarNameOrColumnName, location locLocation, object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Deletes a variable of of the given name from the database system being used.
//sVarNameOrColumnName = name of the variable to delete.
//oPlayer a PC player object that is associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
void h2_DeleteExternalVariable(string sVarNameOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Sets an variable of type float to the database system being used.
//sVarNameOrColumnName = name of the variable to assign.
//flFloat = the value to be set to the variable.
//oPlayer a PC player object to be associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
void h2_SetExternalFloat(string sVarNameOrColumnName, float flFloat, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Sets an variable of type int to the database system being used.
//sVarNameOrColumnName = name of the variable to assign.
//nInt = the value to be set to the variable.
//oPlayer a PC player object to be associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
void h2_SetExternalInt(string sVarNameOrColumnName, int nInt, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Sets an variable of type location to the database system being used.
//sVarNameOrColumnName = name of the variable to assign.
//locLocationt = the value to be set to the variable.
//oPlayer a PC player object to be associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
void h2_SetExternalLocation(string sVarNameOrColumnName, location locLocation, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Sets an variable of type string to the database system being used.
//sVarNameOrColumnName = name of the variable to assign.
//sString = the value to be set to the variable.
//oPlayer a PC player object to be associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
void h2_SetExternalString(string sVarNameOrColumnName, string sString, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Sets an variable of type vector to the database system being used.
//sVarNameOrColumnName = name of the variable to assign.
//vVector = the value to be set to the variable.
//oPlayer a PC player object to be associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
void h2_SetExternalVector(string sVarNameOrColumnName, vector vVector, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");

//Sets an variable of type object to the database system being used.
//sVarNameOrColumnName = name of the variable to assign.
//oObject = the value to be set to the variable.
//oPlayer a PC player object to be associated with this variable. Defaults to OBJECT_INVALID
//sCampaignOrTableName the name of the campaign, or the name of the database being used.
//The default value for sCampaignOrTableName is the value assigned to the constant H2_DEFAULT_CAMPAIGN_NAME
//SetExternalObject must return 0 if it fails and 1 if it succeeds.
//sRowKey and sKeyValue are used for Where clause check in the hcr2_nwnx2sql_c peristence system, 
//and ignored in the hcr2_defaultdb_c persistence system.
int  h2_SetExternalObject(string sVarNameOrColumnName, object oObject, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "");
//End generic expternal database functions

//Specialty core function that need to be defined in your DB configuration script

//Gets the player state of oPC
int h2_GetPlayerState(object oPC);

//Sets the player state of oPC
void h2_SetPlayerState(object oPC, int nPlayerState);

//Gets the saved pc location
location h2_GetSavedPCLocation(object oPC);

//Sets the saved pc location
void h2_SavePCLocation(object oPC);

//Gets the number of registered characters associated with oPC's PublicCDKey
int h2_GetRegisteredCharCount(object oPC);

//Sets the number of registered characters associated with oPC's PublicCDKey
void h2_SetRegisteredCharCount(object oPC, int nRegisteredChars);

//Saves the current in game month, day, year, hour and minute to the external database.
//If values are provided for nYear, nMonth, nDay, nHour , and nMinute, then
//the this function will  save the provided values, otherwise
//it will save the current game calendar and time values.
void h2_SaveCurrentCalendar(int nYear = -1, int nMonth = -1, int nDay = -1, int nHour = -1, int nMinute = -1);

//This sets the current game calendar and time to the data and time values last saved in the
//external database.
void h2_RestoreSavedCalendar();

//Bans a PC by one of three methods: 
//H2_BAN_BY_CDKEY
//H2_BAN_BY_PLAYER_NAME
//H2_BAN_BY_IPADDRESS
//The default value is to ban by CD key.
void h2_BanPC(object oPCToBan, object oBannedBy, int nBanMethod = H2_BAN_BY_CDKEY);

//Checks if oPC is banned by CDKey, PlayerName or IPAddress
//Returns TRUE if banned, FALSE if not banned.
int h2_GetIsBanned(object oPC);

//Updates persistent data on PC login.
void h2_LogIn(object oPC);

//Updates persistent data  on PC logout.
void h2_LogOutPC(object oPC);