void main()
{
	object oPC = OBJECT_SELF;
	object oItem = GetPCItemLastUnequipped();
	if(GetTag(oItem)=="alex_rws_horse_77")
	{
		int nApp = GetLocalInt(oPC, "APP");
		SetCreatureAppearanceType(oPC, nApp);
	}
}