//Put this script OnOpen
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "Use the other door!");

}