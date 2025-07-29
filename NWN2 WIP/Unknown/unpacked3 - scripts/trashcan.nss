//Gathered from various sources. Otomo Tetsuo 09202008

/*Creating A Trashcan 
To make a trash can place an item, such as a barrel,
in your area then open the properties.
Make sure "useable" and "has inventory" are checked,
then go to scripts, and place the following script in "OnClose" */

void main()
{
object oItem = GetFirstItemInInventory();
if(GetIsObjectValid(oItem))
    {
    while(GetIsObjectValid(oItem))
        {
        SetPlotFlag(oItem, FALSE);
		AssignCommand (oItem, SetIsDestroyable(TRUE, FALSE, FALSE));
        DestroyObject(oItem);
        oItem = GetNextItemInInventory();
        }
    }
}