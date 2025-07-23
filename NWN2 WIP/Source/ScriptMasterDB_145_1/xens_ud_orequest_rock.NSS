//Ud Ore Quest
//Creator: Xeneize
//Put this script OnUsed
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

ActionStartConversation(oPC, "xenc_ud_ore_quest_rock");

}