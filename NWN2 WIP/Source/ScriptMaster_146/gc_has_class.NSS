// c_DoStuff (string sTarget)
/*
	Description:
	
	Parameters:
		sTarget -  Tag of the target object.  Default is OWNER.

		
	=== Condition Script general Info ===
	This is a conversation condition script template.  
	Condition script names are usually prefixed as follows:
		"gc_" - global condition script
		"kc_" - campaign condition script
		"<moduleID>c_" - module condition script
	Note that "c" stands for "condition" or "check" so no need to add these
	words to the script name.  For examples "kc_genasi_or_druid" would be preferable
	to "kc_check_genasi_or_druid"
		
	Conversation actions and conditions are the only scripts that can have parameters.
	Any number and many types of parameters can be passed.
*/
// Name_Date


int StartingConditional(string sTarget)
{
	// OBJECT_SELF refers to the NPC.
    object oPC = GetPCSpeaker();
	int bRet = FALSE;	// the return value

	// Add code to check conditions
	
	if (sTarget == "Cleric")
	{
		if (GetLevelByClass(CLASS_TYPE_CLERIC) > 0)
			bRet = TRUE;
		else
			bRet = FALSE;
	}
	else
	if (sTarget == "Druid")
	{
		if (GetLevelByClass(CLASS_TYPE_DRUID) > 0)
			bRet = TRUE;
		else
			bRet = FALSE;
	}
	else
	if (sTarget == "FavSoul")
	{
		if (GetLevelByClass(CLASS_TYPE_FAVORED_SOUL) > 0)
			bRet = TRUE;
		else
			bRet = FALSE;
	}	
	else
	if (sTarget == "Paladin")
	{
		if (GetLevelByClass(CLASS_TYPE_PALADIN) > 0)
			bRet = TRUE;
		else
			bRet = FALSE;
	}	
	else
	if (sTarget == "Ranger")
	{
		if (GetLevelByClass(CLASS_TYPE_RANGER) > 0)
			bRet = TRUE;
		else
			bRet = FALSE;
	}
	if (sTarget == "SpirSham")
	{
		if (GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN) > 0)
			bRet = TRUE;
		else
			bRet = FALSE;
	}						
	
	// return value - either TRUE or FALSE.
	return (bRet);
}