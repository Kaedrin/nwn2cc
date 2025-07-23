// Only divine classes can harm the special undead

#include "hv_cq_inc"

void main()
{
	// Heal damage
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9000), OBJECT_SELF);
	
	// Make sure it's a divine class
	object oPC = GetLastDamager();
	if (!GetHasDivineClass(oPC)) {
		// Heal damage
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9000), OBJECT_SELF);
		
		SpeakString("<C=red>*The attack has no effect.*");
		return;
	}
	
	// Damage effect
	effect eHit = EffectVisualEffect(VFX_DUR_SOOTHING_LIGHT);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHit, OBJECT_SELF, 1.0);
	
	eHit = EffectVisualEffect(VFX_HIT_SPELL_HOLY);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, OBJECT_SELF);
	
	eHit = EffectNWN2SpecialEffectFile("fx_kos_explosion");
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, OBJECT_SELF);
	
	
	// Lower damage count
	int nStatus = GetLocalInt(OBJECT_SELF, SPECIAL_UNDEAD_STATUS);
	nStatus--;
	SetLocalInt(OBJECT_SELF, SPECIAL_UNDEAD_STATUS, nStatus);
	if (nStatus <= 0) {
		// Kill special monster
		object oMonster = OBJECT_SELF;
		AssignCommand(oPC, KillSpecialMonster(oPC, oMonster));
	}
	else
		SpeakString("<C=cyan><i>*The creature is weakened.*");
}