// sLocalInt= name of the variable that contains the Integer Value
// iValue Integer value to compare
// iClass 0 for NPC 1 for Player

int StartingConditional(string sLocalInt, int iValue, int iClass)
{
	object oObject = OBJECT_SELF;
	if (iClass == 1) {object oObject = GetPCSpeaker();}
	
	int TempInt = GetLocalInt(oObject,sLocalInt);
	if (iValue == TempInt) {return TRUE;} else {return FALSE;}
}