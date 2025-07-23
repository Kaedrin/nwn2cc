void main()
{
	object oPC = GetEnteringObject();
	
	if (GetIsPC(oPC)) {
	
		// Calculate damage to deal - 10% of max HP
		int nMaxHP = GetMaxHitPoints(oPC);
		int nDamage = FloatToInt(nMaxHP * 0.1);
		
		// Get the dragon that will blow the visual effect
		object oDragon = GetNearestObjectByTag("hv_dragon_trap");
		
		// Create the visual effects
		effect eVisual = EffectVisualEffect(GetLocalInt(oDragon, "hv_vfx"));
		effect eVisualPC = EffectVisualEffect(VFX_DUR_BLUR);
		
		// Create the damage effect
		effect eDamage = EffectDamage(nDamage, GetLocalInt(oDragon, "hv_damage_type"));
		
		// Apply visual on dragon + PC and damage on PC
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oDragon, 2.0f);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC, 2.0f);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualPC, oPC, 2.0f);
	}
}