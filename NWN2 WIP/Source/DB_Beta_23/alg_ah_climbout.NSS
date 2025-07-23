//By Buce meant to climb out of the trash pit with a delay between tries ty mustang sorry about the undressing part :)



location lTarget;
object oTarget;

void main()
{

	object oPC = GetLastUsedBy();
	if (!GetIsPC(oPC)) return;
	if (GetLocalInt(oPC, "HasDone")!=1)
	{
		SetLocalInt(oPC, "HasDone",0);
	}
	else
	{
		SpeakString("You will need to rest before attempting this climb, **Continous reclicking will only make the wait longer**",0);
		return;
	}
	//I am all over line 12~!! at least this script doesn't involve undressing alex
	
	
	
	if(GetIsSkillSuccessful(oPC,SKILL_TUMBLE,15)==TRUE && GetLocalInt(oPC, "HasDone")==0)
	{
		oTarget = GetWaypointByTag("WP_ah_outofpit");
		lTarget = GetLocation(oTarget);
		
		//only do the jump if the location is valid.
		//though not flawless, we just check if it is in a valid area.
		//the script will stop if the location isn't valid - meaning that
		//nothing put after the teleport will fire either.
		//the current location won't be stored, either
		if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
		AssignCommand(oPC, ClearAllActions());
		AssignCommand(oPC, ActionJumpToLocation(lTarget));
	}
	//no undressing here either!!```Sorry Alex fans to dissapoint you!
	//btw this script makes me nervous 
	else
	{
		SetLocalInt(oPC, "HasDone", 1);
		SpeakString("Your exhausted from your last attempt",0);
		DelayCommand(40.0f,AssignCommand(GetModule(),SetLocalInt(oPC, "HasDone", 0)));
			
	}
		

}