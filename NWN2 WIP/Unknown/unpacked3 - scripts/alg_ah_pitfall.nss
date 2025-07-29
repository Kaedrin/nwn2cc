location lTarget;
int nInt;
object oTarget;
effect eEffect;

//this script should jump a pc if they fai the reflex save to a garbage pit with a visual applied to the trigger for his allies
void main()
{

	object oPC = GetEnteringObject();

	if (!GetIsPC(oPC) || GetIsDM(oPC)) return;

	if (ReflexSave(oPC, 20))
   	{
   		//basically do nothing
   		SendMessageToPC(oPC, "The boards creak under your weight but nothing happens.");
   	}
	else //basically do this
   	{
   		//apply damage..falling hurts
   		eEffect = EffectDamage(10, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
   		ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
   		oTarget = oPC;
   		//this is more for allies should target the tigger
		nInt = GetObjectType(oTarget);
		if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), oTarget);
    	else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oTarget));
    	oTarget = OBJECT_SELF;
		//jump player
   		FloatingTextStringOnCreature("The boards give way and you can't make it clear in time!", oPC);
   		oTarget = GetWaypointByTag("ah_garbagepit");
   		lTarget = GetLocation(oTarget);
   		if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   		AssignCommand(oPC, ClearAllActions());
   		AssignCommand(oPC, ActionJumpToLocation(lTarget));

   	}

}