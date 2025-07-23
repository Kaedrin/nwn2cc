//Checks if PC has at least 2250 gold. Used with the Chinchirorin script set.
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 2250)) return FALSE;

return TRUE;
}

