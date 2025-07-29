// Verifies if PC has enough Drow Ears to collect Drow Bounty in Ironhouse Halls.

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

if (GetNumItems(oPC, "gac_drow_ear_bounty") < 2) return FALSE;

return TRUE;
}