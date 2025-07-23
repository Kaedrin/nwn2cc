// Name     : NWNX Srvadmin include
// Purpose  : Various functions for performing server admin functions from nwscript
// Authors  : Skywing
// Modified : August 10, 2008

// This file is placed into the public domain.

/************************************/
/* Function prototypes              */
/************************************/

//
// Shutdown the server gracefully.  The function returns to the scripting
// environment but the server will terminate gracefully (saving all characters) a
// short time after.  Note that if you are using the NWNX watchdog functions, the
// server process may be automagically restarted by NWNX.
//
void ShutdownNwn2server();

//
// Send a broadcast server message, as per the administrative console input box.
//
void BroadcastServerMessage(string sServerMessage);

//
// Boot a player.
//
void BootPlayer(string sAccountName);

//
// Ban a player's account name.  The player must be logged in.
//
void BanPlayerName(string sAccountName);

//
// Ban a player's IP address.  The player must be logged in.  You must supply the
// account name and not the IP address.
//
void BanPlayerIP(string sAccountName);

//
// Ban a player's CD-Key.  The player must be logged in.  You must supply the
// account name and not the CD-Key.
//
void BanPlayerCDKey(string sAccountName);

//
// Set the ELC state on the fly, as per the administrative console check box.
//
void SetELC(int nELCEnabled);

//
// Set the player password required to join the server.  Setting an empty
// password string disables the password requirement.  This functions as
// changing the password via the server GUI and isn't persisted across
// restarts.
//
void SetPlayerPassword(string sPlayerPassword);

//
// Set the DM password required to join the server as a DM.  Setting an
// empty password string disables the password requirement.  This
// functions as changing the password via the server GUI and isn't
// persisted across restarts.
//
void SetDMPassword(string sDMPassword);

//
// Set the admin password required to use the server admin console.
// Setting an empty password string disables the server admin console.
// This functions as changing the password via the server GUI and isn't
// persisted across restarts.
//
void SetAdminPassword(string sAdminPassword);

const string srvadminSpacer = "                                               ";

/************************************/
/* Implementation                   */
/************************************/

void ShutdownNwn2server()
{
    object oPC = OBJECT_SELF;
	WriteTimestampedLogEntry("[" + GetPCPlayerName(oPC) + "] initiate server reset." );
    NWNXSetString( "SRVADMIN", "SHUTDOWNNWN2SERVER", "", 0, "" );
}

void BroadcastServerMessage(string sServerMessage)
{
    NWNXSetString( "SRVADMIN", "BROADCASTSERVERMESSAGE", sServerMessage, 0, "" );
}

void BootPlayer(string sAccountName)
{
    NWNXSetString( "SRVADMIN", "BOOTPLAYER", sAccountName, 0, "" );
}

void BanPlayerName(string sAccountName)
{
    NWNXSetString( "SRVADMIN", "BANPLAYERNAME", sAccountName, 0, "" );
}

void BanPlayerIP(string sAccountName)
{
    NWNXSetString( "SRVADMIN", "BANPLAYERIP", sAccountName, 0, "" );
}

void BanPlayerCDKey(string sAccountName)
{
    NWNXSetString( "SRVADMIN", "BANPLAYERCDKEY", sAccountName, 0, "" );
}

void SetELC(int nELCEnabled)
{
    string sTfString;

    if (nELCEnabled == FALSE)
        sTfString = "false";
    else
        sTfString = "true";

    NWNXSetString( "SRVADMIN", "SETELC", sTfString, 0, "" );
}

void SetPlayerPassword(string sPlayerPassword)
{
    NWNXSetString( "SRVADMIN", "SETPLAYERPASSWORD", sPlayerPassword, 0, "" );
}

void SetDMPassword(string sDMPassword)
{
    NWNXSetString( "SRVADMIN", "SETDMPASSWORD", sDMPassword, 0, "" );
}

void SetAdminPassword(string sAdminPassword)
{
    NWNXSetString( "SRVADMIN", "SETADMINPASSWORD", sAdminPassword, 0, "" );
}