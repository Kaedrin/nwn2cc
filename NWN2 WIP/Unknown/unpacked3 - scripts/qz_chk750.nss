//Checks if PC has at least 750 gold. Used with the Chinchirorin script set.
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 750)) return FALSE;

return TRUE;
}

