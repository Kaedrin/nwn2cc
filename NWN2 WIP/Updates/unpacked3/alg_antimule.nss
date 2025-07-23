//::///////////////////////////////////////////////
//:: Example XP2 OnActivate Script Script
//:: x2_mod_def_act
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "x2_inc_switches"
void main()
{
    object oItem = GetModuleItemAcquired();
	object oPC = GetItemPossessor(oItem);
	object oSource = GetModuleItemAcquiredFrom();
	string sPCCDKey = GetPCPublicCDKey(oPC);
	string sPCName = GetName(oPC);
	string sSavedName = GetLocalString(oItem, sPCCDKey);


    // if its not a pc, ignore it.
    if (!GetIsPC(oPC))  return;

    
    // We have to let stacked items get by.  It's too wiggy otherwise
    if (GetItemStackSize(oItem) > 1) return;

    // this player has never touched this item, so mark it
    // also, I trust my DMs, so if the helper is a DM, remark
    // the item for the new character
    if(sSavedName=="" || GetIsDM(oSource) || GetIsDMPossessed(oSource) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
        {
            SetLocalString(oItem, sPCCDKey, sPCName); 
			return;
        }
    // It's ok to sell an item, and then buy it with a different character
    if(GetObjectType(oSource) == OBJECT_TYPE_STORE)
        {
            CopyItem(oItem, oPC);   // copy the item in the player's inventory
            DestroyObject(oItem,0.1);  // destroy the old item, and all the variables on it
            //  note:  the CopyItem should make this script fire again, marking the new item
            return;
        }
    //  It is not ok to pass an item directly or indirectly between
    //  one player's different characters
    if(sPCName!=sSavedName)
        {
            string sHelper = GetName(oSource);
            string sHelperKey = GetPCPublicCDKey(oSource);
            DestroyObject(oItem,0.1);
            SendMessageToPC(oPC,"Trading items between your own characters is muling.  This is illegal on our server.");
			SendMessageToAllDMs(sPCName + " is attempting to mule items between characters.");
			///////END ANTI_MULE
        }
}