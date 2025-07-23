/*
Filename:           hcr2_mysqldb_c
System:             core  (NWNX-MySQL database persistence)
Author:             Jim Canup (Urlord@WizardStorm.com)
Date Created:       Dec 27th, 2006.
Summary:
HCR2 core external database function user-configuration script.
This script should be consumed by h2_persistence_c as an include directive, if
the builder desires to use NWNX with a MySQL database as their means of campaign database storage.

-----------------
Revision: v1.02 by 0100010
Added code to InitializeDatabase to auto create needed tables if they don't exist.
Added Packing of Camapaign Database since object storage still uses that.
Adjusted the h2_DeleteExternalVariable to delete from campaign database as well
in case the item was an object.
Added h2_LogIn and h2_LogOut functions.

Revision: v1.03
Added include directive for hcr2_constants_i
Fixed SQL statement errors in SetExternal* functions.

Revision: v1.05
Added some logging.
Fixed Get & SetPlayerState error, when possessing companions
*/

//This file is the core include file from the NWNX application.
//You must have NWNX and MySQL 5.0 installed for these functions to work.
#include "nwnx_sql"
#include "nwnx_include"
#include "nwnx_spawn"
#include "nwnx_srvadmin"

//Date & Time functions
#include "wstg_date_time_inc"

//This file is the core include file for the HCR2 Constants
#include "hcr2_debug_i"

//Funciton call for removing old quest from journal
//#include "alg_onclient"

//A user defined constant that specifies the name of the database system being used.
//Examples: "Default Database",  "NWNX-MySQL",   etc..
const string H2_PERSISTENCE_SYSTEM_NAME = "NWNX-MySQL";

//A user defined constant that specifies the name of the campaign associated
//with external database variable storage. This value will be used whenever
//any of the h2_Get\SetExternal functions are called and the campaign name is not specified.
const string H2_DEFAULT_CAMPAIGN_NAME = "pwdata";


int doesTableExist(string tablename)
{
	SQLExecDirect("SELECT count(*) FROM " + tablename);
	if (SQLFetch() != SQL_SUCCESS) 
		return FALSE;	
	string val = SQLGetData(1);
	if (val == "0" || StringToInt(val) > 0) 
		return TRUE; 
	return FALSE;
}


void createMissingTable(string sTableName, string sSQL)
{
	if (!doesTableExist(sTableName)) 
	{
		SQLExecDirect(sSQL);
		if (!doesTableExist(sTableName)) 
		{ 
			WriteTimestampedLogEntry("ERROR: The MySQL plugin could not set up the table '" + sTableName + "'.  Please make sure that the mysql userid in xp_mysql.ini has sufficient permissions to create a new table.");	
			PrintString("CREATE " + sTableName + " failed.");
			return;
		}
	}
}


//Begin generic external DB functions.
void h2_InitializeDatabase()
{
	//TODO: remove this when NWNX4 supports object saving.
	PackCampaignDatabase(H2_DEFAULT_CAMPAIGN_NAME);
	
	//Check if NWNX is installed.
	if (!NWNXInstalled()) 
	{ 
		WriteTimestampedLogEntry("ERROR: NWNX4 has not been installed.  Before proceeding with mysql installation, you'll need to download and install NWNX4.");
		PrintString("No NWNX4");
		return;
	}
	string plugin = NWNXGetPluginSubClass("SQL");
	WriteTimestampedLogEntry("Plugin class: " + plugin);
	if (GetStringUpperCase(plugin) != "MYSQL") 
	{ 
		WriteTimestampedLogEntry("ERROR: The MySQL plugin is not available.  If you have both xp_mysql.dll and xp_sqlite.dll in your NWN2 folder, please remove xp_sqlite.dll. \n\nIf you don't have xp_mysql.dll in your NWN2 install directory, please copy it there.");
		PrintString("Wrong Plugin Subclass");
		return;
	}
		
	SQLExecDirect("SHOW DATABASES");
	if (SQLFetch() != SQL_SUCCESS) 
	{ 
		WriteTimestampedLogEntry("ERROR: The MySQL plugin is not available.  ");
		PrintString("SHOW DATABASES failed.");
		return;
	}	
		
	//Create default tables if they dont exist
	//Create table pwdata
	string sSQL = "CREATE TABLE pwdata (" +
	        "player varchar(64) NOT NULL default '~'," +
	        "tag varchar(64) NOT NULL default '~'," +
	        "name varchar(64) NOT NULL default '~'," +
	        "val text," +
	        "expire int(11) default NULL," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (player,tag,name)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("pwdata", sSQL);		
	
	//Create table pwobjdata
	sSQL = 	"CREATE TABLE pwobjdata (" +
	        "player varchar(64) NOT NULL default '~'," +
	        "tag varchar(64) NOT NULL default '~'," +
	        "name varchar(64) NOT NULL default '~'," +
	        "val text," +
	        "expire int(11) default NULL," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (player,tag,name)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("pwobjdata", sSQL);	
	
	//Create table cdkeys
	sSQL = 	"CREATE TABLE  players(" + 
  			"CDKey varchar(20) NOT NULL default ''," + 
  			"Player varchar(64) NOT NULL default ''," +
  			"IPAddress varchar(32) NOT NULL default ''," +
  			"Ban tinyint(1) NOT NULL default '0'," +
  			"TimeStamp timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"  +
  			"PRIMARY KEY  (Player,CDKey,IPAddress)" +
			") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("PLAYERS", sSQL);
				
	//Create table pc
	sSQL = 	"CREATE TABLE  characters(" +
  			"PCID int(10) unsigned NOT NULL auto_increment," +
  			"FirstName char(64) NOT NULL default ''," +
  			"LastName char(64) NOT NULL default ''," +
  			"Player char(64) NOT NULL default ''," +
  			"CDKey char(20) NOT NULL default ''," +
  			"DateCreated datetime NOT NULL default '0000-00-00 00:00:00'," +
  			"Online tinyint(1) NOT NULL default '0'," +
  			"DM tinyint(1) NOT NULL default '0'," +
  			"Retired tinyint(1) NOT NULL default '0'," +
  			"TimeStamp timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP," +
  			"PRIMARY KEY  (CDKey,Player,LastName,FirstName)," +
  			"KEY `ndx_pcid` (PCID)" +
			") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("CHARACTERS", sSQL);
	
	//Create table pcstate
	sSQL = 	"CREATE TABLE  pcstate (" +
  			"PCID int(10) unsigned NOT NULL default '0'," +
  			"Location varchar(255) NOT NULL default ''," +
  			"PlayerState int(11) NOT NULL default '0'," +  			
  			"TimeStamp timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP," +
  			"PRIMARY KEY  (PCID)" +
			") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("pcstate", sSQL);
	
	//Create table pcdata
	sSQL = 	"CREATE TABLE  pcdata (" +
  			"PCID int(10) NOT NULL default '0'," +
  			"VarName varchar(64) NOT NULL default ''," +
  			"Value varchar(255) NOT NULL default ''," +
  			"TimeStamp timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP," +
  			"PRIMARY KEY  (VarName,PCID)" +
			") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("pcdata", sSQL);
	
	//Create table rptokens
	sSQL = "CREATE TABLE rptokens (" +
	        "player varchar(64) NOT NULL default '~'," +
	        "tag varchar(64) NOT NULL default '~'," +
	        "name varchar(64) NOT NULL default '~'," +
	        "val text," +
	        "expire int(11) default NULL," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (player,tag,name)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("rptokens", sSQL);			    

	//Create table dbtools
	sSQL = "CREATE TABLE dbtools (" +
	        "player varchar(64) NOT NULL default '~'," +
	        "tag varchar(64) NOT NULL default '~'," +
	        "name varchar(64) NOT NULL default '~'," +
	        "val text," +
	        "expire int(11) default NULL," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (player,tag,name)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("dbtools", sSQL);
	
	//Create table playernotes
	sSQL = "CREATE TABLE playernotes (" +
	        "player varchar(64) NOT NULL default '~'," +
	        "tag varchar(64) NOT NULL default '~'," +
	        "name varchar(64) NOT NULL default '~'," +
	        "val text," +
	        "expire int(11) default NULL," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (player,tag,name)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("playernotes", sSQL);
	
	//Create table recipestorage
	sSQL = "CREATE TABLE recipestorage (" +
	        "player varchar(64) NOT NULL default '~'," +
	        "tag varchar(64) NOT NULL default '~'," +
	        "name varchar(64) NOT NULL default '~'," +
	        "val text," +
	        "expire int(11) default NULL," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (player,tag,name)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("recipestorage", sSQL);		    
	
	//Create table player info
	sSQL = 	"CREATE TABLE  playerinfo (" +
			"Player char(64) NOT NULL default ''," +
  			"FirstName char(64) NOT NULL default ''," +
  			"LastName char(64) NOT NULL default ''," +
			"VarName varchar(64) NOT NULL default '~'," +
	        "Value int," + 
			"Last timestamp NOT NULL default CURRENT_TIMESTAMP," + 			
  			"PRIMARY KEY  (Player,LastName,FirstName,VarName)" +
			") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("playerinfo", sSQL);
	
	//Create table dmnotes
	sSQL = 	"CREATE TABLE  dmnotes (" +
  			"CDKey char(20) NOT NULL default ''," +
			"LoginName char(64) NOT NULL default ''," +
			"CharName char(64) NOT NULL default ''," +
			"Category char(64) NOT NULL default ''," +
			"Contents text," +
			"Public tinyint(1) NOT NULL default '0'," +
			"Timestamp timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP," +
			"PRIMARY KEY  (CDKey,Category)" +
			") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("dmnotes", sSQL);
	
	//Create table mining
	sSQL = "CREATE TABLE mining (" +
	        "toon varchar(64) NOT NULL default '~'," +
			"player varchar(64) NOT NULL default '~'," +
	        "area varchar(64) NOT NULL default '~'," +
			"difficulty varchar(64) NOT NULL default '~'," +
	        "item varchar(64) NOT NULL default '~'," +
	        "val int," +
	        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
	        "PRIMARY KEY  (toon,player,area,difficulty,item)" +
	        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;";
	createMissingTable("mining", sSQL);		    
}

string GetExternalPCID(object oPC)
{
	string sPCID = GetLocalString(oPC, "H2_SQL_PCID");
	
	if(sPCID == "") 
	{
		string sFirstName 	= SQLEncodeSpecialChars(GetFirstName(oPC));
		string sLastName	= SQLEncodeSpecialChars(GetLastName(oPC));
		string sPlayer		= SQLEncodeSpecialChars(GetPCPlayerName(oPC));
		string sCDKey		= GetPCPublicCDKey(oPC);
		string sSQL;
		
		sSQL = "SELECT PCID FROM CHARACTERS WHERE FirstName='"+sFirstName+"' AND LastName='"+sLastName+"' AND Player='"+sPlayer+"' AND CDKey='"+sCDKey+"'";
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			sPCID = SQLGetData(1);			
		SetLocalString(oPC, "H2_SQL_PCID", sPCID);
	}	
	return sPCID;
}

float h2_GetExternalFloat(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	float ReturnValue;
	
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "SELECT Value from pcdata WHERE VarName='"+sVarOrColumnName+"' AND PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			ReturnValue = StringToFloat(SQLGetData(1));
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);
	}
	else
	{
		ReturnValue = GetPersistentFloat(oPlayer, sVarOrColumnName);
	}
    return ReturnValue;
}

int h2_GetExternalInt(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	int	ReturnValue;
	
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "SELECT Value from pcdata WHERE VarName='"+sVarOrColumnName+"' AND PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			ReturnValue = StringToInt(SQLGetData(1));
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);	
	}
	else 
	{
		ReturnValue = GetPersistentInt(oPlayer, sVarOrColumnName);
	}
    return ReturnValue;
}

location h2_GetExternalLocation(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	location ReturnValue;
	
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "SELECT Value from pcdata WHERE VarName='"+sVarOrColumnName+"' AND PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			ReturnValue = SQLStringToLocation(SQLGetData(1));
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);	
	}
	else 
	{
		ReturnValue = GetPersistentLocation(oPlayer, sVarOrColumnName);
	}
    return ReturnValue;
}

string h2_GetExternalString(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	string ReturnValue;
	
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "SELECT Value from pcdata WHERE VarName='"+sVarOrColumnName+"' AND PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			ReturnValue = SQLGetData(1);		
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);
	}
	else 
	{
		ReturnValue = GetPersistentString(oPlayer, sVarOrColumnName);
	}
    return ReturnValue;
}

vector h2_GetExternalVector(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	vector ReturnValue;
	
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "SELECT Value from pcdata WHERE VarName='"+sVarOrColumnName+"' AND PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			ReturnValue = SQLStringToVector(SQLGetData(1));	
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);
	}
	else 
	{
		ReturnValue = GetPersistentVector(oPlayer, sVarOrColumnName);
	}
    return ReturnValue;
}

object h2_GetExternalObject(string sVarOrColumnName, location locLocation, object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
    return RetrieveCampaignObject(sCampaignOrTableName, sVarOrColumnName, locLocation, oOwner, oPlayer);
}

void h2_DeleteExternalVariable(string sVarOrColumnName, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{	
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "DELETE FROM pcdata WHERE VarName='"+sVarOrColumnName+"' AND PCID="+sPCID;
		SQLExecDirect(sSQL);
	}
	else 
	{
		DeletePersistentVariable(oPlayer, sVarOrColumnName);
	}
	//TODO: remove this when NWNX4 supports object saving.
	DeleteCampaignVariable(sCampaignOrTableName, sVarOrColumnName, oPlayer);
}

void h2_SetExternalFloat(string sVarOrColumnName, float flFloat, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "REPLACE INTO pcdata (PCID,VarName,Value) VALUES("+sPCID+",'"+sVarOrColumnName+"','"+FloatToString(flFloat)+"')";
		SQLExecDirect(sSQL);
	}
	else 
	{
		SetPersistentFloat(oPlayer, sVarOrColumnName, flFloat);
	}
}

void h2_SetExternalInt(string sVarOrColumnName, int nInt, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "REPLACE INTO pcdata (PCID,VarName,Value) VALUES("+sPCID+",'"+sVarOrColumnName+"','"+IntToString(nInt)+"')";
		SQLExecDirect(sSQL);
	}
	else 
	{
		SetPersistentInt(oPlayer, sVarOrColumnName, nInt);
	}
}

void h2_SetExternalLocation(string sVarOrColumnName, location locLocation, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "REPLACE INTO pcdata (PCID,VarName,Value) VALUES("+sPCID+",'"+sVarOrColumnName+"','"+SQLLocationToString(locLocation)+"')";
		SQLExecDirect(sSQL);
	}
	else 
	{
		SetPersistentLocation(oPlayer, sVarOrColumnName, locLocation);
	}
}

void h2_SetExternalString(string sVarOrColumnName, string sString, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "REPLACE INTO pcdata (PCID,VarName,Value) VALUES("+sPCID+",'"+sVarOrColumnName+"','"+sString+"')";
		SQLExecDirect(sSQL);
	}
	else 
	{
		SetPersistentString(oPlayer, sVarOrColumnName, sString);
	}
}

void h2_SetExternalVector(string sVarOrColumnName, vector vVector, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if(oPlayer != OBJECT_INVALID) 
	{
		string	sPCID = GetExternalPCID(oPlayer);
		string 	sSQL;
		sSQL = "REPLACE INTO pcdata (PCID,VarName,Value) VALUES("+sPCID+",'"+sVarOrColumnName+"','"+SQLVectorToString(vVector)+"')";
		SQLExecDirect(sSQL);
	}
	else 
	{
		SetPersistentVector(oPlayer, sVarOrColumnName, vVector);
	}
}

int h2_SetExternalObject(string sVarOrColumnName, object oObject, object oPlayer=OBJECT_INVALID, string sCampaignOrTableName=H2_DEFAULT_CAMPAIGN_NAME, string sRowKey = "", string sKeyValue = "")
{
	if (GetStringLength(sVarOrColumnName) > 32)
		WriteTimestampedLogEntry("Warning: External variable name " + sVarOrColumnName + "will be truncated to 32 characters.");	

    int bSuccess = StoreCampaignObject(sCampaignOrTableName, sVarOrColumnName, oObject, oPlayer);
    if (!bSuccess)
        WriteTimestampedLogEntry("StoreCampaignObject failed on object " + GetResRef(oObject) + " to variable " + sVarOrColumnName);
    return bSuccess;
}
//end generic external DB functions

//Begin Custom defineable core function constants
//If you want to seperate the HCR2 core PW data into multiple DB files
//for this special information then change the value of the following constants.
//By default they are set equal to the existing default campaign name
const string H2_SERVER_DATE_INFO 		= H2_DEFAULT_CAMPAIGN_NAME;
const string H2_BANNED_LIST_INFO 		= H2_DEFAULT_CAMPAIGN_NAME;

//These constant merely represent variable names, you can alter their values if you wish but don't need to.
const string H2_PLAYER_STATE 			= "H2_PLAYER_STATE";
const string H2_SAVED_PC_LOCATION 		= "H2_SAVED_PC_LOCATION";
const string H2_REGISTERED_CHARS 		= "_H2_REGISTERED_CHARS";
const string H2_CURRENT_DATE_TIME		= "H2_CURRENT_DATE_TIME";
const int 	 H2_BAN_BY_CDKEY  			= 0;
const int 	 H2_BAN_BY_PLAYER_NAME 		= 1;
const int 	 H2_BAN_BY_IPADDRESS 		= 2;
const int    H2_BAN_BY_ALL				= 3;
const string H2_BANNED_CD_KEY 			= "H2_BANNED_CD_KEY_";
const string H2_BANNED_NAME 			= "H2_BANNED_NAME_";
const string H2_BANNED_IPADDRESS 		= "H2_BANNED_IPADDRESS_";

//Begin core custom definable specialty functions
int h2_GetPlayerState(object oPC)
{
	if (GetIsOwnedByPlayer(oPC))
	{
		int ReturnValue;	
		string	sPCID = GetExternalPCID(oPC);
		if (sPCID == "")
			return 0;	
		string sSQL = "SELECT PlayerState from pcstate WHERE PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS)
			ReturnValue = StringToInt(SQLGetData(1));	
		else	
			WriteTimestampedLogEntry("Error executing: " + sSQL);				
		return ReturnValue;	
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
		string	sPCID = GetExternalPCID(oPC);
		string 	sSQL;
		int		nCount;	
		
		sSQL = "SELECT count(PCID) from pcstate WHERE PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS) 
		{
			nCount = StringToInt(SQLGetData(1));			
			sSQL = "UPDATE pcstate SET PlayerState="+IntToString(nPlayerState)+" WHERE PCID="+sPCID;	
			if(nCount == 0)
				sSQL = "INSERT INTO pcstate (PCID,PlayerState) VALUES("+sPCID+","+IntToString(nPlayerState)+")";
			SQLExecDirect(sSQL);
			h2_LogPlayerState( oPC, nPlayerState);
		}	
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);
		
		if(nPlayerState == H2_PLAYER_STATE_RETIRED) 
		{
			//sSQL = "UPDATE CHARACTERS SET Retired=1 WHERE PCID="+sPCID;
			//SQLExecDirect(sSQL);
			sSQL = "DELETE FROM CHARACTERS WHERE PCID="+sPCID;
			SQLExecDirect(sSQL);
					
			sSQL = "DELETE FROM pcstate WHERE PCID="+sPCID;
			SQLExecDirect(sSQL);		
			sSQL = "DELETE FROM pcdata WHERE PCID="+sPCID;
			SQLExecDirect(sSQL);
			
			object    oModule              = GetModule(); 
   			string    sPlayerName          = GetPCPlayerName(oPC);
   			string    sBicFileName         = GetStringLowerCase(GetFirstName(oPC)+GetLastName(oPC));
			string 	  testBic			   = GetBicFileName(oPC);
			//SendMessageToPC(oPC, "Bic file name is: '" + testBic + "'");
			int iLength = GetStringLength(testBic);
			int nLength = GetStringLength(sPlayerName);
			string testBic3 = GetStringRight(testBic, iLength - nLength - 13);
			//SendMessageToPC(oPC, "Bic file name is: '" + testBic2 + "' and '" + testBic3 + "'"); 
			//string    sCommand1			   = "del /F/Q " + SpawnQuote(SpawnEscape("E:|Documents and Settings|Mustang|My Documents|Neverwinter Nights 2|servervault|"+sPlayerName+"|"+testBic3+".*"));
			//SendMessageToPC(oPC, "Command is -> " + "E:|Documents and Settings|Mustang|My Documents|Neverwinter Nights 2|servervault|"+sPlayerName+"|"+testBic2+".*");
  			string    sCommand             = "del /F/Q " + SpawnQuote(SpawnEscape("C:|Users|Administrator|Documents|Neverwinter Nights 2|servervault|"+sPlayerName+"|"+testBic3+".*")); 
			AssignCommand(oModule, DelayCommand(15.0, SpawnCommand(sCommand, 0))); 
			//AssignCommand(oModule, DelayCommand(15.0, SpawnCommand(sCommand1, 0))); 
		}
		return;
	}
	string sCompanionName = GetTag(oPC) + "_" + GetName(oPC);
	h2_SetModLocalInt(H2_PLAYER_STATE + sCompanionName, nPlayerState);
}

location h2_GetSavedPCLocation(object oPC)
{
	location ReturnValue;	
	string	sPCID = GetExternalPCID(oPC);
	string 	sSQL;
	sSQL = "SELECT Location from pcstate WHERE PCID="+sPCID;
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS)
		ReturnValue = SQLStringToLocation(SQLGetData(1));	
	else
		WriteTimestampedLogEntry("Error executing: " + sSQL);
		
	return ReturnValue;	
}

void h2_SavePCLocation(object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) 
        return;
	object oArea = GetArea(oPC);
	if (GetIsObjectValid(oArea)) 
	{
	        // dont save in the OOC area
		if (FindSubString( GetName( oArea ), "OOC") != -1) return;
		location lLocation 	= GetLocation(oPC);
		string	 sPCID 		= GetExternalPCID(oPC);
		string	 sLocation 	= SQLLocationToString(lLocation);
		string   sSQL;
		int		 nCount;	
		
		sSQL = "SELECT count(PCID) from pcstate WHERE PCID="+sPCID;
		SQLExecDirect(sSQL);
		if(SQLFetch() == SQL_SUCCESS) 
		{
			nCount = StringToInt(SQLGetData(1));
			sSQL = "UPDATE pcstate SET Location='"+sLocation+"' WHERE PCID="+sPCID;
			if(nCount == 0)
				sSQL = "INSERT INTO pcstate (PCID,Location) VALUES("+sPCID+",'"+sLocation+"')";
			SQLExecDirect(sSQL);
		}
		else
			WriteTimestampedLogEntry("Error executing: " + sSQL);	
	}
	else
		DelayCommand(0.1, h2_SavePCLocation(oPC));		
}

int h2_GetRegisteredCharCount(object oPC)
{
	string 	sCDKey = GetPCPublicCDKey(oPC);
	string 	sSQL;
	int		nCount = -1;
	
	sSQL = "SELECT count(PCID) from CHARACTERS WHERE CDKey='"+sCDKey+"' AND Retired=0";
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS)
		nCount = StringToInt(SQLGetData(1));	
	else
		WriteTimestampedLogEntry("Error executing: " + sSQL);		 
	return nCount;
}

void h2_SetRegisteredCharCount(object oPC, int nRegisteredChars)
{
	//The reason this function does nothing is because
	//the act of logging in always creates a record entry for a character in
	//the CHARACTERS table if one did not yet exist. 
	//h2_GetRegisteredCharCount is always accurate
	//because it simply counts the number of non-retired character records
	//for the player in the CHARACTERS table.
}

void h2_SaveCurrentCalendar(int nYear = -1, int nMonth = -1, int nDay = -1, int nHour = -1, int nMinute = -1)
{
	object	oMod  		= GetModule();
	float  	fTimeFactor = 60/(HoursToSeconds(1)/60);
	
	if (nYear == -1)
		nYear = GetCalendarYear();
	if (nMonth == -1)
		nMonth = GetCalendarMonth();
	if (nDay == -1)
		nDay = GetCalendarDay();
	if (nHour == -1)
		nHour = GetTimeHour();
	if (nMinute == -1) 
	{
		nMinute  = GetTimeMinute();
	    nMinute  = FloatToInt(nMinute * fTimeFactor);
	}							

	string sDateTime = GetDateTimeString(nYear,nMonth,nDay,nHour,nMinute,0);
	SetPersistentString(oMod, H2_CURRENT_DATE_TIME, sDateTime);
}

void h2_RestoreSavedCalendar()
{
	object 	oMod 		= GetModule();
	float  	fTimeFactor = 60/(HoursToSeconds(1)/60);
	string 	sDateTime 	= GetPersistentString(oMod, H2_CURRENT_DATE_TIME);
    int 	iCurYear 	= ParseDateTimeString(sDateTime, "year");
    int 	iCurMonth 	= ParseDateTimeString(sDateTime, "month");
    int 	iCurDay 	= ParseDateTimeString(sDateTime, "day");
    int 	iCurHour 	= ParseDateTimeString(sDateTime, "hour");
	int 	iCurMin 	= FloatToInt(ParseDateTimeString(sDateTime, "minute") / fTimeFactor);
	
    if(sDateTime != "") 
	{
        SetTime(iCurHour, iCurMin, 0, 0);
        SetCalendar(iCurYear, iCurMonth, iCurDay);
    }
}

void h2_BanPC(object oPCToBan, object oBannedBy, int nBanMethod = H2_BAN_BY_CDKEY)
{
	string sMessage 	= GetPCPlayerName(oPCToBan) + "_" + GetName(oPCToBan) + " banned by: " + GetPCPlayerName(oBannedBy) + "_" + GetName(oBannedBy);
	string sPlayer		= SQLEncodeSpecialChars(GetPCPlayerName(oPCToBan));
	string sCDKey		= GetPCPublicCDKey(oPCToBan);
	string sIPAddress	= GetPCIPAddress(oPCToBan);
	string sSQL;
	
	switch (nBanMethod)
	{
		case H2_BAN_BY_CDKEY:  
			sSQL = "UPDATE PLAYERS SET Ban=1 WHERE CDKey='"+sCDKey+"' AND IPAddress != '68.169.158.128' OR IPAddress != '68.169.154.157'";
			sMessage = "CDKey Ban: " + sMessage;
			break;
		case H2_BAN_BY_PLAYER_NAME: 
			sSQL = "UPDATE PLAYERS SET Ban=1 WHERE Player='"+sPlayer+"' AND IPAddress != '68.169.158.128' AND IPAddress != '68.169.154.157'";
			sMessage = "Player Ban: " + sMessage;
			break;
		case H2_BAN_BY_IPADDRESS:   
			sSQL = "UPDATE PLAYERS SET Ban=1 WHERE IPAddress='"+sIPAddress+"' AND IPAddress != '68.169.158.128' AND IPAddress != '68.169.154.157'";
			sMessage = "IPAddress Ban: " + sMessage;
			break;
		case H2_BAN_BY_ALL:
			sSQL = "UPDATE PLAYERS SET Ban=1 WHERE (CDKey='"+sCDKey+"' OR Player='"+sPlayer+"' OR IPAddress='"+sIPAddress+"') AND IPAddress != '68.169.158.128' AND IPAddress != '68.169.154.157'";
			sMessage = "Full Ban: " + sMessage;
	}
	//SendMessageToAllDMs(sMessage);
    WriteTimestampedLogEntry(sMessage);
   	DelayCommand(10.0f, BootPC(oPCToBan));
	SQLExecDirect(sSQL);	
}

int h2_GetIsBanned(object oPC)
{
	string sPlayer		= SQLEncodeSpecialChars(GetPCPlayerName(oPC));
	string sCDKey		= GetPCPublicCDKey(oPC);
	string sIPAddress	= GetPCIPAddress(oPC);
	string sSQL;
	int nBan = FALSE;

	sSQL = "SELECT max(Ban) FROM PLAYERS WHERE CDKey='"+sCDKey+"' OR Player='"+sPlayer+"' OR IPAddress='"+sIPAddress+"'";
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS)
		nBan = StringToInt(SQLGetData(1));	
	else
		WriteTimestampedLogEntry("Error executing: " + sSQL);	
	
	if (nBan > 0)
	{
		WriteTimestampedLogEntry("Banned player attempted login - " + sPlayer + " " + sCDKey + " " + sIPAddress);
		nBan = TRUE;
	}
	
	return nBan;		
}

//Updates appropriate persistent data on PC log-in.
void h2_LogInPC(object oPC)
{
	string 	sCDKey		= GetPCPublicCDKey(oPC);
	string 	sPlayer		= SQLEncodeSpecialChars(GetPCPlayerName(oPC));
	string 	sIPAddress	= GetPCIPAddress(oPC);
	string 	sFirstName 	= SQLEncodeSpecialChars(GetFirstName(oPC));
	string 	sLastName	= SQLEncodeSpecialChars(GetLastName(oPC));
	string 	sIsDM		= IntToString(GetIsDM(oPC));	
	string 	sSQL, sPCID;
	int		nCount;	
	
	//SendMessageToAllDMs("Player name is: " + sPlayer + sFirstName + sLastName);
	
	/*
	sSQL = "SELECT count(CDKey) FROM PLAYERS WHERE CDKey='"+sCDKey+"'";
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS)
	{
		nCount = StringToInt(SQLGetData(1));
		if(nCount==0)
		{  // Brand new CD-Key
			//Temporary safe guard in place
			//SendMessageToPC(oPC, "This account is already registered with a different CD-Key. Please contact the staff at www.dalelandsbeyond.com in order to be able to play.");
			AssignCommand(GetModule(), DelayCommand(1.0f, BootPC(oPC)));
			WriteTimestampedLogEntry(sPlayer + " is trying to register new CD-Key " + sCDKey + " and is using IPAddress " + sIPAddress);
			return;
		}
	}
	*/
	sSQL = "SELECT count(CDKey) FROM PLAYERS WHERE CDKey='"+sCDKey+"' AND Player='"+sPlayer+"' AND IPAddress='"+sIPAddress+"'";
	//SendMessageToAllDMs("sSQL is: " + sSQL);
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS) 
	{
		nCount = StringToInt(SQLGetData(1));
		if(nCount == 0) 
		{
			sSQL = "SELECT count(CDKey) FROM PLAYERS WHERE Player='"+sPlayer+"' AND CDKey='"+sCDKey+"'";
			SQLExecDirect(sSQL);
			if(SQLFetch() == SQL_SUCCESS)
			{
				nCount = StringToInt(SQLGetData(1));
				if(nCount==0)
				{
					sSQL = "SELECT count(CDKey) FROM PLAYERS WHERE Player='"+sPlayer+"'";
					SQLExecDirect(sSQL);
					if(SQLFetch() == SQL_SUCCESS)
					{
						nCount = StringToInt(SQLGetData(1));
						if(nCount!=0)
						{ // Not a new Player
							SendMessageToPC(oPC, "This account is already registered with a different CD-Key. Please contact the staff at www.dalelandsbeyond.com in order to be able to play.");
							AssignCommand(GetModule(), DelayCommand(1.0f, BootPC(oPC)));
							WriteTimestampedLogEntry(sPlayer + " is trying to register invalid CD-Key " + sCDKey + " and is using IPAddress " + sIPAddress);
							return;
						}
					}
					//SendMessageToPC(oPC, "This account is already registered with a different CD-Key. Please contact the staff at www.dalelandsbeyond.com in order to be able to play.");
					//AssignCommand(GetModule(), DelayCommand(1.0f, BootPC(oPC)));
					//return;
				}
			}		
			sSQL = "INSERT INTO PLAYERS (CDKey,Player,IPAddress) VALUES('"+sCDKey+"','"+sPlayer+"','"+sIPAddress+"')";
			//SendMessageToAllDMs("sSQL is: " + sSQL);
			SQLExecDirect(sSQL);
		}	
	}	
	else
	{
		WriteTimestampedLogEntry("Error executing: " + sSQL);	
		return;
	}
	
	sSQL = "SELECT count(PCID) FROM CHARACTERS WHERE FirstName='"+sFirstName+"' AND LastName='"+sLastName+"' AND Player='"+sPlayer+"' AND CDKey='"+sCDKey+"'";
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS) 
	{
		nCount = StringToInt(SQLGetData(1));
		if(nCount == 0) 
		{
			sSQL = "INSERT INTO CHARACTERS (FirstName,LastName,CDKey,Player,DM,Online,DateCreated) VALUES('"+sFirstName+"','"+sLastName+"','"+sCDKey+"','"+sPlayer+"',"+sIsDM+",1,CURRENT_TIMESTAMP)";						
			//SendMessageToAllDMs("sSQL is: " + sSQL);
			SQLExecDirect(sSQL);
			h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);	
			//SendMessageToAllDMs("sSQL is: " + sSQL);		
		}
		else
		{
			sSQL = "UPDATE CHARACTERS SET Online=1 WHERE FirstName='"+sFirstName+"' AND LastName='"+sLastName+"' AND Player='"+sPlayer+"' AND CDKey='"+sCDKey+"'";
			//SendMessageToAllDMs("sSQL is: " + sSQL);
			SQLExecDirect(sSQL);
		}
		
	}
	else
		WriteTimestampedLogEntry("Error executing: " + sSQL);
		
	//SpawnScriptDebugger();	
	//reset quest for PC if quest is older than 7 days
	sSQL = "SELECT count(Player) FROM PWDATA WHERE Last <= ((CURRENT_DATE) - INTERVAL 7 DAY) AND Player='"+sPlayer+"'";
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS) 
	{
		nCount = StringToInt(SQLGetData(1));
		if(nCount > 0) 
		{
			sSQL = "DELETE FROM PWDATA WHERE Player='"+sPlayer+"' AND Last IN (SELECT p.Last FROM ( SELECT * FROM pwdata WHERE val != '40' AND val != '10' AND val != '20' AND name != 'SPELL_FAILURE' AND Player != '~' ) AS p WHERE p.Last <= ((CURRENT_DATE) - INTERVAL 7 DAY))";
			SQLExecDirect(sSQL);
			//DeleteQuestIfOld(oPC);		
		}		
	}
	else
		WriteTimestampedLogEntry("Error executing: " + sSQL);
}

//Updates appropriate persistent data on PC log-out.
void h2_LogOutPC(object oPC)
{
	string 	sCDKey		= GetLocalString(oPC, H2_PC_CD_KEY);
	string 	sPlayer		= SQLEncodeSpecialChars(GetLocalString(oPC, H2_PC_PLAYER_NAME));
	string 	sFirstName 	= SQLEncodeSpecialChars(GetFirstName(oPC));
	string 	sLastName	= SQLEncodeSpecialChars(GetLastName(oPC));
	string 	sSQL = "UPDATE CHARACTERS SET Online=0 WHERE FirstName='"+sFirstName+"' AND LastName='"+sLastName+"' AND Player='"+sPlayer+"' AND CDKey='"+sCDKey+"'";	
	SQLExecDirect(sSQL);		
}

//Retrieves number of players online at a time.
int h2_GetPlayerCount()
{
	string 	sSQL, sPCID;
	int		nCount;	

	sSQL = "SELECT count(Player) FROM CHARACTERS WHERE Online=1";
	//SendMessageToAllDMs("sSQL is: " + sSQL);
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS) 
	{
		nCount = StringToInt(SQLGetData(1));
		return nCount;
	}
	else
	{
		WriteTimestampedLogEntry("Error executing: " + sSQL);	
		return 0;
	}
	
}

int IsNewPlayer(object oPC, string sCDKey)
{
	//string 	sCDKey		= GetPCPublicCDKey(oPC);
	string 	sPlayer		= SQLEncodeSpecialChars(GetPCPlayerName(oPC));	
	string 	sSQL;
	int		nCount;	

	sSQL = "SELECT count(CDKey) FROM PLAYERS WHERE CDKey='"+sCDKey+"'";
	SQLExecDirect(sSQL);
	if(SQLFetch() == SQL_SUCCESS)
	{
		nCount = StringToInt(SQLGetData(1));
		if(nCount==0)
		{  
			BootPC(oPC);
			return 1;
		}
	}
	return 0;
}