#include "nwnx_sql"

// Handles player notes GUI.
// sAction - Open GUI (0)/ Get Data (1) / Write Data (2) / Clear GUI text (3).
// sNotes - String to write to database.
void main(string sAction, string sNotes = "")
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	object oDM = OBJECT_SELF;
	object oPlayer = GetPlayerCurrentTarget(oDM);
	
	// Make sure we are targeting a PC
	if (!GetIsPC(oPlayer)) {
		SendMessageToPC(oDM, "Invalid target.");
		return;
	}
	
	string sPlayerNotes = "";
	
	// Display player notes GUI
	if (sAction == "0") {
		DisplayGuiScreen(oDM, "hv_player_notes", FALSE, "hv_player_notes.xml");
		sPlayerNotes = GetPersistentString(oPlayer, "hv_player_notes", "playernotes");
		SetGUIObjectText(oDM, "hv_player_notes", "descbox", -1, sPlayerNotes);
		SetGUIObjectText(oDM, "hv_player_notes", "DESC_EDIT_PLAYER_NAME_TEXT", -1, GetName(oPlayer));
	}
	else if (sAction == "1") { // Get notes from DB and display on GUI
		sPlayerNotes = GetPersistentString(oPlayer, "hv_player_notes", "playernotes");
		SetGUIObjectText(oDM, "hv_player_notes", "descbox", -1, sPlayerNotes);
		SetGUIObjectText(oDM, "hv_player_notes", "DESC_EDIT_PLAYER_NAME_TEXT", -1, GetName(oPlayer));
	}
	else if (sAction == "2") { // Write notes to DB
		SetPersistentString(oPlayer, "hv_player_notes", sNotes, 0, "playernotes");
		SendMessageToPC(oDM, "Notes Updated.");
	}
	else if (sAction == "3") { // Clear text
		SetGUIObjectText(oDM, "hv_player_notes", "descbox", -1, "");
	}
}