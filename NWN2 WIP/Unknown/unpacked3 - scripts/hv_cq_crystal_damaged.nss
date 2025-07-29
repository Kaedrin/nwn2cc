// Only those with ranged weapon focus can damage
// the crystal. It takes X hits to destroy the crystal,
// where X is the constant CRYSTAL_STRENGTH

#include "hv_cq_inc"

void main()
{
	object oPC = GetLastDamager();
	
	object oWeapon = GetLastWeaponUsed(oPC);
	if ((GetLocalInt(GetArea(oPC), BATTLE_STARTED) == FALSE) ||(!GetWeaponRanged(oWeapon)) || (!GetHasRangedWeaponFocus(oPC))) {
		// Do failure feedback
		InvalidCrystalDamage(oPC, OBJECT_SELF);
	}
	
	// Successful hit
	else {
		HitCrystal(oPC, OBJECT_SELF);
	}			
}