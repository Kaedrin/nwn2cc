 //Check if player has at least 1 vials of Troll Blood


int GetNumItems(object oTarget,string sItem)
{
int nNumItems = 0;
object oItem = GetFirstItemInInventory(oTarget);
while (GetIsObjectValid(oItem) == TRUE)
{
if (GetTag(oItem) == sItem)
{
nNumItems = nNumItems + GetNumStackedItems(oItem);
}
oItem = GetNextItemInInventory(oTarget);
}
return nNumItems;
}

int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetNumItems(oPC, "gac_troll_blood_bounty") < 1) return FALSE;

return TRUE;
}