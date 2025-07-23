void main()
{
    location lTarget = GetLocation(OBJECT_SELF);
	
	// Get pet type from PC's var
	string sPet = GetLocalString(OBJECT_SELF, "hv_pet_type");
	
    effect eSummon = EffectSummonCreature(sPet, VFX_FNF_SUMMON_MONSTER_1, 0.5f);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, HoursToSeconds(24));
}