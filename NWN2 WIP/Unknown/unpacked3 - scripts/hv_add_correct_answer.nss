void main()
{	
	object oPC = GetPCSpeaker();
	int nCorrectAnswers = GetLocalInt(oPC, "hv_correct_answers");
	
	// Increase by one and set the new value!
	SetLocalInt(oPC, "hv_correct_answers", nCorrectAnswers + 1);
}