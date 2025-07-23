//Author: Xeneize
//Will make corpse talk to PC

//Put this script OnUsed
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

ActionStartConversation(oPC, "xenc_ud_yathmissemisary");

}


