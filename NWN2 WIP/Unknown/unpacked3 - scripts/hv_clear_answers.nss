// Clear answers variable if player for some reason left the conversation
// in the middle, so she won't be able to cheat for extra XP!
void main()
{
	object oPC = GetPCSpeaker();
	SetLocalInt(oPC, "hv_correct_answers", 0);
}