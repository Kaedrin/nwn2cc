void main()
{
	effect eVisual = EffectVisualEffect(VFX_HIT_CLEANSING_NOVA);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
}