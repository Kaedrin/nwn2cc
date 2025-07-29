// sLocalInt= name of the variable that contains the Integer Value
// iValue Integer value to Set
// iClass 0 for NPC 1 for Player

void main(string sLocalInt, int iValue, int iClass)
{
	object oObject = OBJECT_SELF;
	if (iClass == 1) {object oObject = GetPCSpeaker();}
	
	SetLocalInt(oObject, sLocalInt, iValue);
}