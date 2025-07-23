void main()
{
	object oPC = GetPCSpeaker();
	object oChair = GetLocalObject(oPC,"SittingChair");
	float fFacing = GetFacing(oChair);
	
	fFacing = fFacing + 20.0f;
	
	AssignCommand(oChair,SetFacing(fFacing));
}