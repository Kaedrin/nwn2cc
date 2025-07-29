//Checks if PC has at least 300 gold. Used with the Chinchirorin script set.
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 300)) return FALSE;

return TRUE;
}

