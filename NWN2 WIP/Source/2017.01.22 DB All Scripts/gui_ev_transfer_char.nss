/*
	Backend for items transfer gui and npc
	
	ev_transfer_item1 to ev_transfer_itemMAX_ITEMS are objects vars
	stored on the player, denoting items to store before deletion
	
	ev_transfer_item_num is int var stored on the player,
	denoting total stored items
	
	active_transfer variale is kept in player's database.
	if 1 then player can get her stored stuff for a new char.
	if 0 then she has nothing stored.
*/

#include "hcr2_core_i"
#include "nwnx_sql"
#include "nwnx_character"

const int MAX_ITEMS = 10;
const float XP_MODIFIER = 0.35;
const float GOLD_MODIFIER = 0.30;

/*
	Go over ev_transfer_item[1-MAX_ITEMS] and add the name to the list	
*/
void DisplayStoredItems(object oPC)
{
	ClearListBox(oPC, "ev_transfer_items", "ITEMS_LISTBOX");
	
	object item;
	int i;
	
	for (i = 1; i <= GetLocalInt(oPC, "ev_transfer_item_num"); i++) {
		item = GetLocalObject(oPC, "ev_transfer_item" + IntToString(i));
		if (item == OBJECT_INVALID) {
			return;
		}
		else {
			AddListBoxRow(oPC, "ev_transfer_items", "ITEMS_LISTBOX", "", "ITEM_NAME="+GetName(item), "", "", "");
		}
	}
}

/*
	Clear list of items and delete items vars on pc
*/
void ClearStoredItems(object oPC)
{
	object item;
	int i;
	
	for (i = 1; i <= MAX_ITEMS; i++) {
		SetLocalObject(oPC, "ev_transfer_item" + IntToString(i), OBJECT_INVALID);
	}
	
	ClearListBox(oPC, "ev_transfer_items", "ITEMS_LISTBOX");
	SetLocalInt(oPC, "ev_transfer_item_num", 0);
}

/* 
	Add item to list and store on player as variable
*/
void StoreItem(object oPC, string sItemObjectString)
{
	object item = StringToObject(sItemObjectString);
	int n = GetLocalInt(oPC, "ev_transfer_item_num");
	int i;
	
	// Can't store more items
	if (n >= MAX_ITEMS) {
		SendMessageToPC(oPC, "No room for more items.");
		return;
	}
	
	if (item != OBJECT_INVALID) {
	
		// Make sure we don't have this item already
		for (i = 1; i <= n; i++) {
			if (ObjectToString(GetLocalObject(oPC, "ev_transfer_item" + IntToString(i))) == ObjectToString(item)) {
				SendMessageToPC(oPC, "Item already in list.");
				return;
			}
		}
	
		SetLocalObject(oPC, "ev_transfer_item" + IntToString(n + 1), item);
		SetLocalInt(oPC, "ev_transfer_item_num", n + 1);
		AddListBoxRow(oPC, "ev_transfer_items", "ITEMS_LISTBOX", "", "ITEM_NAME="+GetName(item), "", "", "");	
	}
}

/*
	Returns 0 on success
	Returns 1 on failure
*/
int StorePCData(object oPC)
{
	string sDBFileName = "ev_transfer_" + GetPCPublicCDKey(oPC);
	int i;
	int success;
	object item;
	object inv_item; // inventory item
	int found_item = 0;
	
	WriteTimestampedLogEntry("[CHAR TRANSFER]Storing data for " + GetPCPlayerName(oPC)
							+"," + GetName(oPC) + "," + GetPCPublicCDKey(oPC) + ","
							+ GetPCIPAddress(oPC));
	
	// Store XP
	int XP = FloatToInt(GetXP(oPC) * XP_MODIFIER);
	SetCampaignInt(sDBFileName, "xp", XP);
	WriteTimestampedLogEntry("[CHAR TRANSFER]Stored "+IntToString(XP)+" xp.");
	
	
	// Store Gold
	int gold = FloatToInt(GetGold(oPC) * GOLD_MODIFIER);
	SetCampaignInt(sDBFileName, "gold", gold);
	WriteTimestampedLogEntry("[CHAR TRANSFER]Stored "+IntToString(gold)+" gold.");
	
	// Store tokens
	int tokens = GetPersistentInt(oPC, "RP_Tokens", "rptokens");
	tokens = tokens - 5;
	if (tokens < 0) tokens = 0;
	SetCampaignInt(sDBFileName, "tokens", tokens);
	WriteTimestampedLogEntry("[CHAR TRANSFER]Stored "+IntToString(tokens)+" tokens.");
	
	// Store items
	for (i = 1; i <= GetLocalInt(oPC, "ev_transfer_item_num"); i++) {
		item = GetLocalObject(oPC, "ev_transfer_item" + IntToString(i));
		
		// Abort!
		if (item == OBJECT_INVALID) {
			WriteTimestampedLogEntry("[CHAR TRANSFER]Item ev_transfer_item" + IntToString(i)+" invalid, aborting.");
			SendMessageToPC(oPC, "An item could not be found.");
			return 1;
		}
		
		// Make sure the item is in the player's inventory
		found_item = 0;
		inv_item = GetFirstItemInInventory(oPC);
		while (inv_item != OBJECT_INVALID) {
		
			// Found item in inventory!
			if (ObjectToString(inv_item) == ObjectToString(item)) {
				found_item = 1;
				break;
			}
			
			inv_item = GetNextItemInInventory(oPC);
		}
		
		// Abort!
		if (found_item == 0) {
			WriteTimestampedLogEntry("[CHAR TRANSFER]Item " + GetName(item) + " was not found in player's inventory. Aborting.");
			SendMessageToPC(oPC, "<C=red>Aborting: Make sure all items to store are in your inventory, and not equipped!");
			return 1;
		}
	
		// Store
		success = StoreCampaignObject(sDBFileName, "ev_transfer_item" + IntToString(i), item);
		
		// Abort!
		if (success == 0) {
			WriteTimestampedLogEntry("[CHAR TRANSFER]Failed to store item "+GetName(item)+", aborting.");
			SendMessageToPC(oPC, "Failed to store item in database.");
			return 1;
		}	
		
		WriteTimestampedLogEntry("[CHAR TRANSFER]Stored item "+GetName(item)+" of value " + IntToString(GetGoldPieceValue(item)));
		
		
		// FIX: Only delete after everything went smoothly
		// Delete item
		//DestroyObject(item);
	}
	
	// Delete items
	for (i = 1; i <= GetLocalInt(oPC, "ev_transfer_item_num"); i++) {
		item = GetLocalObject(oPC, "ev_transfer_item" + IntToString(i));
		DestroyObject(item);
	}
	
	// Some more details
	SetCampaignInt(sDBFileName, "ev_transfer_item_num", GetLocalInt(oPC, "ev_transfer_item_num"));
	SetCampaignString(sDBFileName, "char_name", GetName(oPC));
	SetCampaignString(sDBFileName, "player_name", GetPCPlayerName(oPC));
	SetCampaignInt(sDBFileName, "active_transfer", 1);
	
	return 0;
}

void RestorePCData(object oPC)
{
	string sDBFileName = "ev_transfer_" + GetPCPublicCDKey(oPC);
	int i;
	object item;
	object copiedItem;
	
	// Make sure there is an active transfer pending
	if (GetCampaignInt(sDBFileName, "active_transfer") == 0) {
		SendMessageToPC(oPC, "Nothing is stored for you. Aborting. . .");
		return;
	}
	
	// Make sure character's xp is no more than the default for new chars
	if (GetXP(oPC) > 1000) {
		SendMessageToPC(oPC, "This character doesn't seem to be new. Aborting. . .");
		return;
	}
	
	WriteTimestampedLogEntry("[CHAR TRANSFER]Restoring data for " + GetPCPlayerName(oPC)
							+"," + GetName(oPC) + "," + GetPCPublicCDKey(oPC) + ","
							+ GetPCIPAddress(oPC));
							
	SetCampaignInt(sDBFileName, "active_transfer", 0);
	
	// XP
	int XPToAdd = GetCampaignInt(sDBFileName, "xp");
	SetXP(oPC, GetXP(oPC) + XPToAdd);
	WriteTimestampedLogEntry("[CHAR TRANSFER]Added "+IntToString(XPToAdd)+" xp.");
	
	// Gold
	int goldToAdd = GetCampaignInt(sDBFileName, "gold");
	GiveGoldToCreature(oPC, goldToAdd);
	WriteTimestampedLogEntry("[CHAR TRANSFER]Added "+IntToString(goldToAdd)+" gold.");
	
	// Tokens
	int tokensToAdd = GetCampaignInt(sDBFileName, "tokens");
	if (tokensToAdd > 0) {
		int current_tokens = GetPersistentInt(oPC, "RP_Tokens", "rptokens");
		SetPersistentInt(oPC, "RP_Tokens", current_tokens + tokensToAdd, 0, "rptokens");
		SendMessageToPC(oPC, "Transfered "+IntToString(tokensToAdd)+" lesser tokens.");
		WriteTimestampedLogEntry("[CHAR TRANSFER]Added "+IntToString(tokensToAdd)+" tokens.");	
	}
		
	
	// Items
	int n = GetCampaignInt(sDBFileName, "ev_transfer_item_num");
	for (i = 1; i <= n; i++) {
		item = RetrieveCampaignObject(sDBFileName, "ev_transfer_item" + IntToString(i), GetLocation(oPC), oPC);
		WriteTimestampedLogEntry("[CHAR TRANSFER]Restored item "+GetName(item)+" of value " + IntToString(GetGoldPieceValue(item)));
		copiedItem = CopyItem(item, oPC);
		if (copiedItem != OBJECT_INVALID) {
			DestroyObject(item);
		}
		
		// Failed to copy item to player's inventory, it's probably on the ground still.
		else {
			WriteTimestampedLogEntry("[CHAR TRANSFER]The restored item "+GetName(item)+" of value "
									 + IntToString(GetGoldPieceValue(item)) +" failed to be copied into player's inventory.");
		}
	}
}

/*
	Delete and retire character
*/
void RetirePC(object oPC)
{
	h2_MovePossessorInventory(oPC, TRUE);
    h2_MoveEquippedItems(oPC);
    h2_SetPlayerState(oPC, H2_PLAYER_STATE_RETIRED);
    int nRegisteredCharCount = h2_GetRegisteredCharCount(oPC);
    h2_SetRegisteredCharCount(oPC, nRegisteredCharCount - 1);
    SendMessageToPC(oPC, H2_TEXT_TOTAL_REGISTERED_CHARS + IntToString(nRegisteredCharCount - 1));
    SendMessageToPC(oPC, H2_TEXT_MAX_REGISTERED_CHARS + IntToString(H2_REGISTERED_CHARACTERS_ALLOWED));
	
	AssignCommand(GetModule(), DelayCommand( 1.0f, DeleteCharacter( oPC ) ));
}

void main(string command = "", string arg1 = "")
{
	object oPC = OBJECT_SELF;
	
	if (command == "items_init") {
		DisplayStoredItems(oPC);
	}
	
	else if (command == "clear_all") {
		ClearStoredItems(oPC);
	}
	
	else if (command == "store_item") {
		StoreItem(oPC, arg1);
	}
	
	else if (command == "show_gui") {
		oPC = GetPCSpeaker();
		DisplayGuiScreen(oPC, "ev_transfer_items", FALSE, "ev_transfer_items.XML");
	}
	
	else if (command == "store_and_delete") {
		oPC = GetPCSpeaker();
		
		// Store data
		if (StorePCData(oPC) == 0) {
			// Delete PC
			RetirePC(oPC);
		}
		
		// Failed to store data
		else {
			SendMessageToPC(oPC, "Operation failed, please contact the server administrator.");
		}
	}
	
	else if (command == "restore_stuff") {
		oPC = GetPCSpeaker();
		
		// Restore stuff to this pc
		RestorePCData(oPC);
	}
}