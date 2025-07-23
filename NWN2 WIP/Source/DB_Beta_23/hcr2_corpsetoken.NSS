/*
Filename:           hcr2_corpsetoken
System:             pc corpse (token corpse item script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:
pccorpse item event script.
This script fires whenever the hcr2_corpsetoken items are aquired, unaquired, activated
or had a spell cast at it.

-----------------
Revision: v1.01
Removed some debug messages.

*/

#include "hcr2_pccorpse_i"
#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;	
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
		h2_CorpseTokenActivatedOnNPC();
    }
    else if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        oItem = GetModuleItemAcquired();
		oPC = GetModuleItemAcquiredBy();
		if (GetIsPC(oPC))
		{
			object oLostBy =  GetModuleItemAcquiredFrom();
			if (GetObjectType(oLostBy) == OBJECT_TYPE_PLACEABLE && GetName(oLostBy) == "Remains")
				DestroyObject(oLostBy);
			h2_PickUpPlayerCorpse(oItem);
		}
    }
    else if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
    {
        oItem = GetModuleItemLost();
		oPC =  GetModuleItemLostBy();
		if (!GetIsPC(oPC))
			return;
		object oPossessor = GetItemPossessor(oItem);
		if (oPossessor == OBJECT_INVALID)
            h2_DropPlayerCorpse(oItem);
        else if (GetObjectType(oPossessor) == OBJECT_TYPE_PLACEABLE)
        {
            CopyItem(oItem, oPC, TRUE);
            SendMessageToPC(oPC, H2_TEXT_CANNOT_PLACE_THERE);
            DestroyObject(oItem);
        }
    }
    else if (nEvent == X2_ITEM_EVENT_SPELLCAST_AT)
    {
		int nSpellID = GetSpellId();
		if (nSpellID == SPELL_RAISE_DEAD || nSpellID == SPELL_RESURRECTION)
        {
			h2_RaiseSpellCastOnCorpseToken(nSpellID);
            //Now abort the original spell script since the above handled it.
            SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
        }
    }
}