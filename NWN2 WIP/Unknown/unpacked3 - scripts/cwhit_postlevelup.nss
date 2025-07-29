/*
Filename:           cwhit_postlevelupcheck
System:            
Author:             Chris Whitaker
Date Created:       Feb 15, 2011
Summary:
*/

void main()
{
	object oPC = GetPCLevellingUp();
	
	int nLevel = GetHitDice(oPC);
	if (nLevel == 20) 
	{
		// once the PC acheives exactly level 20 lets check their actual XP tally
		// vs what should should have had.
		int nActualXP = GetXP(oPC);

		//adjust for LA races
		int iSubRace = GetSubRace(oPC);
		int iLevelAdj = 0;
	  
		// see what the level adjustment is for subrace type
		switch (iSubRace)
		{
		   case RACIAL_SUBTYPE_AASIMAR: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_TIEFLING: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_AIR_GENASI: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_EARTH_GENASI: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_FIRE_GENASI: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_WATER_GENASI: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_GRAY_DWARF: iLevelAdj = 1; break;
		   case RACIAL_SUBTYPE_DROW: iLevelAdj = 2; break;
		   case RACIAL_SUBTYPE_SVIRFNEBLIN: iLevelAdj = 3; break;
		   case RACIAL_SUBTYPE_YUANTI: iLevelAdj = 2; break;
		   case RACIAL_SUBTYPE_GRAYORC: iLevelAdj = 1; break;
		   default:  iLevelAdj = 0; break;
		}
	
		nLevel = nLevel + iLevelAdj;
		
		int nTargetXP = ((nLevel * (nLevel - 1)) / 2) * 1000;
		
		// allow a 3000 xp grace
		if ((nActualXP - nTargetXP) > 3000) {
			SetXP(oPC, nTargetXP);
			SendMessageToPC(oPC, "You have angered the gods by attempting to cheat your way to godhood.");
		} else {
			SendMessageToPC(oPC, "The gods smile upon one who has acheived so much.");	
		}
	}
}