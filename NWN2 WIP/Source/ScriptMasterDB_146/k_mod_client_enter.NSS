// k_mod_client_enter
/*
	standard module client enter
*/
// ChazM 9/28/05
// ChazM 3/8/06 - Removed Boots
// ChazM 7/18/05 - Boot anyone trying to join before Main Character joins.
// ChazM 8/23/06 Removed PC booting which is problematic w/ module transitions
// TDE 6/20/08 - Adapted script for NX2

const string VAR_MAIN_CHARACTER = "MainCharacter";


int IsCharacterInGame(string sCharacterName)
{
	string sPCName;
   	object oPC = GetFirstPC();
   	while (GetIsObjectValid(oPC) == TRUE)
   	{
		sPCName = GetName(oPC); 
		if (sPCName == sCharacterName)  		
			return TRUE;
      	oPC = GetNextPC();
   	}
	return FALSE;
}

void main()
{
    object oPC = GetEnteringObject();
	string sPCName = GetName(oPC);

	// The first character to enter the game becomes "the main character"
	// No one is allowed to join or be in the game w/o the main character
	string sMainCharacter = GetGlobalString(VAR_MAIN_CHARACTER);
	
	// do we have a main character set?
	if (sMainCharacter == "")
	{
		sMainCharacter = sPCName;
		SetGlobalString(VAR_MAIN_CHARACTER, sPCName);
	}
	
	int bMainCharacter = (sPCName == sMainCharacter);
	
	if (!bMainCharacter)
	{
		if (!IsCharacterInGame(sMainCharacter))
		{
			//BootPC(oPC);
		}
	}
	
	// move player to the party leader.
	//object oLeader = GetFactionLeader(oPC);
	//if (oLeader != oPC)
	//	AssignCommand(oPC, ActionJumpToObject(oLeader));


    // ==============================================================
    // === comment out this section on release ===
 //       if(GetIsObjectValid(GetItemPossessedBy(oPC, "tog_loc"))==FALSE)
 //           CreateItemOnObject("debugBoots", oPC); //function must auto lowercase this...

    // ==============================================================


    // player items
    if (GetIsPC(oPC) && !GetIsDM(oPC))
    {
 
    }

    // DM items
    if (GetIsDM(oPC))
    {
 
    }
}