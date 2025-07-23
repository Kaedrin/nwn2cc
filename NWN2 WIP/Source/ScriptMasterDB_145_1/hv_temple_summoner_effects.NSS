void main()
{
	object oBoss = GetObjectByTag("hv_temple_boss");
	effect eEnergy;
	if (GetIsObjectValid(oBoss)) {
		eEnergy = EffectVisualEffect(VFX_BEAM_ENCHANTMENT);
		DelayCommand(5.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oBoss, 9999.0f));
	}
}