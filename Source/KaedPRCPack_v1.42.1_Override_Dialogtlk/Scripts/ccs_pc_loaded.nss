//::///////////////////////////////////////////////
//:: ccs_pc_loaded
//:: Purpose: On PC Loaded Script
//:: Created By: Kaedrin
//:: Created On: January 07 , 2008
//:://////////////////////////////////////////////

void main()
{

	//OBJECT_SELF is object oPC = GetEnteringObject();

 	object oPC = GetEnteringObject();
	//SpeakString("ccs_pc_loaded:" ,TALKVOLUME_SHOUT);

	object oPartyMember = GetFirstPC(TRUE);
	while(GetIsObjectValid(oPartyMember) == TRUE)
	{
		ExecuteScript("cmi_pc_loaded", oPartyMember);
		oPartyMember = GetNextPC(TRUE);
	}
		
	/*
	object oPartyMember = GetFirstFactionMember(OBJECT_SELF, FALSE);
	while(GetIsObjectValid(oPartyMember) == TRUE)
	{
		//ExecuteScript("community_user_script_here", OBJECT_SELF);
		//SpeakString("Execute1: cmi_pc_loaded:" ,TALKVOLUME_SHOUT);
		ExecuteScript("cmi_pc_loaded", oPartyMember);
		oPartyMember = GetNextFactionMember(OBJECT_SELF, FALSE);
	}	
	
	
	object oPartyMember2 = GetFirstFactionMember(oPC, FALSE);
	while(GetIsObjectValid(oPartyMember2) == TRUE)
	{
		//SpeakString("Execute2: cmi_pc_loaded:" ,TALKVOLUME_SHOUT);	
		//ExecuteScript("community_user_script_here", OBJECT_SELF);
		ExecuteScript("cmi_pc_loaded", oPartyMember2);
		oPartyMember2 = GetNextFactionMember(oPC, FALSE);
	}
	*/	
}