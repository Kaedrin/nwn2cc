//Put this script OnUsed
//generic start convo..this script can be used over and over it starts
//the convo file the npc ot placeable has attached to it

void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

ActionStartConversation(oPC, "");

}
