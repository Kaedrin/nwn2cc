#include "hv_find_players_inc"
#include "nwnx_sql"

void main()
{
	int nScryToolVar = GetLocalInt(OBJECT_SELF, FIND_PLAYERS_VAR);
	
	// 0 - wasn't set yet
	if (nScryToolVar == 0) {
		
		// if default is anonymity, set to "find me"
		// on first press
		if (HIDE_ALL_BY_DEFAULT) {
			SetLocalInt(OBJECT_SELF, FIND_PLAYERS_VAR, 2);
			SetPersistentInt(OBJECT_SELF, FIND_PLAYERS_VAR, 2, 0, "dbtools");
			SendMessageToPC(OBJECT_SELF, "Anonymity toggled off.");
		}
		else {
			SetLocalInt(OBJECT_SELF, FIND_PLAYERS_VAR, 1);
			SetPersistentInt(OBJECT_SELF, FIND_PLAYERS_VAR, 1, 0, "dbtools");
			SendMessageToPC(OBJECT_SELF, "Anonymity toggled on.");
		}
	}
	else if (nScryToolVar == 1) { // "don't find me!"
		SetLocalInt(OBJECT_SELF, FIND_PLAYERS_VAR, 2);
		SetPersistentInt(OBJECT_SELF, FIND_PLAYERS_VAR, 2, 0, "dbtools");
		SendMessageToPC(OBJECT_SELF, "Anonymity toggled off.");
	}
	else if (nScryToolVar == 2) { // "find me!"
		SetLocalInt(OBJECT_SELF, FIND_PLAYERS_VAR, 1);
		SetPersistentInt(OBJECT_SELF, FIND_PLAYERS_VAR, 1, 0, "dbtools");
		SendMessageToPC(OBJECT_SELF, "Anonymity toggled on.");
	}
}