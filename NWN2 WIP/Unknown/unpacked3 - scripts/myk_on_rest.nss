// myk_on_rest
/*
	This script should be used as a "On Player Rest Script".
	It saves the current location of the PC and
	the character to the vault.
*/
// Shockwolf - 19/12/2009.
// Thanks to Leomist's Auto Server Restart scripts for NWN1.
// And Markshire for the Quill Of PC Recording code.

void main()
{
	object oPC = GetLastPCRested();
	//Looking up the location of the PC so that it can be saved
	location lPCLocation = GetLocation(oPC);
	//Save character to Vault
	ExportSingleCharacter(oPC);
   	SendMessageToPC(oPC, "The module, " + GetModuleName() + ", is saving the PC, " + GetName(oPC));
    PrintString(GetPCPlayerName(oPC) + " has saved their PC, " + GetName(oPC) + ".");
	//Saving the characters location
	SetCampaignLocation("SavedLocation","Location",lPCLocation,oPC);
	DelayCommand(5.0, SendMessageToPC(oPC,"The Location you last rested has been saved"));
	
}