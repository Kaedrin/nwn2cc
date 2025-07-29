// sLocalInt= name of the variable that contains the Text Value
// iValue String value to Set
// iClass 0 for NPC 1 for Player

void main(string sLocalString, string sValue, int iClass)
{
	object oObject = OBJECT_SELF;
	if (iClass == 1) {object oObject = GetPCSpeaker();}
	
	SetLocalString(oObject, sLocalString, sValue);
}