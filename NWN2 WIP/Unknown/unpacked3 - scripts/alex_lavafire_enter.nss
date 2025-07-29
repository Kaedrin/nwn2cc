//Script to set fire damage variable

void main()
{
    object oEntObj = GetEnteringObject();
	if (GetIsPC(oEntObj) && !GetIsDM(oEntObj))
	{
		SetLocalInt(oEntObj, "alex_lavafire_damage", 1);
	}
}












