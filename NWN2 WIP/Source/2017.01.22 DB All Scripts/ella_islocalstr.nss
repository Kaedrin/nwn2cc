// sLocalInt= name of the variable that contains the Text Value
// iValue Text value to compare
// iClass 0 for NPC 1 for Player

int StartingConditional(string sLocalString, string iValue, int iClass)
{
	object oObject = OBJECT_SELF;
	if (iClass == 1) {object oObject = GetPCSpeaker();}
	
	string TempStr = GetLocalString(oObject,sLocalString);
	if (iValue == TempStr) {return TRUE;} else {return FALSE;}
}