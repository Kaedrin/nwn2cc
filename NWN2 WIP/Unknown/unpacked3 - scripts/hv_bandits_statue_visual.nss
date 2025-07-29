// Make statue fire beam at its sister-statue
void main()
{
	object oOtherStatue = GetNearestObjectByTag(GetTag(OBJECT_SELF), OBJECT_SELF);
	effect eEnergy;
	if (GetIsObjectValid(oOtherStatue)) {
		eEnergy = EffectVisualEffect(VFX_BEAM_LIGHTNING);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oOtherStatue, 2.0f);
	}
}