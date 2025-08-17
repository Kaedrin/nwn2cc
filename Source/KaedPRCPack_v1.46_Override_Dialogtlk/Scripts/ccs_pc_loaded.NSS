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
		
}