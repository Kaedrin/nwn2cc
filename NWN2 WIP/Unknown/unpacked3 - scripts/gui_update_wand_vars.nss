void main(string sVarName, string sVarValue)
{
	// get new value
	int nLocalInt = StringToInt(sVarValue);
	
	object oPC = OBJECT_SELF;
	// get bench object
	object oBench = GetNearestObjectByTag("hv_wandbench", oPC);
	if(GetIsObjectValid(oBench))
	{
		if(LineOfSightObject(oPC, oBench))
		{
			if(GetDistanceBetween(oPC, oBench) <= 15.0f)
			{
				// update vars
				int nFormerValue = GetLocalInt(oBench,sVarName);
				SetLocalInt(oBench, sVarName, nLocalInt);
				int nCurrentValue = GetLocalInt(oBench,sVarName);
	
				SendMessageToPC(OBJECT_SELF, "Spell updated.");
			}
		}
	}	
}