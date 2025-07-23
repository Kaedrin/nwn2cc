// Takes a given item and gives gold in exchange.


#include "nw_i0_plot"

void main(string sItemTag, int nQuantity, int bAllPartyMembers)
{

    int nTotalItem;
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	object oTarg;
    object oItem;       // Items in inventory

    if ( nQuantity == 0 ) nQuantity = 1;

    if ( bAllPartyMembers == 0 )
    {
        if ( nQuantity < 0 )    // Destroy all instances of the item
        {
            nTotalItem = GetNumItems( oPC,sItemTag );
			GiveGoldToCreature(oPC, (nTotalItem*75));
            TakeNumItems( oPC,sItemTag,nTotalItem );
        }
      
    }
   

}