//::///////////////////////////////////////////////
//:: gui_ccs_player_levelup
//:: Purpose: On Player Level Up Script
//:: Created By: 
//:: Created On: January 07 , 2008
//:://////////////////////////////////////////////

void main()
{

	//OBJECT_SELF is the player that leveled up

	//ExecuteScript("community_user_script_here", OBJECT_SELF);
	
	//SendMessageToPC(GetFirstPC(),"gui_ccs_player_levelup: " + GetName(OBJECT_SELF));
	//SpeakString("gui_ccs_player_levelup: " + GetName(OBJECT_SELF) ,TALKVOLUME_SHOUT);
	
	//This loop works on companions
	object oPartyMember = GetFirstFactionMember(OBJECT_SELF, FALSE);
    while(GetIsObjectValid(oPartyMember) == TRUE)
    {
		ExecuteScript("ccs_player_levelup", oPartyMember);
        oPartyMember = GetNextFactionMember(OBJECT_SELF, FALSE);
    }
}