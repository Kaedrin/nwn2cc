//AMY's resting is dangerous script this is to be used on rest scripts in dungeons

//hcr include
#include "hcr2_playerrest_i"
#include "alg_partysizeinarea_inc"

void main()
{
    object oEntObj = GetEnteringObject();
	object oRestEncounter = GetObjectByTag("RestEncounter");
	int nSize = GetPartySize(oEntObj);
	if (GetIsPC(oEntObj))
	{
		//check for surival skills
 		if ((GetIsSkillSuccessful(oEntObj, SKILL_SURVIVAL, 25, FALSE)) || (nSize > 1)) 
		{
 			SendMessageToPC(oEntObj, "The fact you were not alone or keenly aware of any nearby beasts was to your advantage.");
 			SetLocalObject(oEntObj, H2_REST_TRIGGER, OBJECT_SELF);
 		}
 		else
		{
			TriggerEncounter(oRestEncounter,oEntObj, 0, -1.0);
		}
	}
}