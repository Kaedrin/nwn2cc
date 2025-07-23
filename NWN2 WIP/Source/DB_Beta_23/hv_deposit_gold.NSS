#include "nwnx_sql"
#include "hv_shared_accounts_inc"

void main(string sAccountName, int nAmountDeposited)
{
	// Get the object on which all the info is stored
	object oObject = GetObjectByTag(SHARED_ACCOUNT_INFO_OBJECT);

	// Get current amount of account
	int nCurrentGold = GetPersistentInt(oObject, sAccountName); 
	
	// Increase nCurrentGold by the amount
	// that the player deposit
	int nUpdatedGold = nCurrentGold + nAmountDeposited;
	
	// Set the new value on the object
	SetPersistentInt(oObject, sAccountName, nUpdatedGold);
	
	// Take gold from player
	TakeGoldFromCreature(nAmountDeposited, GetPCSpeaker(), TRUE);
}