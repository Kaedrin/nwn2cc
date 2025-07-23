// Wand for Xeneize's playtesting grounds.
 // Credits @ Xeneize+Hyper


void main()
{

    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();


if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "You can only use this item on a PC");
return;}

if (GetItemPossessedBy(oTarget, "xen_devtesterpass")!= OBJECT_INVALID)
   {
   

   oItem = GetItemPossessedBy(oTarget, "xen_devtesterpass");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   }
else
   {
   CreateItemOnObject("xen_devtesterpass", oTarget);

   }

}