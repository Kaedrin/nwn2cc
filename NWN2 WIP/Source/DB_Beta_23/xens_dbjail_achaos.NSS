//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Alignment shift for Jailor NPC.
//Shifts alignment towards Chaotic.

//Put this on action taken in the conversation editor.

void main()
{

object oPC = GetPCSpeaker();

AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 1);

}
