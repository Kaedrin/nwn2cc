//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Gold Check for Jailor NPC.
//Takes desired ammount of gold away from PC.
//Put this on action taken in the conversation editor.


void main()
{

object oPC = GetPCSpeaker();

AssignCommand(oPC, TakeGoldFromCreature(10000, oPC, TRUE));

}