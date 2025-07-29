//
// NESS V8.1
// Spawn On Open Corpse
//
// Brought into the NESS distribution for Version 8.0 and beyond.  Original
// header below. 
//

////////////////////////////////////////////////////////////////////////////////
//                                                  //                        //
// _kb_corpse_sound                                 //      VERSION 1.0       //
//                                                  //                        //
//  by Keron Blackfeld on 07/17/2002                ////////////////////////////
//                                                                            //
//  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
//  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  This script is a simple, albeit weak, attempt to mask the default DOOR    //
//  sounds tied to the invisible lootable object. Please this in both the     //
//  onOpened and onClosed Events of the "invis_corpse_obj" described in my    //
//  _kb_lootable_corpse script.                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

void main()
{
    effect eQuiet = EffectSilence();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuiet, OBJECT_SELF, 120.0f);
    PlaySound("as_sw_clothop1"); 
}