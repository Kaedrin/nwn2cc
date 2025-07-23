/* Based off of Hyper-V's drider statue spawn script
Created by Gildren Arconess Cissack

Place script into the creature's "On Spawn In" script slot

Script changes the color of the creature, in addition to healing them to max hitpoints

*/

void main()
{
/*
	// Change Creature Color
	effect eColor = SupernaturalEffect(EffectVisualEffect(VFX_DUR_GLOW_RED));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eColor, OBJECT_SELF);
*/
	
	// Add Special Effect
	effect eVisualEffect = SupernaturalEffect(EffectVisualEffect(VFX_DUR_BLAZING_AURA));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisualEffect, OBJECT_SELF);
	
	// Add Special Effect
	eVisualEffect = SupernaturalEffect(EffectVisualEffect(VFX_DUR_FIRE));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisualEffect, OBJECT_SELF);
	
	// Add Special Effect
	eVisualEffect = SupernaturalEffect(EffectVisualEffect(VFX_DUR_SPELL_MIRROR_IMAGE_SELF));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisualEffect, OBJECT_SELF);			
}