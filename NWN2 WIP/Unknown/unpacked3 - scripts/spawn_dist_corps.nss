//
// NESS V8.0
// Spawn Disturbed Corpse
//
// Brought into the NESS distribution for Version 8.0 and beyond.  Original
// header below.  This file has been modified from its original form.
//

////////////////////////////////////////////////////////////////////////////////
//                                                  //                        //
//  _kb_ondist_loot                                 //      VERSION 1.1       //
//                                                  //                        //
//  by Keron Blackfeld on 07/17/2002                ////////////////////////////
//                                                                            //
//  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
//  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  This is an OnDisturbed Script to go with my _kb_loot_corpse script for    //
//  LOOTABLE MONSTER/NPC CORPSES. If you were using my _kb_ohb_lootable, be   //
//  sure to remove that script from the onHeartbeat of your lootable, the     //
//  "invis_corpse_obj" placeable.                                             //
//                                                                            //
//  PLACE THIS SCRIPT IN THE ONDISTURBED EVENT OF YOUR "invis_corpse_obj"     //
//  BLUEPRINT. This script checks the inventory of OBJECT_SELF, and when it   //
//  is empty, it checks the LocalInt to see if the now empty corpse should    //
//  be Destroyed along with the Lootable Corpse Object. This script will also //
//  checks to see if it should clear its own inventory prior to fading in     //
//  order to prevent a lootbag from appearing. If the inventory is NOT empty, //
//  it checks to see if the ARMOUR is removed from itself, and if so, it      //
//  destroys the Original Armour on the corpse.                               //
//                                                                            //
//  The _kb_loot_corpse script must have this line:                           //
//  int nKeepEmpties = FALSE;                                                 //
//  in order for the Empty Corpse to Destroy itself in this script.           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

//
// ALFA NESS
// Spawn : Loot Corpse Disturbed Script v1.2
//
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//

#include "spawn_functions"

/*******************************************
 ** Here is our main script, which is     **
 ** fired if the Inventory is disturbed.  **
 ** It then checks to see if it needs to  **
 ** either clean up the corpse or Destroy **
 ** the original suit of armor still on   **
 ** the corpse.                           **
 *******************************************/
void main()
{
    //** Get all of our required information

    //Get item that was disturbed to trigger event
    object oInvDisturbed = GetInventoryDisturbItem(); 

	  //Get type of inventory disturbance
    int nInvDistType = GetInventoryDisturbType(); 

	  // Get Values set by spawn_corpse_dth at creation
    object oHostCorpse = GetLocalObject(OBJECT_SELF, "HostBody");
    object oOrigArmor = GetLocalObject(OBJECT_SELF, "OrigArmor");
    object oLootArmor = GetLocalObject(OBJECT_SELF, "LootArmor"); 
    object oOrigRgtWpn = GetLocalObject(OBJECT_SELF, "OrigRgtWpn");
    object oLootRgtWpn = GetLocalObject(OBJECT_SELF, "LootRgtWpn"); 
    object oOrigLftWpn = GetLocalObject(OBJECT_SELF, "OrigLftWpn");
    object oLootLftWpn = GetLocalObject(OBJECT_SELF, "LootLftWpn"); 

    object oPC = GetLastDisturbed();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));

    object oHasInventory = GetFirstItemInInventory(OBJECT_SELF); //Check for inventory
    if (oHasInventory == OBJECT_INVALID) //If no inventory found
    {
        /*******************************************
         **  Delete empty.                        **
         *******************************************/
        NESS_CleanCorpse(oHostCorpse);
        AssignCommand(oHostCorpse,SetIsDestroyable(TRUE,FALSE,FALSE)); //Set actual corpse to destroyable
        DestroyObject(oHostCorpse); //Delete the actual Creature Corpse

        DelayCommand(1.0f,DestroyObject(OBJECT_SELF)); //Delete Lootable Object (Self)

     }

     else
     {
         /*******************************************
          ** If not empty, check to see if armor,  **
          ** left or right weapons have been       **
          ** removed from corpse.                  **
          *******************************************/
          if (nInvDistType == INVENTORY_DISTURB_TYPE_REMOVED)
          {
              if (oInvDisturbed == oLootArmor)
              {
                  /*******************************************
                  ** The Armor is gone - destroy original **
                  ** armor still showing on corpse.       **
                  *******************************************/
                  DestroyObject(oOrigArmor);
              }

              // We don't do these for now, as the unequip animations look too 
              // damn silly
              //else if (oInvDisturbed == oLootRgtWpn)
              //{
              //    DestroyObject(oOrigRgtWpn);
              //}

              //else if (oInvDisturbed == oLootLftWpn)
              //{
              //    DestroyObject(oOrigLftWpn);
              //}
          }
     }

}
