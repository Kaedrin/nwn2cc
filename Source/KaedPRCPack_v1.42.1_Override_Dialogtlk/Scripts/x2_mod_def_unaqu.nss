//::///////////////////////////////////////////////
//:: Example XP2 OnItemUnAcquireScript
//:: x2_mod_def_unaqu
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemUnAcquire Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
#include "x2_inc_switches"
void main()
{
     object oItem = GetModuleItemLost();

	 //Removed for the time being due to possible issue with TonyK AI
	 
	 /*
	 // Kaedrin - Begin
	 // if the creature is a player and they are in combat, they probably were disarmed. 
	 // Lets give the weapon back to them by having them pick it up (loss of combat time)
	 // This will fail if their inventory is full
	 
	 object oLostBy = GetModuleItemLostBy();	 
	 if (GetIsPC(oLostBy) && GetIsInCombat(oLostBy) && (GetWeaponType(oItem) != WEAPON_TYPE_NONE) )
	 {
        //DelayCommand(0.1f, AssignCommand(oLostBy, ClearAllActions()));
		//DelayCommand(0.2f, AssignCommand(oLostBy, ActionDoCommand(ActionPickUpItem(oItem))));
        //DelayCommand(0.3f, FloatingTextStringOnCreature("<color=red>Disarmed!</color>", oLostBy));
		
		// Alternate approach - copy the item and instantly give it back to the player
		// then destroy the original. 
		// HOWEVER - any temporary item properties such as weapon buffs will be lost
		CopyItem(oItem, oLostBy, TRUE);
        DestroyObject(oItem);		
	 }
	 
	 // Kaedrin - End
	 */
	 
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}