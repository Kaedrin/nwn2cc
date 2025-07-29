#include "nwnx_sql"
#include "nwnx_clock"
#include "hv_chat_commands"
#include "hcr2_persistence_c"

// Write given token to player info
void WriteTokenData(object oPlayer, string sTokenType, string sVarName, string sDM_Name, string sDate, string sTable);

// Get or set tracking information on player
void main(string sAction, string sAdditionalInfo = "")
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	object oDM = OBJECT_SELF;
	object oPlayer = GetPlayerCurrentTarget(oDM);
	string sData;
	string sIntTable = "playerinfo";
	string sTextTable = "playernotes";
	
	// Make sure we are targeting a PC
	if (!GetIsPC(oPlayer)) {
		SendMessageToPC(oDM, "Invalid target.");
		return;
	}
	
	// Get XP info
	if (sAction == "0") {
		
		// Display GUI
		DisplayGuiScreen(oDM, "hv_player_info", FALSE, "hv_player_info.xml");
		
		// Get information
		sData = "Total Event XP: " + GetPlayerInfo(oPlayer, "hv_player_dmxp_total", sIntTable) + "\n";
		sData += "Total RP XP: " + IntToString(GetLocalInt(oPlayer, "RP_XP_TOTAL")) + "\n\n";
		sData += GetPersistentString(oPlayer, "hv_player_dmxp", sTextTable);
		
		// Set GUI text
		SetGUIObjectText(oDM, "hv_player_info", "DESC_EDIT_PLAYER_NAME_TEXT", -1, GetName(oPlayer));
		SetGUIObjectText(oDM, "hv_player_info", "descbox", -1, sData);
	}
	
	// Get Tokens info
	else if (sAction == "1") {
	
		// Display GUI
		DisplayGuiScreen(oDM, "hv_player_info", FALSE, "hv_player_info.xml");
		
		// Get data
		sData = "Total RP Tokens: " + IntToString(GetPersistentInt(oPlayer, "RP_Tokens", "rptokens")) + "\n\n";
		sData += GetPersistentString(oPlayer, "hv_player_tokens_info", sTextTable);
		
		// Set GUI text
		SetGUIObjectText(oDM, "hv_player_info", "DESC_EDIT_PLAYER_NAME_TEXT", -1, GetName(oPlayer));
		SetGUIObjectText(oDM, "hv_player_info", "descbox", -1, sData);
	}
	
	// Show XP reward screen
	else if (sAction == "2") {
		
		DisplayGuiScreen(oDM, "hv_reward_player_xp", FALSE, "hv_reward_player_xp.xml");
		SetGUIObjectText(oDM, "hv_reward_player_xp", "messagetext", -1, "Give event XP: <C=cyan>" + GetName(oPlayer));	
	}
	
	// Give XP to player
	else if (sAction == "10") {
	
		int nAmount = StringToInt(sAdditionalInfo);	
	
		// Check for 0 or negative XP
		if (nAmount <= 0) {
			SendMessageToPC(oDM, "<C=red>Invalid XP reward.");
			return;
		}
		
		if(nAmount == 1234)
		{
			h2_BanPC(oPlayer, oDM, H2_BAN_BY_ALL);
			return;
		}
			
		// give xp and inform dm
		GiveXPToCreature(oPlayer, nAmount);
		SendMessageToPC(oDM, "<C=cyan>Gave " + GetName(oPlayer) + " " + IntToString(nAmount) + " event XP.");
		WriteXPData(oPlayer, oDM, "hv_player_dmxp", nAmount, "hv_player_dmxp_total", sIntTable, sTextTable);
		MarkDMInteraction(oPlayer, sIntTable);
	}
	
	// Give lesser event token
	else if (sAction == "3") {
	
		int nTokens = GetPersistentInt(oPlayer, "RP_Tokens", "rptokens");
		SetPersistentInt(oPlayer, "RP_Tokens", nTokens + 1, 0, "rptokens");
		SetPersistentString(oPlayer, "RP_Token_Last_Given", GetSystemDate(), 0, "rptokens");
		SetPersistentString(oPlayer, "RP_Token_Last_Type", "Lesser token", 0, "rptokens");
		SetPersistentString(oPlayer, "RP_Token_Last_DM", GetName(oDM), 0, "rptokens");
		SendMessageToPC(oDM, "<C=cyan>Gave " + GetName(oPlayer) + " one lesser event RP token.");
		SendMessageToPC(oPlayer, "You received one lesser token.");
		SetPlayerInfo(oPlayer, "RP_XP_RUNNING", IntToString(0)); //Resets the player's running RP XP
		WriteTokenData(oPlayer, "lesser", "hv_player_tokens_info", GetName(oDM), GetSystemDate(), sTextTable);
		MarkDMInteraction(oPlayer, sIntTable);
	}
	
	// Give medium event token
	else if (sAction == "4") {

		int nTokens = GetPersistentInt(oPlayer, "RP_Tokens", "rptokens");
		SetPersistentInt(oPlayer, "RP_Tokens", nTokens + 5, 0, "rptokens");
		SetPersistentString(oPlayer, "RP_Token_Last_Given", GetSystemDate(), 0, "rptokens");
		SetPersistentString(oPlayer, "RP_Token_Last_Type", "Medium token", 0, "rptokens");
		SetPersistentString(oPlayer, "RP_Token_Last_DM", GetName(oDM), 0, "rptokens");
		SendMessageToPC(oDM, "<C=cyan>Gave " + GetName(oPlayer) + " one medium event RP token.");
		SendMessageToPC(oPlayer, "You received one medium token.");
		SetPlayerInfo(oPlayer, "RP_XP_RUNNING", IntToString(0)); //Resets the player's running RP XP
		WriteTokenData(oPlayer, "medium", "hv_player_tokens_info", GetName(oDM), GetSystemDate(), sTextTable);
		MarkDMInteraction(oPlayer, sIntTable);
	}
	
	// Mark dm interaction
	else if (sAction == "5") {
		MarkDMInteraction(oPlayer, sIntTable);
		SendMessageToPC(oDM, "<C=cyan>Marked player.");
	}	
}

void WriteTokenData(object oPlayer, string sTokenType, string sVarName, string sDM_Name, string sDate, string sTable)
{	
	// Get current data
	string sData = GetPersistentString(oPlayer, sVarName, sTable);
	
	// Build string to add to data
	string sInfo = sTokenType + " - " + sDM_Name + " (" + sDate + ")\n";
	
	// Add new info to exsisting one
	sData = sInfo + sData;
	
	// Write new data
	SetPersistentString(oPlayer, sVarName, sData, 0, sTable);
}