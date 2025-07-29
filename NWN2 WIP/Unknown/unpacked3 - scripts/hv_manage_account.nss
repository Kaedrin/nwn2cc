#include "nwnx_sql"
#include "hv_shared_accounts_inc"

// nAction  - 1 to view gold
//			  2 to empty account
void main(string sAccountName, int nAction)
{
	object oPC = GetPCSpeaker();
	
	// If not a DM - return
	if (!GetIsDM(oPC))
		return;
		
	// Get the object on which all the info is stored
	object oObject = GetObjectByTag(SHARED_ACCOUNT_INFO_OBJECT);
	int nCurrentGold = GetPersistentInt(oObject, sAccountName);
	
	if (nAction == 1) { // View gold in account
		SendMessageToPC(oPC, "Current gold in " + sAccountName + ": " + IntToString(nCurrentGold));
	}
	else if (nAction == 2) { // Empty account
		SendMessageToPC(oPC, "Current gold in " + sAccountName + ": " + IntToString(nCurrentGold));
		SetPersistentInt(oObject, sAccountName, 0);
		SendMessageToPC(oPC, sAccountName + " was emptied.");
	}
}