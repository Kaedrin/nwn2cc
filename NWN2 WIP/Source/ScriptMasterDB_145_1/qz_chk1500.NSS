//Checks if PC has at least 1500 gold. Used with the Chinchirorin script set.
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 1500)) return FALSE;

return TRUE;
}

