//::///////////////////////////////////////////////
//:: ccs_player_rest
//:: Purpose: On Player Rest Script 
//:: Created By: Kaedrin
//:: Created On: January 07 , 2008
//:://////////////////////////////////////////////

void main()
{

	//OBJECT_SELF is the player
	
	//This loop works on companions
	/*
	object oPartyMember = GetFirstFactionMember(OBJECT_SELF, FALSE);
	while(GetIsObjectValid(oPartyMember) == TRUE)
	{
		//ExecuteScript("community_user_script_here", OBJECT_SELF);
		ExecuteScript("cmi_player_rest", oPartyMember);
		oPartyMember = GetNextFactionMember(OBJECT_SELF, FALSE);
	}
	*/	
	
	ExecuteScript("cmi_player_rest", OBJECT_SELF);
	
}