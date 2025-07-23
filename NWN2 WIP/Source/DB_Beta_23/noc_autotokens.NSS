/*
Author: 		DM_Nocturne
Created: 		October 21, 2013
Last Modified:	October 22, 2013
Description:

System for granting a lesser token to players who have accrued at least
RPXP_THRESHOLD RP XP since the LAST_TOKEN_THRESHOLD hours have passed. Currently
set to give out a lesser token to any player that has accumulated at least 3k RP
XP and has not received a token within the last 240 hurs (10 days).
*/
#include "nwnx_sql" 				   //Included for SQL commands
#include "hv_chat_commands" 		   //Included for Get/SetPersitentInt/String


const int RPXP_THRESHOLD = 3000; 		//Amount of RP XP that needs to be gained before a
								 		//lesser can be given.
const int LAST_TOKEN_THRESHOLD = 120;   //Minimum amount of time (in hours) that must
										//have elapsed since their last received token

void GiveAutoToken(object oPC);
void AutoToken(object oSpeaker, int xpGained);

//Main method. Asseses wether a PC should receive a lesser token, and gives one
//if so.										
void AutoToken(object oSpeaker, int xpGained)
{
	string xpInfo = GetPlayerInfo(oSpeaker, "RP_XP_RUNNING");
	if(xpInfo == "") //Player has not received RP XP since the script went in
	{
		SetPlayerInfo(oSpeaker, "RP_XP_RUNNING", IntToString(xpGained));
	}
	else
	{
		int runningXP = StringToInt(xpInfo) + xpGained;
		//Get PC's data
    	string toon = GetName(oSpeaker); //Get PC name
		string player = GetPCPlayerName(oSpeaker); //Get player login
		toon = SQLEncodeSpecialChars(toon);
		player = SQLEncodeSpecialChars(player);
		
		string sSQL = "SELECT TIMESTAMPDIFF(HOUR, last, NOW()) FROM rptokens "
						+ "WHERE player = '" + player + "' "
						+ "AND tag = '" + toon + "' "
						+ "AND name = 'RP_Token_Last_Given'"; 
		SQLExecDirect(sSQL);
		
		if (SQLFetch() == SQL_SUCCESS) //Suceeds only if the player has previously received a token
		{
			int hoursSinceLastToken = StringToInt(SQLGetData(1));
			if(runningXP >= RPXP_THRESHOLD && hoursSinceLastToken >= LAST_TOKEN_THRESHOLD)
			{
				GiveAutoToken(oSpeaker); //Give player a lesser token.
				SendMessageToPC(oSpeaker, "You have received one lesser token.");
				runningXP = 0; //Reset running RP XP
			}
		}
		else //executes only if the PC has never recived a token and thus has no
			 //entry in the rptokens table
		{
			if(runningXP >= RPXP_THRESHOLD)
			{
				GiveAutoToken(oSpeaker); //Give player a lesser token.
				SendMessageToPC(oSpeaker, "You have received one lesser token.");
				runningXP = 0; //Reset running RP XP
			}
		}
		
		SetPlayerInfo(oSpeaker, "RP_XP_RUNNING", IntToString(runningXP)); //Updates the player's running RP XP
	}
}

void GiveAutoToken(object oPC)
{
	int currentTokens =  GetPersistentInt(oPC, "RP_Tokens", "rptokens"); //Gets how many tokens the PC has.
	SetPersistentInt(oPC, "RP_Tokens", currentTokens + 1, 0, "rptokens"); //Adds one lesser token to the PC.
	SetPersistentString(oPC, "RP_Token_Last_Given", GetSystemDate(), 0, "rptokens"); //Sets the date of the last token given as the current system time.
	SetPersistentString(oPC, "RP_Token_Last_Type", "Lesser token", 0, "rptokens"); //Updates the type of token last given.
	SetPersistentString(oPC, "RP_Token_Last_DM", "Auto RP XP Token", 0, "rptokens"); //Notes that the token that was just given was an automatic one.
}
		
	
	
	 								