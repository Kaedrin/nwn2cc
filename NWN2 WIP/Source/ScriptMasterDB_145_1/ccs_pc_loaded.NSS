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
	ExecuteScript("cmi_pc_loaded", oPC);
	//SpeakString("ccs_pc_loaded:" ,TALKVOLUME_SHOUT);

	/*
	//Need to wrap this in a CMI option for SP only
	object oPartyMember = GetFirstPC(TRUE);
	while(GetIsObjectValid(oPartyMember) == TRUE)
	{
		ExecuteScript("cmi_pc_loaded", oPartyMember);
		oPartyMember = GetNextPC(TRUE);
	}
	*/
		
}