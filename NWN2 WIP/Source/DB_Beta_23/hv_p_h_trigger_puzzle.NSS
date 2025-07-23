// On Enter of puzzle trigger - 
// if trigger is armed - throw player to 
// start waypoint
void main()
{
	object oTrigger = OBJECT_SELF;
	
	object oPC = GetEnteringObject();	
	
	object oCrystal;
	if (GetStringLength(GetTag(oTrigger)) == 15)
		oCrystal = GetObjectByTag("hv_p_h_crystal" + GetStringRight(GetTag(oTrigger), 1));
	else
		oCrystal = GetObjectByTag("hv_p_h_crystal" + GetStringRight(GetTag(oTrigger), 2));	
		
	// Check if trigger is armed
	if (GetLocalInt(oTrigger, "hv_p_h_armed") == 0) {
		//object oEffect = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "fx_ash_heal", GetLocation(oCrystal), TRUE);
		//DelayCommand(3.0, DestroyObject(oEffect));
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_AOE_SPELL_CASTIGATE), GetLocation(oCrystal));
		return;
	}
	
	// Visual effect
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_HIT_CLEANSING_NOVA), GetLocation(oCrystal));
	
	// Kick player
	AssignCommand(oPC, DelayCommand(0.5, ClearAllActions()));
	AssignCommand(oPC, DelayCommand(0.6, JumpToObject(GetNearestObjectByTag("hv_p_h_wp1"))));
}