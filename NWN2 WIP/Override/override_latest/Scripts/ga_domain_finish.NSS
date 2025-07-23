// a_DoStuff (string sTarget)
/*
	Description:
	
	Parameters:
		sTarget -  Tag of the target object.  Default is OWNER.

		
	=== Action Script general Info ===
	This is a conversation action script template.  
	Action script names are usually prefixed as follows:
		"ga_" - global action script
		"ka_" - campaign action script
		"<moduleID>a_" - module action script
	Conversation actions and conditions are the only scripts that can have parameters.
	Any number and many types of parameters can be passed.
*/
// Name_Date

#include "ginc_param_const"

void main(string sTarget)
{
	// Get the PC Speaker - if used from command line, then use OBJECT_SELF
	// In a conversation, OBJECT_SELF refers to the NPC.
	// From the command line, OBJECT_SELF refers to the currently possesed character.
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());

	// Do stuff here
	int Count = GetLocalInt(oPC,"cmi_DomainCount");
	SetLocalInt(oPC,"cmi_DomainCount",Count++);

	if (sTarget == "cel")
	{
		FeatAdd(oPC,1337,FALSE);
		FeatAdd(oPC,2894,FALSE);	
	}
	else
	if (sTarget == "dwa")
	{
		FeatAdd(oPC,14,FALSE);
		FeatAdd(oPC,2895,FALSE);	
	}
	else
	if (sTarget == "elf")
	{
		FeatAdd(oPC,27,FALSE);
		FeatAdd(oPC,2896,FALSE);	
	}
	else
	if (sTarget == "fate")
	{
		FeatAdd(oPC,195,FALSE);
		FeatAdd(oPC,2897,FALSE);
	}
	else
	if (sTarget == "hate")
	{
		FeatAdd(oPC,2909,FALSE);
		FeatAdd(oPC,2898,FALSE);	
	}
	else
	if (sTarget == "myst")
	{
		FeatAdd(oPC,2910,FALSE);
		FeatAdd(oPC,2899,FALSE);
	}
	else
	if (sTarget == "pest")
	{
		FeatAdd(oPC,219,FALSE);
		FeatAdd(oPC,2900,FALSE);
	}
	else
	if (sTarget == "repo")
	{
		FeatAdd(oPC,2912,FALSE);
		FeatAdd(oPC,2904,FALSE);	
	}
	else
	if (sTarget == "storm")
	{
		FeatAdd(oPC,430,FALSE);
		FeatAdd(oPC,2901,FALSE);
	}
	else
	if (sTarget == "suff")
	{
		FeatAdd(oPC,2911,FALSE);
		FeatAdd(oPC,2902,FALSE);	
	}
	else
	if (sTarget == "tyra")
	{
		FeatAdd(oPC,168,FALSE);
		FeatAdd(oPC,2903,FALSE);	
	}
											
	

}