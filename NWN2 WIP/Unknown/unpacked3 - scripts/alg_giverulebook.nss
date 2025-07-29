	//if they do not have a a rule book create one
void main()
{

	object oPC = GetEnteringObject();
	int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

	if (DoOnce==TRUE) return;

	SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

	if (GetItemPossessedBy(oPC, "alex_rulesbook")==OBJECT_INVALID)
   	{
   		CreateItemOnObject("alex_rulesbook", oPC);
   	}
}