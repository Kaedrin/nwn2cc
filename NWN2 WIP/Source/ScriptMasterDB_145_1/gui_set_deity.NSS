void main(string sDeity, string sLastName)
{
	object oPC = OBJECT_SELF;
	
	// Add last name to deity if exists
	if (sLastName != "0")
		sDeity = sDeity + " " + sLastName;
		
	SetDeity(oPC, sDeity);
	SendMessageToPC(oPC, "Set deity to " + sDeity);
}
	