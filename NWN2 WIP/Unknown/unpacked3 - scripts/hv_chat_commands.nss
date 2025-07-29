#include "alex_constants"
#include "hcr2_timers_i"
#include "ginc_param_const"
#include "nwnx_sql"
#include "nwnx_clock"

// Special commands constants

// Chat commands char
const string CHAT_COMMAND_CHAR = "%";

// Help command - list available chat commands
const string HELP_COMMAND = "%help";

// Area shout command - send message to all PCs in area
const string AREA_SHOUT_COMMAND = "%as";

// Area shout style (color and such)
const string AREA_SHOUT_STYLE = "<C=orange>";

// Area XP command - give xp to all players in area
const string AREA_XP_COMMAND = "%axp";

// Port there command - port DM to player she sent a tell to
const string PORT_DM_TO_PC = "%port there";

// Port here command - port player to DM
const string PORT_PC_TO_DM = "%port here";

// Port Party Here commaned - port PCs party to DM
const string PORT_PARTY_TO_DM = "%port party here";

// Display chat manager
const string SHOW_CHAT_MANAGER = "%tell";

// Change AFK Timer, new time set in minutes
const string SET_AFK_TIMER = "%setafktimer";

// Get the current AFK timer interval
const string GET_AFK_TIMER = "%getafktimer";

// Get list of players and their last DM interaction
const string GET_DM_INTERACTION = "%dmlove";

// Send message to PC on login (message of the day)
const string MOTD_COMMAND = "%motd";

// Get login name of the toon you sent this
// in a tell to
const string GET_NAME = "%getname";

// Various player notes commands
const string PLAYER_NOTES = "%playernotes";

// Finding online player helpers
const string GET_HELPERS = "%list_helpers";

// Launch dm notes
const string DM_NOTES = "%dmnotes";

const string ADD_HELPER = "%add_helper";
const string REMOVE_HELPER = "%remove_helper";

// ==================================================================

// Functions declaration

// Check if chat command was called,
// then run the appropriate one.
// Return TRUE if a chat command was called,
// FALSE otherwise.
int DoChatCommand(object oDM, object oTarget, string sChatMessage, int nChannel);

// Check if Help command was called.
// return TRUE if it was called,
// FALSE otherwise.
int CheckHelpCommand(string sChatMessage);

// List all available commands
void DoHelpCommand(object oDM);

// Check if Area Shout code was used in chat.
// return the message to send to players in area,
// or "" if the code was not used / on blank message.
string CheckAreaShout(string sChatMessage);

// Send a message (sMessage) to all PCs in oSender's area
void DoAreaShout(object oSender, string sMessage);

// Check if Area XP code was used in chat,
// and return the amount of XP to give
// and whether it's regular or event xp.
string CheckAreaXP(string sChatMessage);

// Give nXP to all players in DM's area
void GiveAreaXP(object oDM, string sXP);

// Check if port commands were called.
// return 1 for dm to player,
// return 2 for player to dm
// return 3 for party to dm
// return 0 otherwise
int CheckPortCommands(string sChatMessage);

// Do port command, based on port type:
// 1 - DM to PC
// 2 - PC to DM
// 3 - PC's party to DM
void DoPortCommand(int nType, object oDM, object oPC);

// Check if chat manager command was called,
// and return the search string. return "-1" (as string)
// if it wasn't called
string CheckChatManager(string sChatMessage);

// Display chat manager with search string
void DisplayChatManager(object oPC, string sSearchString);

// Check if set afk timer was called.
// Return the time that was set if it was called,
// or -1 if it was not called
int CheckSetAFKTimer(string sChatMessage);

// Stop old timer and start a new one
// with the given fNewTime
void SetNewAFKTimer(float fNewTime);

// Check if get afk timer was called.
// return TRUE if it was,
// FALSE if it wasn't
int CheckGetAFKTimer(string sChatMessage);

// Display current afk timer interval
void GetAFKTimer(object oDM);

// Check if dm interaction list was requested.
// return the requested days since last interaction.
// return -1 if it wasn't called.
// return -2 if token list was requested.
// return -3 if rpxp was requested
// return -4 if eventxp was requested
// return -5 if help was requested
int CheckDMInteraction(string sChatMessage);

// Display list of players and their last dm interaction.
// nDays - filter
void GetDMInteractionListV2(object oDM, int nFilter = 0);

// Get difference in days between current time
// and nCheckTime.
int GetDaysDifference(int nCheckTime, int nNow);

// Store player info
void SetPlayerInfo(object oPC, string sVariableName, string sVariableValue, string sTable = "playerinfo");

// Get player info
string GetPlayerInfo(object oPC, string sVariableName, string sTable = "playerinfo");

// Check if message of the day command was called.
// return the message string if it was, or "" if wasn't.
string CheckMOTD(string sChatMessage);

// Set new message of the day
void SetMOTD(string sMessage);

// sData must be in this format:
// Name1,Data1;Name2,Data2;...
// Data will be sorted and dislayed to oDM
// in ascending or descending order
void SortAndDisplayData(object oDM, string sData, int nDescending = 1);

// Get list of rp tokens players have
void GetTokensList(object oDM, object oTarget, string sChatMessage, int nChannel);

// Get list of rpxp players have
void GetRPXPList(object oDM, object oTarget, string sChatMessage, int nChannel);

// Get list of event xp players have
void GetEventXPList(object oDM, object oTarget, string sChatMessage, int nChannel);

// Show extended help for %dmlove command
void DMLoveHelp(object oDM);

// Check if get name was called
int CheckGetName(string sChatMessage);

// Display the name of the toon this was 
// sent in a tell to
void GetPlayerName(object oDM, object oTarget);

// Check if playernotes was called
int CheckPlayerNotes(string sChatMessage);

// Display playernotes info
void GetPlayerNotes(object oDM, object oTarget, string sChatMessage, int nChannel);

// Write data to DB.
// oPlayer   - the player object we reward.
// oDM       - the DM object who gives the reward.
// sVarName  - "hv_player_dmxp"
// nAmount   - How much xp did we give the player.
// sTotalVarName - variable that holds total amount of xp
void WriteXPData(object oPlayer, object oDM, string sVarName, int nAmount, string sTotalVarName, string sIntTable, string sTextTable);

// Mark last time dm interaction occured
void MarkDMInteraction(object oPlayer, string sTable);

// Check if get helpers waas called
int CheckGetHelpers(string sChatMessage);

// Display list of players helpers to the called
void GetPlayerHelpers(object oDM);

// Check if dm notes was called
int CheckDMNotes(string sChatMessage);

// Display dm notes ui
void ShowDMNotes(object oDM);

// Set helper status for player (0 if not helper, 1 if helper)
void SetHelperState(string player_name, string value);

string CheckAddHelper(string sChatMessage);
string CheckRemoveHelper(string sChatMessage);

// ================================================================

// Functions implementation

// Check if chat command was called,
// then run the appropriate one.
// Return TRUE if a chat command was called,
// FALSE otherwise.
int DoChatCommand(object oDM, object oTarget, string sChatMessage, int nChannel)
{	
	// If it's not a DM or NPC controlled by one, do nothing.
	if ((!GetIsDM(oDM)) && (!GetIsDMPossessed(oDM)))
		return FALSE;

	// Check if '%' is the first char.
	if (!(GetStringLeft(sChatMessage, 1) == CHAT_COMMAND_CHAR)) {
		
		return FALSE; // No chat command was called.
	}	
		
	// Check for help command
	if (CheckHelpCommand(sChatMessage)) {
	
		DoHelpCommand(oDM);
		return TRUE;
	}
	
	// Check for area shout
	string sASMessage = CheckAreaShout(sChatMessage);
	if (sASMessage != "") {
	
		DoAreaShout(oDM, sASMessage);
		return TRUE;
	}
	
	// Check for area xp
	string sXP = CheckAreaXP(sChatMessage);
	if (GetStringLength(sXP) > 0) {
	
		GiveAreaXP(oDM, sXP);
		return TRUE;
	}
	
	// Check for Port commands
	if (nChannel == CHAT_MODE_TELL) {
		int nPortType = CheckPortCommands(sChatMessage);
		if (nPortType != 0) {
	
			DoPortCommand(nPortType, oDM, oTarget);
			return TRUE;
		}
	}
	
	// Check for chat manager command
	string sSearchString = CheckChatManager(sChatMessage);
	if (sSearchString != "-1") {
	
		DisplayChatManager(oDM, sSearchString);
		return TRUE;
	}
	
	// Check for set new afk timer command
	int nNewAFKTimer = CheckSetAFKTimer(sChatMessage);
	if (nNewAFKTimer != -1) {
		
		// Make sure new check time is greater than 1 minute
		// To avoid issues
		if (nNewAFKTimer <= 1)
			SendMessageToPC(oDM, "<C=cyan>New time must be greater than 1.");
		else {
		
			// Convert to seconds
			float fNewAFKTimer = IntToFloat(nNewAFKTimer) * 60;
			SetNewAFKTimer(fNewAFKTimer);
			
			// Announce change
			SendMessageToAllDMs("New AFK Timer was set to " + FloatToString(fNewAFKTimer / 60, 18, 1) + " minutes by " + GetName(oDM) + ".");
		}
		return TRUE;
	}
	
	// Check for get afk timer
	if (CheckGetAFKTimer(sChatMessage)) {
		
		GetAFKTimer(oDM);
		return TRUE;
	}
	
	// Check for dm interaction list command
	int nFilter = CheckDMInteraction(sChatMessage);
	if (nFilter > -1) {
	
		GetDMInteractionListV2(oDM, nFilter);
		return TRUE;
	}
	else if (nFilter == -2) {
	
		GetTokensList(oDM, oTarget, sChatMessage, nChannel);
		return TRUE;
	}
	else if (nFilter == -3) {
		
		GetRPXPList(oDM, oTarget, sChatMessage, nChannel);
		return TRUE;
	}
	else if (nFilter == -4) {
	
		GetEventXPList(oDM, oTarget, sChatMessage, nChannel);
		return TRUE;
	}
	else if (nFilter == -5) {
	
		DMLoveHelp(oDM);
		return TRUE;
	}
	
	// Check dm notes command
	if (CheckDMNotes(sChatMessage) == TRUE)
	{
		ShowDMNotes(oDM);
		return TRUE;
	}
	
	// Check for message of the day command
	string sMOTD = CheckMOTD(sChatMessage);
	if (sMOTD != "") {
	
		SetMOTD(sMOTD);
		return TRUE;
	}
	
	// Check for get name command
	if (CheckGetName(sChatMessage) == TRUE) {
	
		GetPlayerName(oDM, oTarget);
		return TRUE;
	}
	
	// Check player notes
	if (CheckPlayerNotes(sChatMessage) == TRUE) {
	
		GetPlayerNotes(oDM, oTarget, sChatMessage, nChannel);
		return TRUE;
	}
	
	// Check get helpers command
	if (CheckGetHelpers(sChatMessage) == TRUE) {
	
		GetPlayerHelpers(oDM);
		return TRUE;
	}
	
	// helpersssss
	string player_name = CheckAddHelper(sChatMessage);
	if (player_name != "") {
	
		SetHelperState(player_name, "1");
		SendMessageToPC(oDM, "Added " + player_name);
		return TRUE;
	}
	
	player_name = CheckRemoveHelper(sChatMessage);
	if (player_name != "") {
	
		SetHelperState(player_name, "0");
		SendMessageToPC(oDM, "Removed " + player_name);
		return TRUE;
	}
	
	
	// Check if '%' is the first char. if we got here
	// with this char, an unrecognized command was entered.
	if (GetStringLeft(sChatMessage, 1) == CHAT_COMMAND_CHAR) {
		
		SendMessageToPC(oDM, "<C=cyan>Unrecognized command. Type " + HELP_COMMAND + " for a list of commands.");
		return TRUE;
	}
		
	// No command was run.
	return FALSE;
}

// Check if Help command was called.
// return TRUE if it was called,
// FALSE otherwise.
int CheckHelpCommand(string sChatMessage)
{
	// Get length of help code
	int nCommandLength = GetStringLength(HELP_COMMAND);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == HELP_COMMAND) {
		
		return TRUE;
	}
	
	return FALSE;
}

// List all available commands
void DoHelpCommand(object oDM)
{
	// Construct help message
	string sHelpMessage = "<C=orange>%as [message] - Send message to all players in your area.\n"
						+ "%axp [XP number] -reg|-event - Give XP to all players in your area. Use -reg for regular xp and -event for event xp.\n"
						+ "%port there - Jump to the PC you sent this in a tell to.\n"
						+ "%port here - Jump the PC you sent this in a tell to you.\n"
						+ "%port party here - Jump the PC's party you sent this in a tell to you.\n"
						+ "%tell [search] - display chat manager with player name to search.\n"
						+ "%setafktimer [minutes] - Set new interval for checking AFK players.\n"
						+ "%getafktimer - Get current AFK check interval.\n"
						+ "%dmlove [days] - Type '%dmlove -help' for detailed help.\n"
						+ "%motd [message] - Set the message of the day.\n"
						+ "%getname - Get the name of the player you sent this in a tell to.\n"
						+ "%playernotes [-all] - Get list of players with content in their notes. Use -all to get the content as well. Send in a tell to get content only for that player.\n"
						+ "%add_helper [player_name] - Add player helpers.\n"
						+ "%remove_helper [player_name] - Remove player helpers.\n"
						+ "%list_helpers - List player helpers.\n"
						+ "%dmnotes - launch DM Notes UI.";						
						
	// Send help message to the DM
	SendMessageToPC(oDM, sHelpMessage);
}

// Check if Area Shout code was used in chat.
// return the message to send to players in area,
// or "" if the code was not used / on blank message.
string CheckAreaShout(string sChatMessage)
{
	// Return string
	string sMessage = "";	

	// Get length of area shout code
	int nCommandLength = GetStringLength(AREA_SHOUT_COMMAND);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == AREA_SHOUT_COMMAND) {
		
		// Get length of real message (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the real message
		sMessage = GetSubString(sChatMessage, nCommandLength, nMessageLength);
	}
	
	// Return what we have
	return sMessage;
}

// Send a message (sMessage) to all PCs in oSender's area
void DoAreaShout(object oSender, string sMessage)
{
	// Get oSender's area
	object oArea = GetArea(oSender);

	// Loop through all PCs in module
	object oPC = GetFirstPC();
	while (GetIsObjectValid(oPC)) {
		
		// Is she in the same area as oArea ?
		if (GetArea(oPC) == oArea) {
			
			// Send her the message
			SendChatMessage(OBJECT_INVALID, oPC, CHAT_MODE_SERVER, AREA_SHOUT_STYLE + sMessage);
		}
		
		// Get next PC
		oPC = GetNextPC();
	}
}

// Check if Area XP code was used in chat,
// and return the amount of XP to give
// and whether it's regular xp or event xp.
string CheckAreaXP(string sChatMessage)
{
	// Return int
	string sXP = "";

	// Get length of area xp code
	int nCommandLength = GetStringLength(AREA_XP_COMMAND);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == AREA_XP_COMMAND) {
		
		// Get length of real message (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the real message and convert to integer
		sXP = GetSubString(sChatMessage, nCommandLength, nMessageLength);
	}
	
	// Return what we have
	return sXP;
}

// Give nXP to all players in DM's area
void GiveAreaXP(object oDM, string sXP)
{
	// Regular XP or event XP?
	int bEventXP;
	if (FindSubString(sXP, "-reg") != -1)
		bEventXP = FALSE;
	else if (FindSubString(sXP, "-event") != -1)
		bEventXP = TRUE;
	else {
		SendMessageToPC(oDM, "<C=red>Select regular or event xp (-reg/-event).");
		return;
	}
	
	// Get XP amount to give
	int nXP = StringToInt(sXP);
	
	if (nXP <= 0) {
		SendMessageToPC(oDM, "<C=red>Select amount of XP to give.");
		return;
	}
	
	// Get DM's area
	object oArea = GetArea(oDM);
	
	// Loop through all PCs in module
	object oPC = GetFirstPC();
	while (GetIsObjectValid(oPC)) {
		
		// Is she in the same area as oArea ?
		if (GetArea(oPC) == oArea) {
			
			// Give XP
			GiveXPToCreature(oPC, nXP);
			
			// Mark as event xp if needed
			if (bEventXP) {
			WriteXPData(oPC, oDM, "hv_player_dmxp", nXP, "hv_player_dmxp_total", "playerinfo", "playernotes");
			MarkDMInteraction(oPC, "playerinfo");
			}
			
			// Inform DM
			if (bEventXP)
				SendMessageToPC(oDM, "<C=pink>Gave " + GetName(oPC) + " " + IntToString(nXP) + " event XP.");
			else
				SendMessageToPC(oDM, "<C=pink>Gave " + GetName(oPC) + " " + IntToString(nXP) + " regular XP.");
		}
		
		// Get next PC
		oPC = GetNextPC();
	}
}

// Check if port commands were called.
// return 1 for dm to player,
// return 2 for player to dm
// return 3 for party to dm
// return 0 otherwise
int CheckPortCommands(string sChatMessage)
{
	// check for PORT_DM_TO_PC
	// Get length of help code
	int nCommandLength = GetStringLength(PORT_DM_TO_PC);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == PORT_DM_TO_PC) {
		
		return 1;
	}
	
	// check for PORT_PC_TO_DM
	// Get length of help code
	nCommandLength = GetStringLength(PORT_PC_TO_DM);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == PORT_PC_TO_DM) {
		
		return 2;
	}
	
	// check for PORT_PARTY_TO_DM
	// Get length of help code
	nCommandLength = GetStringLength(PORT_PARTY_TO_DM);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == PORT_PARTY_TO_DM) {
		
		return 3;
	}
	
	// No port command was called
	return 0;
}

// Do port command, based on port type:
// 1 - DM to PC
// 2 - PC to DM
// 3 - PC's party to DM
void DoPortCommand(int nType, object oDM, object oPC)
{
	// Check that objects are vaild.
	if ((!GetIsDM(oDM)) || (!GetIsPC(oPC)))
		return;

	// DM to PC
	if (nType == 1) {
		
		AssignCommand(oDM, JumpToObject(oPC));
	}
	// PC to DM
	else if (nType == 2) {
	
		AssignCommand(oPC, JumpToObject(oDM));
	}
	// Party to DM
	else if (nType == 3) {
	
		JumpPartyToArea(oPC, oDM);
	}	
}

// Check if chat manager command was called,
// and return the search string. return "-1" (as string)
// if it wasn't called
string CheckChatManager(string sChatMessage)
{
	// Return string
	string sSearchString = "-1";

	// Get length of chat manager code
	int nCommandLength = GetStringLength(SHOW_CHAT_MANAGER);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == SHOW_CHAT_MANAGER) {
		
		// Get length of search string (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the search string
		sSearchString = GetSubString(sChatMessage, nCommandLength + 1, nMessageLength);
	}
	
	// Return what we have
	return sSearchString;
}

// Display chat manager with search string
void DisplayChatManager(object oPC, string sSearchString)
{
	// Display GUI
	DisplayGuiScreen(oPC, "hv_chat_manager", FALSE, "hv_chat_manager.xml");
	
	// Set the search string as the local variable
	SetLocalGUIVariable(oPC, "hv_chat_manager", 0, sSearchString);
	
	// Display the search string at the search box
	SetGUIObjectText(oPC, "hv_chat_manager", "playersearch", -1, sSearchString);
	
	// Add the search string as the script parameter
	AddScriptParameterString(sSearchString);
	
	// Update the list
	ExecuteScriptEnhanced("gui_hv_chat_manager", oPC);
}

// Check if set afk timer was called.
// Return the time that was set if it was called,
// or -1 if it was not called
int CheckSetAFKTimer(string sChatMessage)
{
	// Return int
	int nNewTimer = -1;

	// Get length of afk timer code
	int nCommandLength = GetStringLength(SET_AFK_TIMER);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == SET_AFK_TIMER) {
		
		// Get length of new time (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the new time
		nNewTimer = StringToInt(GetSubString(sChatMessage, nCommandLength + 1, nMessageLength));
	}
	
	// Return what we have
	return nNewTimer;
}

// Stop old timer and start a new one
// with the given fNewTime
void SetNewAFKTimer(float fNewTime)
{
	// Get current timer
	int AFKTimer = GetLocalInt(GetModule(), AFK_TIMER_INT);
	
	// Stop current timer
	h2_KillTimer(AFKTimer);
	
	// Mark all players as not-afk, because when we start the timer
	// the script fires right away
	object oPC = GetFirstPC();
	while (GetIsPC(oPC)) {
	
		SetLocalInt(oPC, AFK_CHAT, 1);
		oPC = GetNextPC();
	}
	
	// Create a new one
	int AFKCheckTimer = h2_CreateTimer(GetModule(), AFK_SCRIPT1, fNewTime);
	h2_StartTimer(AFKCheckTimer);
	SetLocalFloat(GetModule(), AFK_CHECK_TIME, fNewTime);
	SetLocalInt(GetModule(), AFK_TIMER_INT, AFKCheckTimer);
}

// Check if get afk timer was called.
// return TRUE if it was,
// FALSE if it wasn't
int CheckGetAFKTimer(string sChatMessage)
{
	// Get length of afk timer code
	int nCommandLength = GetStringLength(GET_AFK_TIMER);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == GET_AFK_TIMER) {
		
		return TRUE;
	}
	
	// The command was not called
	return FALSE;	
}

// Display current afk timer interval
void GetAFKTimer(object oDM)
{
	SendMessageToPC(oDM, "<C=cyan>Current AFK check interval is set to " + FloatToString(GetLocalFloat(GetModule(), AFK_CHECK_TIME) / 60, 18, 1) + " minutes.");
}

// Check if dm interaction list was requested.
// return the requested days since last interaction.
// return -1 if it wasn't called.
// return -2 if token list was requested.
// return -3 if rpxp was requested
// return -4 if eventxp was requested
// return -5 if help was requested
int CheckDMInteraction(string sChatMessage)
{
	// Return int
	int nDays = 0;

	// Get length of dm interactionr code
	int nCommandLength = GetStringLength(GET_DM_INTERACTION);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == GET_DM_INTERACTION) {
		
		// Check for -tokens
		if (FindSubString(sChatMessage, "-tokens") != -1)
			return -2;
			
		// Check for rpxp
		if (FindSubString(sChatMessage, "-rpxp") != -1)
			return -3;
		
		// Check for eventxp
		if (FindSubString(sChatMessage, "-eventxp") != -1)
			return -4;
		
		// Check for help
		if (FindSubString(sChatMessage, "-help") != -1)
			return -5;	
		
		// Get length of days filter (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the new time
		nDays = StringToInt(GetSubString(sChatMessage, nCommandLength + 1, nMessageLength));
		
		return nDays;
	}
	
	// The command was not called if we got here
	return -1;
}

// Get difference in days between current time
// and nCheckTime.
int GetDaysDifference(int nCheckTime, int nNow)
{
	int nPeriod = nNow - nCheckTime;
	
	int ONE_DAY = 86400;
	int nDays = 0;
	
	nDays = nPeriod / ONE_DAY;
	
	return nDays;		
}

// sData must be in this format:
// Name1,Data1;Name2,Data2;...
// Data will be sorted and dislayed to oDM
// in ascending or descending order
void SortAndDisplayData(object oDM, string sData, int nDescending = 1)
{
	string sTempData = "";
	string sPlayer = "";
	int nValue = 0;
	int nMinOrMax = 0;
	int nPosition = 0;
	int i = 0;
	
	while (sData != "") {
		// Reset vars
		sTempData = "";
		sPlayer = "";
		
		if (nDescending == 1)
			nMinOrMax = 0;
		else
			nMinOrMax = 999999;			
		nPosition = 0;
		i = 0;
		
		// Get first value
		string sValue = GetStringParam(GetStringParam(sData, i, ";"), 1, ",");
	
		// Go over all string to find min/max days
		while (sValue != "") {
	
			nValue = StringToInt(sValue);
			
			// Check if we need data to be sorted ascending or 
			// descending
			if (((nDescending == 1) && (nMinOrMax < nValue))
				||
				((nDescending == 0) && (nMinOrMax > nValue)))
			{
					// Store min or max value and position
					nMinOrMax = nValue;
					nPosition = i;
			}
		
			// Get next day value
			i++;
			sValue = GetStringParam(GetStringParam(sData, i, ";"), 1, ",");
		}
	
	
		// Get player name
		sPlayer = GetStringParam(GetStringParam(sData, nPosition, ";"), 0, ",");
		
		// Output
		SendMessageToPC(oDM, "<C=lightgreen>" + sPlayer + " - " + IntToString(nMinOrMax));
	
		// Reconstruct data without the min or max we found
		i = 0;
		sValue = GetStringParam(GetStringParam(sData, i, ";"), 1, ",");
		sTempData = "";
		while (sValue != "") {
	
			if (i != nPosition) {
				sPlayer = GetStringParam(GetStringParam(sData, i, ";"), 0, ",");
				sTempData += sPlayer + "," + sValue + ";";
			}
		
			i++;
			sValue = GetStringParam(GetStringParam(sData, i, ";"), 1, ",");
		}
		
		sData = sTempData;
	}
}

// Store player info
void SetPlayerInfo(object oPC, string sVariableName, string sVariableValue, string sTable = "playerinfo")
{
	if (!GetIsPC(oPC))
		return;
		
    string sPlayer      = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
	string sFirstName 	= SQLEncodeSpecialChars(GetFirstName(oPC));
	string sLastName	= SQLEncodeSpecialChars(GetLastName(oPC));
    string sVarName     = SQLEncodeSpecialChars(sVariableName);
    string sValue       = SQLEncodeSpecialChars(sVariableValue);

    string sSQL = "SELECT Player FROM " + sTable + " WHERE Player='" + sPlayer +
        "' AND FirstName='" + sFirstName + "' AND LastName='" + sLastName + "'" +
		"  AND VarName='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET Value='" + sValue +
            "' WHERE Player='" + sPlayer +
            "' AND FirstName='" + sFirstName + "' AND LastName='" + sLastName + "'" +
			"  AND VarName='" + sVarName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (Player,FirstName,LastName,VarName,Value) VALUES" +
            "('" + sPlayer + "','" + sFirstName + "','" + sLastName + "','" +
            sVarName + "','" + sValue + "')";
        SQLExecDirect(sSQL);
    }
}

// Get player info
string GetPlayerInfo(object oPC, string sVariableName, string sTable = "playerinfo")
{
	if (!GetIsPC(oPC))
		return "";
	
	string sPlayer      = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
	string sFirstName 	= SQLEncodeSpecialChars(GetFirstName(oPC));
	string sLastName	= SQLEncodeSpecialChars(GetLastName(oPC));
    string sVarName     = SQLEncodeSpecialChars(sVariableName);	
	
	string sSQL = "SELECT Value FROM " + sTable + " WHERE Player='" + sPlayer +
        "' AND FirstName='" + sFirstName + "' AND LastName='" + sLastName + "'" +
		"  AND VarName='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLGetData(1);
    else
        return "";
}

void GetDMInteractionListV2(object oDM, int nFilter = 0)
{
	string sSQL = "SELECT playerinfo.FirstName,playerinfo.LastName,playerinfo.Value " +
				  "FROM playerinfo,characters " +
				  "WHERE playerinfo.Player = characters.Player " +
				  "AND playerinfo.FirstName = characters.FirstName " +
				  "AND playerinfo.LastName = characters.LastName " +
				  "AND characters.Online='1' " +
				  "AND playerinfo.VarName='hv_dm_interaction'" +
				  "ORDER BY playerinfo.Value";
	SQLExecDirect(sSQL);
	
	int nNow = GetUNIXTime();
	string sPlayer = "";
	string sDays;
	int nDays = 0;
    while (SQLFetch() == SQL_SUCCESS) {
		
		// Get player name
		sPlayer = SQLGetData(1) + " " + SQLGetData(2);
		
		sDays = SQLGetData(3);
		// Check for "never" (0)
		if (sDays == "0")
			SendMessageToPC(oDM, "<C=cyan>" + sPlayer + " - never.");
		else {
		
			nDays = StringToInt(sDays);
			nDays = GetDaysDifference(nDays, nNow);
			if (nDays >= nFilter)
				SendMessageToPC(oDM, "<C=cyan>" + sPlayer + " - " + IntToString(nDays) + " days ago.");
		}
	}	
}

// Check if message of the day command was called.
// return the message string if it was, or "" if wasn't.
string CheckMOTD(string sChatMessage)
{
	// Return string
	string sMessage = "";

	// Get length of chat manager code
	int nCommandLength = GetStringLength(MOTD_COMMAND);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == MOTD_COMMAND) {
		
		// Get length of search string (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the search string
		sMessage = GetSubString(sChatMessage, nCommandLength + 1, nMessageLength);
	}
	
	// Return what we have
	return sMessage;	
}

// Set new message of the day
void SetMOTD(string sMessage)
{
	SetLocalString(GetModule(), "hv_motd", sMessage);
	SendMessageToAllDMs("New message of the day:\n" + sMessage);
}

// Get list of rp tokens players have
void GetTokensList(object oDM, object oTarget, string sChatMessage, int nChannel)
{
	int nTokens = 0;
	int nSorted = FALSE;
	
	// If it's in a tell, return tokens for player it 
	// was sent to
	if (nChannel == CHAT_MODE_TELL) {
	
		nTokens = GetPersistentInt(oTarget, "RP_Tokens", "rptokens");
		SendMessageToPC(oDM, "<C=cyan>" + GetName(oTarget) + " - " + IntToString(nTokens) + " tokens.");
		return;
	}
	
	// Was sorted requested?
	if (FindSubString(sChatMessage, "-sort") != -1)
		nSorted = TRUE;
	
	// Go over all PCs
	string sData = "";
	object oPC = GetFirstPC();
	while(GetIsObjectValid(oPC)) {
	
		// Get tokens
		nTokens = GetPersistentInt(oPC, "RP_Tokens", "rptokens");
		
		// Collect data is a sorted list was requested
		if (nSorted == TRUE)
			sData += GetName(oPC) + "," + IntToString(nTokens) + ";";
		else
			SendMessageToPC(oDM, "<C=cyan>" + GetName(oPC) + " - " + IntToString(nTokens) + " tokens.");
	
		// Next PC
		oPC = GetNextPC();
	}
	
	// Sort and output collected data if sorted list was 
	// requested
	if (nSorted == TRUE)
		SortAndDisplayData(oDM, sData);
}

// Get list of rpxp players have
void GetRPXPList(object oDM, object oTarget, string sChatMessage, int nChannel)
{
	int nRPXP = 0;
	// If it's in a tell, return rp xp of player it
	// was sent to
	if (nChannel == CHAT_MODE_TELL) {
	
		if (FindSubString(sChatMessage, "-total") != -1)
			nRPXP = StringToInt(GetPlayerInfo(oTarget, "RP_XP_TOTAL"));
		else
			nRPXP = GetLocalInt(oTarget, "RP_XP");
		SendMessageToPC(oDM, "<C=pink>" + GetName(oTarget) + " - " + IntToString(nRPXP) + " rp xp.");
		return;
	}

	// Was total rp xp requested?
	if (FindSubString(sChatMessage, "-total") != -1) {

		string sSQL = "SELECT playerinfo.FirstName,playerinfo.LastName,playerinfo.Value " +
				  	"FROM playerinfo,characters " +
				  	"WHERE playerinfo.Player = characters.Player " +
				  	"AND playerinfo.FirstName = characters.FirstName " +
				  	"AND playerinfo.LastName = characters.LastName " +
				  	"AND characters.Online='1' " +
				  	"AND playerinfo.VarName='RP_XP_TOTAL'" +
				  	"ORDER BY playerinfo.Value";
		SQLExecDirect(sSQL);
		
		string sPlayer = "";
    	while (SQLFetch() == SQL_SUCCESS) {
		
			// Get player name
			sPlayer = SQLGetData(1) + " " + SQLGetData(2);
		
			nRPXP = StringToInt(SQLGetData(3));
			SendMessageToPC(oDM, "<C=pink>" + sPlayer + " - " + IntToString(nRPXP) + " rp xp.");
		}
	}
	else {	
	
		int nSorted = FALSE;
		// Was sorted requested?
		if (FindSubString(sChatMessage, "-sort") != -1)
			nSorted = TRUE;
	
		// Go over all PCs
		string sData = "";
		object oPC = GetFirstPC();
		while(GetIsObjectValid(oPC)) {
	
			nRPXP = GetLocalInt(oPC, "RP_XP");
		
			// Collect data if a sorted list was requested
			if (nSorted == TRUE)
				sData += GetName(oPC) + "," + IntToString(nRPXP) + ";";
			else
				SendMessageToPC(oDM, "<C=pink>" + GetName(oPC) + " - " + IntToString(nRPXP) + " rp xp.");
	
			// Next PC
			oPC = GetNextPC();
		}
	
		// Sort and output collected data if sorted list was 
		// requested
		if (nSorted == TRUE)
			SortAndDisplayData(oDM, sData);
	}
}

// Get list of event xp players have
void GetEventXPList(object oDM, object oTarget, string sChatMessage, int nChannel)
{
	int nEventXP = 0;

	// If it's in a tell, return event xp for player it 
	// was sent to
	if (nChannel == CHAT_MODE_TELL) {
	
		nEventXP = StringToInt(GetPlayerInfo(oTarget, "hv_player_dmxp_total", "playerinfo"));
		SendMessageToPC(oDM, "<C=yellow>" + GetName(oTarget) + " - " + IntToString(nEventXP) + " event xp.");
		return;
	}
	
	string sSQL = "SELECT playerinfo.FirstName,playerinfo.LastName,playerinfo.Value " +
				  "FROM playerinfo,characters " +
				  "WHERE playerinfo.Player = characters.Player " +
				  "AND playerinfo.FirstName = characters.FirstName " +
				  "AND playerinfo.LastName = characters.LastName " +
				  "AND characters.Online='1' " +
				  "AND playerinfo.VarName='hv_player_dmxp_total'" +
				  "ORDER BY playerinfo.Value";
	SQLExecDirect(sSQL);
	
	string sPlayer = "";
    while (SQLFetch() == SQL_SUCCESS) {
		
		// Get player name
		sPlayer = SQLGetData(1) + " " + SQLGetData(2);
		
		nEventXP = StringToInt(SQLGetData(3));
		SendMessageToPC(oDM, "<C=yellow>" + sPlayer + " - " + IntToString(nEventXP) + " event xp.");
	}	
}

// Show extended help for %dmlove command
void DMLoveHelp(object oDM)
{
	string sMessage = "%dmlove [days] : List of last time players got DM attention.\n"
					+ "%dmlove -tokens : List how many tokens players have.\n"
					+ "%dmlove -rpxp : List how much rp xp players have from last server reset.\n"
					+ "%dmlove -rpxp -total : Get total rp xp from database.\n"
					+ "%dmlove -eventxp : List event xp players have.\n"
					+ "*Sent in a tell to a player, -tokens/-rpxp/-eventxp will return results only for that player.\n"
					+ "**Add -sort for -tokens or -rpxp to get a sorted list. Use sparingly.";
	SendMessageToPC(oDM, sMessage);
}

// Check if get name was called
int CheckGetName(string sChatMessage)
{
	// Get length of code
	int nCommandLength = GetStringLength(GET_NAME);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == GET_NAME) {
		
		return TRUE;
	}
	
	// The command was not called
	return FALSE;	
}

// Display the name of the toon this was 
// sent in a tell to
void GetPlayerName(object oDM, object oTarget)
{
	if (GetIsPC(oTarget))
		SendMessageToPC(oDM, "<C=lightgreen>" + GetName(oTarget) + " - " + GetPCPlayerName(oTarget));
}

// Check if playernotes was called
int CheckPlayerNotes(string sChatMessage)
{
	// Get length of code
	int nCommandLength = GetStringLength(PLAYER_NOTES);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == PLAYER_NOTES) {
		
		return TRUE;
	}
	
	// The command was not called
	return FALSE;
}

// Display playernotes info
void GetPlayerNotes(object oDM, object oTarget, string sChatMessage, int nChannel)
{	
	string sNotes = "";
	int nAll = FALSE;
	
	// If it's in a tell, return player notes for player it 
	// was sent to
	if (nChannel == CHAT_MODE_TELL) {
	
		sNotes = GetPersistentString(oTarget, "hv_player_notes", "playernotes");
		SendMessageToPC(oDM, "<C=cyan>" + GetName(oTarget) + ":\n" + sNotes);
		return;
	}
	
	// Content of playernotes was requested?
	if (FindSubString(sChatMessage, "-all") != -1)
		nAll = TRUE;
	
	object oPC = GetFirstPC();
	while(GetIsObjectValid(oPC)) {
	
		// Get notes
		sNotes = GetPersistentString(oPC, "hv_player_notes", "playernotes");
		
		// If has notes, report
		if (sNotes != "") {
		
			if (nAll == TRUE)
				SendMessageToPC(oDM, "<C=lightgreen>" + GetName(oPC) + ":\n" + sNotes + "\n##########");
			else
				SendMessageToPC(oDM, "<C=lightgreen>" + GetName(oPC));
		}
	
		// Next PC
		oPC = GetNextPC();
	}
}

// Write data to DB.
// oPlayer   - the player object we reward.
// oDM       - the DM object who gives the reward.
// sVarName  - "hv_player_dmxp"
// nAmount   - How much xp did we give the player.
// sTotalVarName - variable that holds total amount of xp
void WriteXPData(object oPlayer, object oDM, string sVarName, int nAmount, string sTotalVarName, string sIntTable, string sTextTable)
{	
	// Get information to log
	string sDM_Name = GetName(oDM);
	string sDate = GetSystemDate();
	
	// Get current data
	string sData = GetPersistentString(oPlayer, sVarName, sTextTable);
	int nTotal = StringToInt(GetPlayerInfo(oPlayer, sTotalVarName, sIntTable));
	
	// Build string to add to data
	string sInfo = IntToString(nAmount) + " - " + sDM_Name + " (" + sDate + ")\n";
	
	// Add new info to exsisting one
	sData = sInfo + sData;
	nTotal = nTotal + nAmount;
	
	// Write new data
	SetPersistentString(oPlayer, sVarName, sData, 0, sTextTable);
	SetPlayerInfo(oPlayer, sTotalVarName, IntToString(nTotal), sIntTable);
}

// Mark last time dm interaction occured
void MarkDMInteraction(object oPlayer, string sTable)
{
	SetPlayerInfo(oPlayer, "hv_dm_interaction", IntToString(GetUNIXTime()), sTable);	 
}

// Check if get helpers waas called
int CheckGetHelpers(string sChatMessage)
{
	// Get length of code
	int nCommandLength = GetStringLength(GET_HELPERS);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == GET_HELPERS) {
		
		return TRUE;
	}
	
	// The command was not called
	return FALSE;	
}

// Display list of players helpers to the called
void GetPlayerHelpers(object oDM)
{
	// Get list from database
	string sTable = "dbtools";
	string sTag = "PLAYER_HELPERS";
	string sVarName = "is_helper";
	string sSQL = "SELECT player FROM " + sTable + " WHERE name='" + sVarName + "' AND val='1'";
    SQLExecDirect(sSQL);

	SendMessageToPC(oDM, "Listing helpers...");
	
	string player_name = "";
    while (SQLFetch() == SQL_SUCCESS) {
        player_name = SQLGetData(1);
		SendMessageToPC(oDM, player_name);
	}
}

// Check if dm notes was called
int CheckDMNotes(string sChatMessage)
{
	// Get length of code
	int nCommandLength = GetStringLength(DM_NOTES);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == DM_NOTES) {
		
		return TRUE;
	}
	
	// The command was not called
	return FALSE;
}

// Display dm notes ui
void ShowDMNotes(object oDM)
{
	DisplayGuiScreen(oDM, "hv_dm_notes", FALSE, "hvdmnotes.xml");
}

void SetHelperState(string player_name, string value)
{
    player_name = SQLEncodeSpecialChars(player_name);
	string table = "dbtools";
	string tag = "PLAYER_HELPERS";
	string var_name = "is_helper";
	
	
    string sSQL = "SELECT player FROM " + table + " WHERE player='" + player_name +
        "' AND tag='" + tag + "' AND name='" + var_name + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + table + " SET val='" + value +
            "',expire=" + IntToString(0) + " WHERE player='" + player_name +
            "' AND tag='" + tag + "' AND name='" + var_name + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + table + " (player,tag,name,val,expire) VALUES" +
            "('" + player_name + "','" + tag + "','" + var_name + "','" +
            value + "'," + IntToString(0) + ")";
        SQLExecDirect(sSQL);
    }
}

string CheckAddHelper(string sChatMessage)
{
	// Return string
	string sMessage = "";

	// Get length of chat manager code
	int nCommandLength = GetStringLength(ADD_HELPER);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == ADD_HELPER) {
		
		// Get length of search string (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the search string
		sMessage = GetSubString(sChatMessage, nCommandLength + 1, nMessageLength);
	}
	
	// Return what we have
	return sMessage;
}

string CheckRemoveHelper(string sChatMessage)
{
	// Return string
	string sMessage = "";

	// Get length of chat manager code
	int nCommandLength = GetStringLength(REMOVE_HELPER);
	
	// Check if sChatMessage starts with the code
	if (GetStringLeft(sChatMessage, nCommandLength) == REMOVE_HELPER) {
		
		// Get length of search string (entire message minues command length).
		int nMessageLength = GetStringLength(sChatMessage) - nCommandLength;
		
		// Retrieve the search string
		sMessage = GetSubString(sChatMessage, nCommandLength + 1, nMessageLength);
	}
	
	// Return what we have
	return sMessage;
}