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

// Check if item base type is a weapon
int GetIsWeapon(int nType);

void main()
{
     object oItem = GetModuleItemLost();
	 //SpawnScriptDebugger();
	 // Kaedrin - Begin
	 // if the creature is a player and they are in combat, they probably were disarmed. 
	 // Lets give the weapon back to them by having them pick it up (loss of combat time)
	 // This will fail if their inventory is full
	 object oLostBy = GetModuleItemLostBy();
	 int nType = GetBaseItemType(oItem);
	 object oFinder = GetItemPossessor(oItem); //Get possessor of item.
	 object oAttacker = GetLastAttacker(oLostBy); 
	 object oWeapon = GetLastWeaponUsed(oLostBy);
	 
	 if(GetIsPC(oLostBy) && oItem != OBJECT_INVALID)
	 {
	 	WriteTimestampedLogEntry(GetName(oLostBy) + " has lost the following item: " + GetTag(oItem) + " " + GetName(oItem));
	}
	 //SendMessageToPC(oLostBy, "oDisturber by is: " + GetName(oDisturber));
	 //SendMessageToPC(oLostBy, "oAttacker by is: " + GetName(oAttacker));
	 if (GetIsPC(oLostBy) && GetIsInCombat(oLostBy) && (GetIsWeapon(nType)) && (GetLastAttacker(oLostBy)!=oLostBy) && (GetLastAttacker(oLostBy)!=OBJECT_INVALID))
	 {
        //DelayCommand(0.1f, AssignCommand(oLostBy, ClearAllActions()));
		//DelayCommand(0.2f, AssignCommand(oLostBy, ActionDoCommand(ActionPickUpItem(oItem))));
        //DelayCommand(0.3f, FloatingTextStringOnCreature("<color=red>Disarmed!</color>", oLostBy));
		if(GetHasFeat(FEAT_DISARM, oAttacker) || GetHasFeat(FEAT_IMPROVED_DISARM, oAttacker))
		{
			if(oAttacker == oFinder) //If and only if the person that has the item is the attacker, retrieve it.
			{ // Modification by MustangSVT
				CopyItem(oItem, oLostBy, TRUE);
        		DestroyObject(oItem);
				//Safety check
				SendMessageToAllDMs(GetName(oLostBy) + " was disarmed of weapon: " + GetName(oItem) + ". Potential exploit if repeat.");
			}
			else
			{
				CopyItem(oItem, oLostBy, TRUE);
        		DestroyObject(oItem);
				//Safety check
				SendMessageToAllDMs(GetName(oLostBy) + " was disarmed of weapon: " + GetName(oItem) + ". Potential exploit if repeat.");

				//DelayCommand(0.1f, AssignCommand(oLostBy, ClearAllActions()));
				//DelayCommand(0.2f, AssignCommand(oLostBy, ActionDoCommand(ActionPickUpItem(oItem))));
				//DelayCommand(0.3f, FloatingTextStringOnCreature("<color=red>Disarmed!</color>", oLostBy));
			}

		}
	
		// Alternate approach - copy the item and instantly give it back to the player
		// then destroy the original. 
		// HOWEVER - any temporary item properties such as weapon buffs will be lost

		//CopyItem(oItem, oLostBy, TRUE);
       	//DestroyObject(oItem);
		//SendMessageToAllDMs(GetName(oLostBy) + " was disarmed of weapon: " + GetName(oItem));
	
	 }
	 // Kaedrin - End
	 
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

int GetIsWeapon(int nType)
{
	switch(nType)
	{
	    case BASE_ITEM_BASTARDSWORD: return TRUE;
		case BASE_ITEM_BATTLEAXE: return TRUE;
		case BASE_ITEM_CLUB: return TRUE;
		case BASE_ITEM_DAGGER: return TRUE;
		//case BASE_ITEM_DART: return TRUE;
		case BASE_ITEM_DIREMACE: return TRUE;
		case BASE_ITEM_DOUBLEAXE: return TRUE;
		case BASE_ITEM_DWARVENWARAXE: return TRUE;
		case BASE_ITEM_FALCHION: return TRUE;
		case BASE_ITEM_FLAIL: return TRUE;
		case BASE_ITEM_GLOVES: return TRUE;
		case BASE_ITEM_GREATAXE: return TRUE;
		case BASE_ITEM_GREATSWORD: return TRUE;
		case BASE_ITEM_HALBERD: return TRUE;
		case BASE_ITEM_HANDAXE: return TRUE;
		case BASE_ITEM_HEAVYCROSSBOW: return TRUE;
		case BASE_ITEM_HEAVYFLAIL: return TRUE;
		case BASE_ITEM_KAMA: return TRUE;
		case BASE_ITEM_KATANA: return TRUE;
		case BASE_ITEM_KUKRI: return TRUE;
		case BASE_ITEM_LIGHTCROSSBOW: return TRUE;
		case BASE_ITEM_LIGHTFLAIL: return TRUE;
		case BASE_ITEM_LIGHTHAMMER: return TRUE;
		case BASE_ITEM_LIGHTMACE: return TRUE;
		case BASE_ITEM_LONGBOW: return TRUE;
		case BASE_ITEM_LONGSWORD: return TRUE;
		case BASE_ITEM_MACE: return TRUE;
		case BASE_ITEM_MAGICSTAFF: return TRUE;
		case BASE_ITEM_MORNINGSTAR: return TRUE;
		case BASE_ITEM_QUARTERSTAFF: return TRUE;
		case BASE_ITEM_RAPIER: return TRUE;
		case BASE_ITEM_SCIMITAR: return TRUE;
		case BASE_ITEM_SCYTHE: return TRUE;
		case BASE_ITEM_SHORTBOW: return TRUE;
		case BASE_ITEM_SHORTSPEAR: return TRUE;
		case BASE_ITEM_SHORTSWORD: return TRUE;
		//case BASE_ITEM_SHURIKEN: return TRUE;
		case BASE_ITEM_SICKLE: return TRUE;
		case BASE_ITEM_SLING: return TRUE;
		case BASE_ITEM_SPEAR: return TRUE;
		//case BASE_ITEM_THROWINGAXE: return TRUE;
		case BASE_ITEM_TWOBLADEDSWORD: return TRUE;
		case BASE_ITEM_WARHAMMER: return TRUE;
		case BASE_ITEM_WARMACE: return TRUE;
		case BASE_ITEM_WHIP: return TRUE;
	}
	return FALSE;
}