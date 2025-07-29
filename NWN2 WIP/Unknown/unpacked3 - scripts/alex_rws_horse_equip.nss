void main()
{
	object oPC = OBJECT_SELF;
	object oItem = GetPCItemLastEquipped();
	int nApp = GetAppearanceType(oPC);
	if(GetTag(oItem)=="alex_rws_horse_77")
	{
		SetLocalInt(oPC, "APP", nApp);
		SetCreatureAppearanceType(oPC, 4009);
	}
}