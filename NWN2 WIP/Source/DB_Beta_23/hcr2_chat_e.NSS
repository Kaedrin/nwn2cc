/*
Filename:           hcr2_chat_e
System:             core (player chat event script)
Author:             Edward Beck (0100010)
Date Created:       July 18th, 2009.
Summary:
HCR2 OnChat Event.
This script should be attachted to the OnChat event under
the scripts section of Module properties.

-----------------
Revision: 

*/

/*
// Edit 18th June 2009 JayNi.
// Patch 1.23 has an on-chat event that we now point to this script.
// This gives new possibilities, like disabling the shout-channel.
//	Edit april 24th 2009 JayNi. The old script worked, but used unnecesary resources,
//  because the DM-part of the script was located in the beginning.
//
// driller@blackstonekeep.com
//
// Edit 21st Jan 2011 Dalelands Beyond scripting team
// Integrating LRES OOC check patterns into OOC checks
*/


#include "hcr2_core_i"
#include "cwhit_ooc_consts"
#include "hv_chat_commands"
#include "alex_constants"
#include "nwnx_sql"
#include "nwnx_srvadmin"
#include "noc_autotokens"

/*
 * MvD_02_00CMatchCase: Compares the string match with the
 * case-sensitive substrings defined in mvd_02_const.
 * Match: The string to compare
 * RETURN: TRUE if OOC, FALSE else.
 */
int MvD_02_OOCMatchCase( string Match ) {
    if( FindSubString( Match, cMvD_02_sOOC1 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC2 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC3 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC4 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC5 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC6 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC7 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC8 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC9 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC10 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC11 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC12 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC13 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC14 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC15 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC16 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC17 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC18 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC19 ) != -1 ) {
        return( TRUE );
    } else {
        return( FALSE );
    }
}

/*
 * MvD_02_OOCMatchNoCase: Compares the string case-insensitive with
 * the OOC words defined in mvd_02_const.
 * MatchString: The string to test.
 * RETURN: TRUE if OOC, FALSE else
 */
int MvD_02_OOCMatchNoCase( string MatchString ) {

    // make the string lowercase
    string  Match = GetStringLowerCase( MatchString );

    if( FindSubString( Match, cMvD_02_sOOCWord1 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord2 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord3 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord4 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord5 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord6 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord7 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord8 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord9 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord10 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord11 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord12 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord13 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord14 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord15 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord16 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord17 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord18 ) != -1 ) {
        return( TRUE );
    } else {
        return( FALSE );
    }
}


//Small sentences should be ignored. Check that the PC is talking in the talk channel
int isChatValidForXP(string sMessage, int nChannel){
	
	return (GetStringLength(sMessage) >= 10) &&  
	       (nChannel == CHAT_MODE_TALK || nChannel == CHAT_MODE_WHISPER) && 
	       (!MvD_02_OOCMatchCase( sMessage )) && (!MvD_02_OOCMatchNoCase( sMessage ));	
}


string IsHelper(string player_name)
{
    player_name = SQLEncodeSpecialChars(player_name);
    string sVarName = "is_helper";
	string sTable = "dbtools";
	
    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + player_name + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLGetData(1);
    else
        return "0";
}

void SendServerShout(string message)
{
	object oPC = GetFirstPC();
	while(GetIsObjectValid(oPC) == TRUE)
	{
		SendMessageToPC(oPC, message);
		oPC = GetNextPC();
	}
}

int StartingConditional(object oSpeaker, object oTarget, int nChannel, string sChatMessage)
{
	// PC spoken - for APS (AFK Prevention System) tracking
	SetLocalInt(oSpeaker, AFK_CHAT, 1);
	
	// Notify player if oTarget is AFK
	if ((nChannel == CHAT_MODE_TELL) && (GetLocalInt(oTarget, "hv_player_afk") == 1))
		SendMessageToPC(oSpeaker, "<C=cyan>" + GetName(oTarget) + " is marked as AFK and may not reply.");

	// Chat commands - DMs only
	if ((GetIsDM(oSpeaker)) || (GetIsDMPossessed(oSpeaker))) {
		// If a chat command was called, run it.
		if (DoChatCommand(oSpeaker, oTarget, sChatMessage, nChannel)) {
		
			return FALSE;
		}
	}

	// Player helpers' shout to offer help
	if (sChatMessage == "offer_help") {
		if (GetIsPC(oSpeaker)) {
			string player_name = GetPCPlayerName(oSpeaker);
			if (IsHelper(player_name) == "1") {
				string message = "<C=lightgreen>"+ GetName(oSpeaker) + ": I'm a player helper, if you have any questions or need help feel free to send me a tell.";				
				BroadcastServerMessage(message);
			}
		}
		return FALSE;
	}

	int bRet = TRUE;
	if (!GetIsObjectValid(oSpeaker) && GetStringLeft(sChatMessage, 5) == "HCR2_")
		return FALSE;
	//Do Chat logging	
	//if (GetIsPC(oSpeaker))
	//{	
	//	string sChatLog = "CHATLOG: C=" +IntToString(nChannel) + "; ";
	//	sChatLog += "A=" + GetName(GetArea(oSpeaker)) + "; ";
	//	sChatLog += "S=" + GetPCPlayerName(oSpeaker) + "_" + GetName(oSpeaker) + "; ";
	//	sChatLog += "T=" + GetPCPlayerName(oTarget) + "_" + GetName(oTarget) + "; ";
	//	sChatLog += "M='" + sChatMessage + "'";
	//	WriteTimestampedLogEntry(sChatLog);
	//}

	if (GetIsDM(oSpeaker)) 
    {
     	return TRUE;
    } 
	else if (nChannel == CHAT_MODE_SHOUT){
	  	SendMessageToPC(oSpeaker, "Shout channel is disabled.");
		return FALSE;
	} 
	else if (nChannel == CHAT_MODE_TELL || nChannel == CHAT_MODE_SERVER){
	  	return TRUE;
	}
	
	object oArea = GetArea( oSpeaker );

	// If in a legal area...
	if( oArea != OBJECT_INVALID && FindSubString( GetName( oArea ), cMvD_02_sOOCAreaName ) == -1  ) {
		//Make it a little random.
		if(Random(5) == 0){
			object oNearestPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oSpeaker);
			float fDist = GetDistanceBetween(oSpeaker,oNearestPC);

			//Make sure another PC is nearby. (Changes by Xeneize as of 22/07/15)
			if(fDist > 0.0 && fDist <= 10.0 && isChatValidForXP(sChatMessage, nChannel))
			{
				int nCurrent = GetLocalInt(oSpeaker,"RP_XP");
				//if(GetTotalLevels(oSpeaker,FALSE)>=20 && nCurrent > 750) return TRUE;
				if(nCurrent > 6000) return TRUE;
				
				int nXP = Random(25) + Random(25) + 50;
				nCurrent = nCurrent + nXP;

				SetLocalInt(oSpeaker,"RP_XP",nCurrent);
				GiveXPToCreature(oSpeaker, nXP);	
				SendMessageToPC(oSpeaker,"Earned Role-Play XP.");
				
				AutoToken(oSpeaker,nXP); //NOCTURNE (10/22/2013) - Execute AutoToken script.
				
				int nTotalRPXP = GetLocalInt(oSpeaker, "RP_XP_TOTAL") + nXP;
				SetLocalInt(oSpeaker, "RP_XP_TOTAL", nTotalRPXP);
				SetPlayerInfo(oSpeaker, "RP_XP_TOTAL", IntToString(nTotalRPXP));
				
			}
			
		}
	}
      
     	//return TRUE; // treat all other cases normally, allowing the text to be spoken aloud. 
	
		bRet = h2_RunModuleChatEventScripts(oSpeaker, oTarget, nChannel, sChatMessage);
		//return bRet;
		return TRUE;
}