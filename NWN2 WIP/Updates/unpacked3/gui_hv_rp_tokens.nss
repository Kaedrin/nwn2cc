#include "nwnx_sql"
#include "nwnx_clock"

void main(string sAction, string sReportedItem)
{
	//string LESSER = "RP_Token_L";
	//string MEDIUM = "RP_Token_M";
	//string EPIC = "RP_Token_E";
	string TOKENS = "RP_Tokens";
	string DATE = "RP_Token_Last_Given";
	string DM = "RP_Token_Last_DM";
	string TYPE = "RP_Token_Last_Type";
	string ITEMS = "RP_Token_Items";

	// Get data
	object oPC;
	if (GetIsDM(OBJECT_SELF))
		oPC = GetPlayerCurrentTarget(OBJECT_SELF);
	else
		oPC = OBJECT_SELF;
		
	string sPCName = GetName(oPC);
	string sPlayerName = GetPCPlayerName(oPC);
	string sPlayerCDKey = GetPCPublicCDKey(oPC);
	string sDM = GetName(OBJECT_SELF);
	
	//int nLesserTokens = GetPersistentInt(oPC, LESSER);
	//int nMedTokens = GetPersistentInt(oPC, MEDIUM);
	//int nEpicTokens = GetPersistentInt(oPC, EPIC);
	int nTokens = GetPersistentInt(oPC, TOKENS, "rptokens");
	string sLastGivenDate = GetPersistentString(oPC, DATE, "rptokens");
	string sLastTypeGiven = GetPersistentString(oPC, TYPE, "rptokens");
	string sLastDMGiver = GetPersistentString(oPC, DM, "rptokens");
	string sItems = GetPersistentString(oPC, ITEMS, "rptokens");
	
	string sDate = GetSystemDate();
	
	string sTokenInfo = "RP Token Action: "; // message to write to log file
	
	// if script is only used to list tokens,
	// don't write to log
	int nLogInfo = 1;
	
	// variables to hold info to write to log
	string sTokenType; // lesser/medium/epic
	string sActionTaken; // given or taken
	
	// 1 - List RP Tokens
	if (sAction == "1") {
		nLogInfo = 0; // don't write anything to log as nothing changes
		
		// Calculate how many tokens of each type there are
		int nLesserTokens = 0;
		int nMedTokens = 0;
		int nEpicTokens = 0;
		
		// count epic
		while (nTokens >= 25) {
			nEpicTokens++;
			nTokens = nTokens - 25;
		}
		
		// count medium
		while (nTokens >= 5) {
			nMedTokens++;
			nTokens = nTokens - 5;
		}
		
		// count lesser
		while (nTokens > 0) {
			nLesserTokens++;
			nTokens = nTokens - 1;
		}
			
		string sInfo = "List of RP Tokens for " + sPCName + ":\n";
		sInfo += "Lesser tokens: " + IntToString(nLesserTokens) + "\n";
		sInfo += "Medium tokens: " + IntToString(nMedTokens) + "\n";
		sInfo += "Epic tokens: " + IntToString(nEpicTokens) + "\n";
		
		if ((sLastGivenDate != "") && (GetIsDM(OBJECT_SELF))) {
			sInfo += "Last token given on: " + sLastGivenDate + ".\n";
			sInfo += "Type of last token given: " + sLastTypeGiven + ".\n";
			sInfo += "Given by: " + sLastDMGiver + ".\n";
		}
		
		if ((sItems != "") && (GetIsDM(OBJECT_SELF)))
			sInfo += "List of given items:\n" + sItems;
		
		SendMessageToPC(OBJECT_SELF, sInfo);
	}
	
	// 2 - Give lesser token
	else if (sAction == "2") {
		if (!GetIsDM(OBJECT_SELF))
			return;
	
		//SetPersistentInt(oPC, LESSER, nLesserTokens + 1);
		SetPersistentInt(oPC, TOKENS, nTokens + 1, 0, "rptokens");
		SetPersistentString(oPC, DATE, sDate, 0, "rptokens");
		SetPersistentString(oPC, TYPE, "Lesser token", 0, "rptokens");
		SetPersistentString(oPC, DM, sDM, 0, "rptokens");
		SendMessageToPC(OBJECT_SELF, "Gave " + sPCName + " one lesser RP token.");
		SendMessageToPC(oPC, "You received one lesser token.");
		sTokenType = "lesser";
		sActionTaken = "gave";
	}
	
	// 3 - Give medium token
	else if (sAction == "3") {
		if (!GetIsDM(OBJECT_SELF))
			return;
	
		//SetPersistentInt(oPC, MEDIUM, nMedTokens + 1);
		SetPersistentInt(oPC, TOKENS, nTokens + 5, 0, "rptokens");
		SetPersistentString(oPC, DATE, sDate, 0, "rptokens");
		SetPersistentString(oPC, TYPE, "Medium token", 0, "rptokens");
		SetPersistentString(oPC, DM, sDM, 0, "rptokens");
		SendMessageToPC(OBJECT_SELF, "Gave " + sPCName + " one medium token.");
		SendMessageToPC(oPC, "You received one medium RP token.");
		sTokenType = "medium";
		sActionTaken = "gave";
	}
	
	// 4 - Give epic token
	else if (sAction == "4") {
		if (!GetIsDM(OBJECT_SELF))
			return;
	
		//SetPersistentInt(oPC, EPIC, nEpicTokens + 1);
		SetPersistentInt(oPC, TOKENS, nTokens + 25, 0, "rptokens");
		SetPersistentString(oPC, DATE, sDate, 0, "rptokens");
		SetPersistentString(oPC, TYPE, "Epic token", 0, "rptokens");
		SetPersistentString(oPC, DM, sDM, 0, "rptokens");
		SendMessageToPC(OBJECT_SELF, "Gave " + sPCName + " one epic token.");
		SendMessageToPC(oPC, "You received one epic RP token.");
		sTokenType = "epic";
		sActionTaken = "gave";
	}
	
	// 5 - Take lesser token
	else if (sAction == "5") {
		if (nTokens > 0) {
			if (!GetIsDM(OBJECT_SELF))
				return;
		
			//SetPersistentInt(oPC, LESSER, nLesserTokens - 1);
			SetPersistentInt(oPC, TOKENS, nTokens - 1, 0, "rptokens");
			SendMessageToPC(OBJECT_SELF, "Took one lesser token from " + sPCName + ".");
			SendMessageToPC(oPC, "You exchanged one lesser RP token.");
			sTokenType = "lesser";
			sActionTaken = "took";
		}
		else { // has 0 tokens
			nLogInfo = 0; // don't write anything to log as nothing changes
			SendMessageToPC(OBJECT_SELF, sPCName + " has no lesser tokens.");
		}
	}
	
	// 6 - Take medium token
	if (sAction == "6") {
		if (nTokens > 4) {
			if (!GetIsDM(OBJECT_SELF))
				return;
		
			//SetPersistentInt(oPC, MEDIUM, nMedTokens - 1);
			SetPersistentInt(oPC, TOKENS, nTokens - 5, 0, "rptokens");
			SendMessageToPC(OBJECT_SELF, "Took one medium token from " + sPCName + ".");
			SendMessageToPC(oPC, "You exchanged one medium RP token.");
			sTokenType = "medium";
			sActionTaken = "took";
		}
		else { // has 0 tokens
			nLogInfo = 0; // don't write anything to log as nothing changes
			SendMessageToPC(OBJECT_SELF, sPCName + " has no medium tokens.");
		}
	}
	
	// 7 - Take epic token
	else if (sAction == "7") {
		if (nTokens > 24) {
				if (!GetIsDM(OBJECT_SELF))
					return;
		
			//SetPersistentInt(oPC, EPIC, nEpicTokens - 1);
			SetPersistentInt(oPC, TOKENS, nTokens - 25, 0, "rptokens");
			SendMessageToPC(OBJECT_SELF, "Took one epic token from " + sPCName + ".");
			SendMessageToPC(oPC, "You exchanged one epic RP token.");
			sTokenType = "epic";
			sActionTaken = "took";
		}
		else { // has 0 tokens
			nLogInfo = 0; // don't write anything to log as nothing changes
			SendMessageToPC(OBJECT_SELF, sPCName + " has no epic tokens.");
		}
	}
	
	// 8 - Display token item report GUI
	else if (sAction == "8") {
		nLogInfo = 0;
		DisplayGuiScreen(OBJECT_SELF, "TokenItem", FALSE, "hvtokenitem.xml");
	}
	
	// 9 - Report Item
	else if (sAction == "9") {
		if (!GetIsDM(OBJECT_SELF))
			return;
		nLogInfo = 0;
		if (sReportedItem != "") {
			sItems += sReportedItem + "\n";
			SetPersistentString(oPC, ITEMS, sItems, 0, "rptokens");
			SendMessageToPC(OBJECT_SELF, "Added item.");
		}
	}
	
	if (nLogInfo == 1) {
		sTokenInfo += sDM + " " + sActionTaken + " 1 " + sTokenType;
		
		if (sActionTaken == "took")
			sTokenInfo += " token from ";
		else
			sTokenInfo += " token to ";
			
		sTokenInfo += sPCName + " (" + sPlayerName + "), CD Key = " + sPlayerCDKey;
		WriteTimestampedLogEntry(sTokenInfo);
	}
}