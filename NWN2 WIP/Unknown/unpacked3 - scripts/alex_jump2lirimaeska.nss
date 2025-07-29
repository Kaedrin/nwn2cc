location lTarget;
object oTarget;

//Put this script OnUsed
void main()
{

	object oPC = GetLastUsedBy();

	if (!GetIsPC(oPC)) return;

	if ((GetItemPossessedBy(oPC, "rlg_cath_key")!=OBJECT_INVALID) ||
		(GetItemPossessedBy(oPC, "rlg_cath_port_orb")!=OBJECT_INVALID))
   	{
   		oTarget = GetWaypointByTag("WP_rlg_lirima_eska");

   		lTarget = GetLocation(oTarget);

		//only do the jump if the location is valid.
		//though not flawless, we just check if it is in a valid area.
		//the script will stop if the location isn't valid - meaning that
		//nothing put after the teleport will fire either.
		//the current location won't be stored, either

   		if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
		SendMessageToPC(oPC, "This odd crystal glows silvery blue to your touch.");
		object oMember = GetFirstFactionMember(oPC);
		if(GetItemPossessedBy(oPC, "rlg_cath_key")!=OBJECT_INVALID)
		{
			while(oMember!=OBJECT_INVALID)
			{
				if(GetArea(oMember)==GetArea(oPC))
				{
	   				AssignCommand(oMember, ClearAllActions());
	   				DelayCommand(5.0f, AssignCommand(oMember, ActionJumpToLocation(lTarget)));
					oMember = GetNextFactionMember(oMember);
				}
			}
		}
		else
		{
			AssignCommand(oPC, ClearAllActions());
	   		DelayCommand(5.0f, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
		}
			
   	}
	else
   	{
   		SendMessageToPC(oPC, "This odd crystal doesn't react to your touch.");
   	} 
}