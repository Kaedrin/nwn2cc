// ga_area_transition
/*
	Performs an area transition the same as per the standard area transition rules.
	
		string sDestination - tag of the location to be transferred to.
		int bIsPartyTranstion - determines whether single party transition is used.
*/	
// ChazM 7/13/07

#include "ginc_param_const"
#include "ginc_transition"

void main(string sDestination, int bIsPartyTranstion)
{
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
 	object oDestination	= GetTarget(sDestination);
	if((Random(20)+GetSkillRank(SKILL_SPELLCRAFT,oPC))>33)
	{
		object oFM = GetFirstFactionMember(oPC, FALSE);
		while(oFM != OBJECT_INVALID)
		{
			if(GetDistanceBetween(oFM, oPC) <= 20.0)
				StandardAttemptAreaTransition(oPC, oDestination, bIsPartyTranstion);
		}
	}
	else
	{
		StandardAttemptAreaTransition(oPC, oDestination, bIsPartyTranstion);
	}	
}