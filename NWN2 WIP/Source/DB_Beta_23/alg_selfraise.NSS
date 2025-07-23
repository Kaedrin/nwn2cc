#include "hcr2_pccorpse_i"
#include "hcr2_core_i"
void main()
{
	object oPC = GetPCSpeaker();
	
	// ////////////////////////////////////////////////////////////
	// Attempt by Hyper-V to remove corpse.
	// Get corpse token and corpse from PC
	object oCorpseToken = GetLocalObject(oPC, "hv_corpsetoken");
	object oCorpse = GetLocalObject(oPC, "hv_corpse");
	
	if ((GetIsObjectValid(oCorpseToken)) && (GetIsObjectValid(oCorpse))) {
		// Make corpse destroyable
		AssignCommand(oCorpse, SetIsDestroyable(TRUE, TRUE, TRUE));
	
		// Debugging messages.
		//SendMessageToAllDMs("Attempting to destroy " + GetFirstName(oPC) + "'s corpse.");
	
		// Destroy them both.
		DestroyObject(oCorpseToken);
    	DestroyObject(oCorpse);
	}
	else {
		//SendMessageToAllDMs("Failed to find " + GetFirstName(oPC) + "'s corpse.");
	}
	// ////////////////////////////////////////////////////////////
	
	h2_RemoveCorpse(oPC);
	
	AssignCommand(oPC, JumpToLocation(GetStartingLocation()));

	
	//xp lose for death
	int nXP = GetXP(oPC);
    
	int nPenalty = 100 * GetHitDice(oPC);
    int nHD = GetHitDice(oPC);
	
	//adjust for LA races
	int iSubRace = GetSubRace(oPC);
	int iLevelAdj = 0;
  
    // see what the level adjustment is for subrace type
    switch (iSubRace)
    {
       case RACIAL_SUBTYPE_AASIMAR: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_TIEFLING: iLevelAdj = 1; break;
	  //case RACIAL_SUBTYPE_AIR_GENASI: iLevelAdj = 1; break; Elemental Genasi removed following Kaedrin's
	  //case RACIAL_SUBTYPE_EARTH_GENASI: iLevelAdj = 1; break; 1.44 update, which removes their ECL
	  //case RACIAL_SUBTYPE_FIRE_GENASI: iLevelAdj = 1; break;
	  //case RACIAL_SUBTYPE_WATER_GENASI: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_GRAY_DWARF: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_DROW: iLevelAdj = 2; break;
       case RACIAL_SUBTYPE_SVIRFNEBLIN: iLevelAdj = 3; break;
	   case RACIAL_SUBTYPE_YUANTI: iLevelAdj = 2; break;
	   case RACIAL_SUBTYPE_GRAYORC: iLevelAdj = 1; break;
       default:  iLevelAdj = 0; break;
    }
	
	if(nHD >= iLevelAdj)
		nHD = nHD + iLevelAdj;
	
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oPC, nNewXP);
	
	
    DeleteLocalInt(oPC, H2_LOGIN_DEATH);
	if (GetPCPlayerName(oPC) != "")
	{   //If the player name is valid it means 
	    //they did not exit by logging out
		h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
	}

	DelayCommand(5.0, AssignCommand(oPC, JumpToLocation(GetStartingLocation())));


	}