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
	
	if (sTarget == "Main")
	{
		int Count = GetLocalInt(oPC,"cmi_DomainCount");
		if (Count > 1)
		{
			bRet = FALSE;
		}
		else
			bRet = TRUE;
	}
	else
	{
		int Count = GetLocalInt(oPC,"cmi_DomainCount");
		if (Count == 2)
		{
			bRet = TRUE;
		}
		else
			bRet = FALSE;	
	}
	
		
	
	// return value - either TRUE or FALSE.
	return (bRet);
}