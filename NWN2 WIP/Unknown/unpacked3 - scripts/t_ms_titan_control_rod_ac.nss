/*
Author: 		DM_Nocturne
Created: 		September 30, 2013
Last Modified:	September 30, 2013
Description:

Summons the custom golem pet TITAN to act as a faithful companion.
*/

void main()
{
	if (!GetIsPC(OBJECT_SELF)) 
	{
  		object oPC = GetItemActivator();
  		if (GetIsPC(oPC))
		{
   			ExecuteScript("t_ms_titan_control_rod_ac", oPC); //Makes it so that it is the PC that summons TITAN
  		}
 	}
	else 
	{
  		effect summonTitan = EffectSummonCreature("ms_titan_golem", VFX_FNF_SCREEN_SHAKE, 0.0f, 0);
   		ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, summonTitan, GetLocation(OBJECT_SELF), HoursToSeconds(24));
 	}
}
	/* Does not work, as it is the ITEM attempting to summong the golem, not the player
	object oPC = GetItemActivator();
	location lTarget = GetItemActivatedTargetLocation();
	SendMessageToPC(oPC, "Attempting to summon TITAN with 't' script.");
	effect summonTitan = EffectSummonCreature("ms_titan_golem", VFX_FNF_SCREEN_SHAKE, 0.0f, 0);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),lTarget);
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, summonTitan, lTarget, HoursToSeconds(24));
	*/