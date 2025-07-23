// sLocalInt= name of the variable that contains the Integer Value
// iValue Integer value to compare

int StartingConditional(string sGlobalInt, int iValue)
{
	int TempInt = GetGlobalInt(sGlobalInt);
	if (iValue == TempInt) {return TRUE;} else {return FALSE;}
}