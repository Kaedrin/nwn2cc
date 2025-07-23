void main(object objectID, float locationX, float locationY, float locationZ)
{       //alter as needed
	object oPC = GetFirstPC();
	//object o = IntToObject(objectID);
	object o = objectID;
	SendMessageToPC(oPC, "fired targetscript: " + GetName(o) + " " + FloatToString(locationX) + "," + FloatToString(locationY)+ "," + FloatToString(locationZ));
}