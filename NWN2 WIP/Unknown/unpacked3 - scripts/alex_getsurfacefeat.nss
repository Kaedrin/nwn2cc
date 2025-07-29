int StartingConditional()
{
	object oPC = GetPCSpeaker();
	
	if(GetDeity(oPC) == "Eilistraee")
	{
		return TRUE;
	}
	
	if(	GetXP(oPC) <= 1000 &&
		GetSubRace(oPC) == RACIAL_SUBTYPE_DROW &&
		GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL
		)
	{
		return TRUE;
	}
	
	
	if(	GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD
		&&
	  	GetSubRace(oPC) == RACIAL_SUBTYPE_DROW
	)
	{
		return TRUE; //they are a good drow (no longer allowed)
	}
	else
		return FALSE;
}
	