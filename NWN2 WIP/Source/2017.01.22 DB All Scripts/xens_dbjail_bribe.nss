//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Gold Check for Jailor NPC.
//Checks to see if PC has enough gold to Bribe his way out of Jail.

//Put this on action taken in the conversation editor
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetGold(oPC) < 10000) return FALSE;

return TRUE;
}