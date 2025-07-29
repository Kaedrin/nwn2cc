// Reward the players for correct answers! We encourage lore!
void main()
{	
	object oPC = GetPCSpeaker();
	int nCorrectAnswers = GetLocalInt(oPC, "hv_correct_answers");
	// Give her 100 XP for every correct answer, plus 500 for the
	// quest itself.
	GiveXPToCreature(oPC, 100 * nCorrectAnswers + 500);
}