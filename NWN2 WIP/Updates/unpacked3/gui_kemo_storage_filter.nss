void main (string sFilter)
{
	object oPC = OBJECT_SELF;
	
	if (sFilter != GetLocalString(oPC,"StorageFilter"))
	{	SetLocalString(oPC,"StorageFilter",sFilter);
		SetLocalInt(oPC, "kemo_storage_page", 1);
	}
}