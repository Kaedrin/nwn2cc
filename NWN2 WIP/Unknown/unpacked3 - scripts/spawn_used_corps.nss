//
// NESS V8.0
// Spawn Used Corpse
//
// Brought into the NESS distribution for Version 8.0 and beyond.  Original
// header below. 
//

////////////////////////////////////////////////////////////////////////////////
//                                                  //                        //
//  _kb_loot_crouch                                 //      VERSION 1.0       //
//                                                  //                        //
//  by Keron Blackfeld on 07/27/2002                ////////////////////////////
//                                                                            //
//  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
//  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  PLACE THIS SCRIPT IN THE ONUSED EVENT OF YOUR "invis_corpse_obj"          //
//  BLUEPRINT. This script causes the PC opening the corpse to crouch down    //
//  and visibly reach for the corpse.                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));
}
