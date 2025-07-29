//Checks if PC has at least 3000 gold. Used with the Chinchirorin script set.
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 3000)) return FALSE;

return TRUE;
}

