//Script to delete fire damage variable

void main()
{
    object oEntObj = GetExitingObject();
	if (GetIsPC(oEntObj) && !GetIsDM(oEntObj))
	{
		DeleteLocalInt(oEntObj, "alex_lavafire_damage");
	}
}