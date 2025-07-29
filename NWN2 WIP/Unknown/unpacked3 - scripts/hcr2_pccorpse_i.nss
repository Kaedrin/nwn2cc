/*
Filename:           hcr2_pccorpse_i
System:             pc corpse (include script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:
HCR2 hcr2_pccorpse system function definition file.
This script is consumed by the various pc corpse system scripts as an include file.

-----------------
Revision: v1.01
Added h2_AttemptRessurectionViaNPC() function.
Removed a debug message.

Revision: v1.02
Removed some uneeded constants,
Adjusted code to handle corpse removeal.
Added a remove corpse function.
Fixed bug with XP penealty on Ressurection.
Added code to remove corpse if raise spell was successfully
cast directly on the corpse instead of the token.

Revision: v1.03
Shortened H2_CORPSE tag prefix.
Removed spaces from uniquePCID as they are stripped out when used as a Tag on a copied 
object.
Added work-around fix for the Broken CopyObject function for patch 1.10.

Revision: v1.04
Removed workaround for Broken CopyObject function as it should be fixed now.
Added code to strip other illegal characters which can't be used in the Tag
of copied objects.

Revision: v1.05
Added check in StripIllegalCharacters function to check if the length of the 
string is greater than 32 characters.
Altered logging code
Adjust XP penalty cost function.
Added check for GetIsOwnedByPlayer so rez can be cast on a PC the player is not 
currently controlling.
*/

#include "hcr2_core_i"
#include "hcr2_pccorpse_c"

const string H2_PC_CORPSE_ITEM = "hcr2_corpsetoken";
const string H2_DEAD_PLAYER_ID = "H2_DEAD_PLAYER_ID";
const string H2_DEAD_PLAYER_TAG = "H2_DEAD_PLAYER_TAG";
const string H2_PCCORPSE_ITEM_ACTIVATOR = "H2_PCCORPSE_ITEM_ACTIVATOR";
const string H2_PCCORPSE_ITEM_ACTIVATED = "H2_PCCORPSE_ITEM_ACTIVATED";
const string H2_CORPSE = "H2C";
const string H2_LAST_DROP_LOCATION = "H2_LAST_DROP_LOCATION";
const string H2_RESS_LOCATION = "_RLC";
const string H2_RESS_BY_DM = "_RDM";
const string H2_LOOT_BAG = "hcr2_lootbag";

//Creates a Lootbag laceable object to hold the items of oPC while they are dead or dying.
object h2_CreateLootBag(object oPC)
{
    object oLootBag = GetLocalObject(oPC, H2_LOOT_BAG);
    location lLootBag = GetLocation(oLootBag);
    location lPlayer = GetLocation(oPC);
    if (!GetIsObjectValid(oLootBag) || GetDistanceBetweenLocations(lPlayer, lLootBag) > 3.0 ||
        GetAreaFromLocation(lLootBag) != GetArea(oPC))
    {
        oLootBag = CreateObject(OBJECT_TYPE_PLACEABLE, H2_LOOT_BAG, GetLocation(oPC));
        SetLocalObject(oPC, H2_LOOT_BAG, oLootBag);
    }
    return oLootBag;
}

//This handles moving the pc corpse copy and cleaning up the death corpse container
//whenever the oCorpseToken item is picked up by a PC.
void h2_PickUpPlayerCorpse(object oCorpseToken)
{
    string sDeadPlayerTag = GetLocalString(oCorpseToken, H2_DEAD_PLAYER_TAG);
	object oDC = GetObjectByTag(sDeadPlayerTag);	
    object oWayPt = GetObjectByTag(H2_NOACCESS);    
    if (GetIsObjectValid(oDC))
    {		
		object oDC2 = CopyObject(oDC, GetLocation(oWayPt));
		SetLocalObject(oDC2, H2_PC_CORPSE_ITEM, oCorpseToken);   
		AssignCommand(oDC2, SetIsDestroyable(FALSE, TRUE, TRUE));		    
		AssignCommand(oDC2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oDC2));
		SetScriptHidden(oDC2 , TRUE);
		AssignCommand(oDC, SetIsDestroyable(TRUE, TRUE, TRUE));	
		DestroyObject(oDC);	
    }
}

//This handles moving the pc corpse copy and creating he death corpse container
//whenever the oCorpseToken item is dropped by a PC.
void h2_DropPlayerCorpse(object oCorpseToken)
{
    string sDeadPlayerTag = GetLocalString(oCorpseToken, H2_DEAD_PLAYER_TAG);
    object oDC = GetObjectByTag(sDeadPlayerTag);    
	if (GetIsObjectValid(oDC))
    {   //if the dead player corpse copy exists
        object oDC2 = CopyObject(oDC, GetLocation(oCorpseToken));        
		object oNewToken = CopyItem(oCorpseToken, oDC2, TRUE);					
        SetLocalObject(oDC2, H2_PC_CORPSE_ITEM, oNewToken);		
		AssignCommand(oDC2, SetIsDestroyable(FALSE, FALSE, TRUE));	    
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oDC2);
		DelayCommand(1.0, SetScriptHidden(oDC2, FALSE));
		AssignCommand(oDC, SetIsDestroyable(TRUE, FALSE));
		DestroyObject(oDC);
		SetLocalLocation(oNewToken, H2_LAST_DROP_LOCATION, GetLocation(oNewToken));
    }        	
    DestroyObject(oCorpseToken);
}

string h2_StripStringOfIllegalCharacters(string inputString)
{
	string IllegalCharacters = "~!@#$%^&*()=+[]{};:<>?,|/\\";
	int i = 0;
	for (i = 0; i < GetStringLength(IllegalCharacters); i++)
	{
		string illegalChar = GetSubString(IllegalCharacters, i, 1);
		int index = FindSubString(inputString, illegalChar);
		while (index != -1) //Remove the illegal char
		{
			inputString = GetStringLeft(inputString, index) + GetStringRight(inputString, GetStringLength(inputString) - index -1);
			index = FindSubString(inputString, illegalChar);
		}
	}
	if (GetStringLength(inputString) > 50)
		inputString = GetStringLeft(inputString, 50);
	return inputString;
}

//This handles the creation of the pc corpse copy of oPC, creation
//of the death corpse container and the token item used to move the corpse copy around by
//other PCs when oPC dies.
void h2_CreatePlayerCorpse(object oPC)
{
	//SpawnScriptDebugger();
    string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetFirstName(oPC) + GetLastName(oPC);    
    location loc = GetLocalLocation(oPC, H2_LOCATION_LAST_DIED);
    sUniquePCID = h2_StripStringOfIllegalCharacters(sUniquePCID);			
	object oDeadPlayer = CopyObject(oPC, loc, OBJECT_INVALID, H2_CORPSE + sUniquePCID);	
	SetLootable(oDeadPlayer, TRUE);
    SetFirstName(oDeadPlayer, H2_TEXT_CORPSE_OF + GetFirstName(oPC));
    ChangeToStandardFaction(oDeadPlayer, STANDARD_FACTION_COMMONER);
    // remove gold, inventory & equipped items from dead player corpse copy
    h2_DestroyNonDroppableItemsInInventory(oDeadPlayer);
    h2_MovePossessorInventory(oDeadPlayer, TRUE);
    h2_MoveEquippedItems(oDeadPlayer);
    object oCorpseToken = CreateItemOnObject(H2_PC_CORPSE_ITEM, oDeadPlayer);	
    SetLocalObject(oDeadPlayer, H2_PC_CORPSE_ITEM, oCorpseToken);
	
	// Added by Hyper-V : Set the corpse and token objects on the player
	SetLocalObject(oPC, "hv_corpsetoken", oCorpseToken);
	SetLocalObject(oPC, "hv_corpse", oDeadPlayer);
 	// /////////////////////////////////////////////////////////////
	
    AssignCommand(oDeadPlayer, SetIsDestroyable(FALSE, FALSE, TRUE));	
    AssignCommand(oDeadPlayer, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oDeadPlayer));    
	SetFirstName(oCorpseToken, H2_TEXT_CORPSE_OF + GetName(oPC));
    SetLocalLocation(oCorpseToken, H2_LAST_DROP_LOCATION, GetLocation(oDeadPlayer));
    SetLocalString(oCorpseToken, H2_DEAD_PLAYER_ID, sUniquePCID);	
	SetLocalString(oCorpseToken, H2_DEAD_PLAYER_TAG, GetTag(oDeadPlayer));	
}

string AlexStrip(string inputString)
{
	//SpawnScriptDebugger();
	string IllegalCharacters = "'-.`";
	int i = 0;
	for (i = 0; i < GetStringLength(IllegalCharacters); i++)
	{
		string illegalChar = GetSubString(IllegalCharacters, i, 1);
		int index = FindSubString(inputString, illegalChar);
		while (index != -1) //Remove the illegal char
		{
			inputString = GetStringLeft(inputString, index) + GetStringRight(inputString, GetStringLength(inputString) - index -1);
			index = FindSubString(inputString, illegalChar);
		}
	}
	if (GetStringLength(inputString) > 50)
		inputString = GetStringLeft(inputString, 50);
	return inputString;
}

//This handles the removal of a corpse and token asociated with oPC
//Typically this should be called whenever oPC is ressurected or 
//respawned in any form
void h2_RemoveCorpse(object oPC)
{
	//SpawnScriptDebugger();
    string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetFirstName(oPC) + GetLastName(oPC);
    sUniquePCID = h2_StripStringOfIllegalCharacters(sUniquePCID);	
	sUniquePCID = AlexStrip(sUniquePCID);
	object oCorpse = GetObjectByTag(H2_CORPSE + sUniquePCID);
    if (GetIsObjectValid(oCorpse))
    {
        object oToken = GetLocalObject(oCorpse, H2_PC_CORPSE_ITEM);
        AssignCommand(oCorpse, SetIsDestroyable(TRUE, TRUE, TRUE));
        DestroyObject(oToken);
        DestroyObject(oCorpse);                 
    }
}

//Handles when the corpse token is activated and targeted on on NPC.
void h2_CorpseTokenActivatedOnNPC()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        SetLocalObject(oTarget, H2_PCCORPSE_ITEM_ACTIVATOR, oPC);
        SetLocalObject(oTarget, H2_PCCORPSE_ITEM_ACTIVATED, oItem);
        SignalEvent(oTarget, EventUserDefined(H2_PCCORPSE_ITEM_ACTIVATED_EVENT_NUMBER));
    }
}

int h2_XPLostForRessurection(object oRaisedPC)
{
	int nLevel = GetHitDice(oRaisedPC);
	int nCurrXP = GetXP(oRaisedPC);
	if (nLevel == 1)
		return nCurrXP - 1;

	int currLevelMinXP = h2_GetMinimumXPRequiredForLevel(nLevel);
	int currLevelDiff = nCurrXP - currLevelMinXP;
	int priorLevelMinXP = h2_GetMinimumXPRequiredForLevel(nLevel - 1);
	int priorLevelDiff = (currLevelMinXP - priorLevelMinXP) / 2;
		    
    return currLevelDiff + priorLevelDiff;
}

int h2_GoldCostForRessurection(object oCaster, int nSpellID)
{
    if (nSpellID == SPELL_RAISE_DEAD)
    {
        if (GetGold(oCaster) < H2_GOLD_COST_FOR_RAISE_DEAD)
            return 0;
        return H2_GOLD_COST_FOR_RAISE_DEAD;
    }
    else
    {
        if (GetGold(oCaster) < H2_GOLD_COST_FOR_RESSERECTION)
            return 0;
        return H2_GOLD_COST_FOR_RESSERECTION;
    }
}

location h2_GetOfflineRessLocation(object oPC)
{
	string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetFirstName(oPC) + GetLastName(oPC);
    return h2_GetExternalLocation(sUniquePCID + H2_RESS_LOCATION, OBJECT_INVALID, H2_PCCORPSE_INFO);
}

void h2_SetOfflineRessLocation(string sUniquePCID, location locRess)
{
	h2_SetExternalLocation(sUniquePCID + H2_RESS_LOCATION, locRess, OBJECT_INVALID, H2_PCCORPSE_INFO);
}

int h2_GetOfflineRessByDM(string sUniquePCID)
{
	return h2_GetExternalInt(sUniquePCID + H2_RESS_BY_DM, OBJECT_INVALID, H2_PCCORPSE_INFO);
}

void h2_SetOfflineRessByDM(string sUniquePCID)
{
	h2_SetExternalInt(sUniquePCID + H2_RESS_BY_DM, TRUE, OBJECT_INVALID, H2_PCCORPSE_INFO);
}

void h2_DeleteOfflineRessInfo(string sUniquePCID)
{
	h2_DeleteExternalVariable(sUniquePCID + H2_RESS_LOCATION, OBJECT_INVALID, H2_PCCORPSE_INFO);
    h2_DeleteExternalVariable(sUniquePCID + H2_RESS_BY_DM, OBJECT_INVALID, H2_PCCORPSE_INFO);    
}

int h2_RaiseSpellCastOnCorpseToken(int nSpellID, object oToken = OBJECT_INVALID)
{
    if (!GetIsObjectValid(oToken))
        oToken = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    location castLoc = GetLocation(oCaster);
    string sUniquePCID = GetLocalString(oToken, H2_DEAD_PLAYER_ID);
    object oPC = h2_FindPCWithGivenUniqueID(sUniquePCID);	
	if (!GetIsDM(oCaster))
    {
		if (H2_ALLOW_CORPSE_RESS_BY_PLAYERS == FALSE && GetIsPC(oCaster))
            return FALSE;
        if (H2_REQUIRE_GOLD_FOR_RESS && GetIsPC(oCaster))
        {
			int nGoldCost = h2_GoldCostForRessurection(oCaster, nSpellID);
            if (nGoldCost <= 0)
            {
                SendMessageToPC(oCaster, H2_TEXT_NOT_ENOUGH_GOLD);
                return FALSE;
            }
            else
                TakeGoldFromCreature(nGoldCost, oCaster, TRUE);
        }
		if (nSpellID == SPELL_RAISE_DEAD)
        {
			int nCurrHP = GetCurrentHitPoints(oPC);
            if (nCurrHP > GetHitDice(oPC))
            {
                effect eDam = EffectDamage(nCurrHP - GetHitDice(oPC));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,  eDam, oPC);
            }
        }
        else
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);
		}
        if (H2_APPLY_XP_LOSS_FOR_RESS)
        {
            int nLostXP = h2_XPLostForRessurection(oPC);
			SetXP(oPC, GetXP(oPC) - nLostXP);            
			h2_LogMessage(H2_LOG_INFO, "Removed " + IntToString(nLostXP) + " from " + GetName(oPC) + "_" + GetPCPlayerName(oPC) + " for resurrection penalty.");
            
        }
    }
    else
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);

	if (!GetIsPC(oCaster) && !GetIsDMPossessed(oCaster))
		AssignCommand(oCaster, ActionCastFakeSpellAtLocation(nSpellID, castLoc));  
    
	//SpawnScriptDebugger();	
	//string test = GetName(oToken);
	string sCorpseTag = GetLocalString(oToken, H2_DEAD_PLAYER_TAG);
	DestroyObject(oToken);
	object oCorpse = GetObjectByTag(sCorpseTag);
	AssignCommand(oCorpse, SetIsDestroyable(TRUE, TRUE, TRUE));
	DestroyObject(oCorpse);
	
    string sMessage;
    if (GetIsPC(oCaster))
        sMessage = GetName(oCaster) + "_" + GetPCPlayerName(oCaster);
    else
        sMessage = "NPC " + GetName(oCaster) + " (" + H2_TEXT_CORPSE_TOKEN_USED_BY + GetName(oPC) + "_" + GetPCPlayerName(oPC) + ") ";

    sMessage + H2_TEXT_RESS_PC_CORPSE_ITEM;

   if(GetPCPlayerName(oPC)!="")

    {
        SendMessageToPC(oPC, H2_TEXT_YOU_HAVE_BEEN_RESSURECTED);
        h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
        AssignCommand(oPC, JumpToLocation(castLoc));
        sMessage += GetName(oPC) + "_" + GetPCPlayerName(oPC);
    }
    else //player was offline
    {
		SendMessageToPC(oCaster, "This soul has wondered away and cannot be brought back to the prime material.");
		/*
        SendMessageToPC(oCaster, H2_TEXT_OFFLINE_RESS_CASTER_FEEDBACK);
		h2_SetOfflineRessLocation(sUniquePCID, castLoc);
        if (GetIsDM(oCaster))
            h2_SetOfflineRessByDM(sUniquePCID);
        sMessage += H2_TEXT_OFFLINE_PLAYER + " " + sUniquePCID;
		h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
		*/
    }
    h2_LogMessage(H2_LOG_INFO, sMessage);
	return TRUE;
}

void h2_PerformOffLineRessurectionLogin(object oPC, location locRess)
{
	string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetFirstName(oPC) + GetLastName(oPC);
    h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
    SendMessageToPC(oPC, H2_TEXT_YOU_HAVE_BEEN_RESSURECTED);
    AssignCommand(oPC, JumpToLocation(locRess));
    if (H2_APPLY_XP_LOSS_FOR_RESS && !h2_GetOfflineRessByDM(sUniquePCID))
    {
        int nLostXP = h2_XPLostForRessurection(oPC);
        SetXP(oPC, GetXP(oPC) - nLostXP);       
    }
    h2_DeleteOfflineRessInfo(sUniquePCID);
	string sMessage = sUniquePCID + H2_TEXT_OFFLINE_RESS_LOGIN;
    h2_LogMessage(H2_LOG_INFO, sMessage);
}

//You should only call this function from a user defined
//event of an NPC that you deem has the ability to raise dead/ressurect.
//NPC level checks are not performed.
void h2_AttemptRessurectionViaNPC()
{
	object oPC = GetLocalObject(OBJECT_SELF, H2_PCCORPSE_ITEM_ACTIVATOR);
    object oToken = GetLocalObject(OBJECT_SELF, H2_PCCORPSE_ITEM_ACTIVATED);
    int nSpellID = -1;
    //if (H2_REQUIRE_GOLD_FOR_RESS)
	if(TRUE)
    {
        /*FloatingTextStringOnCreature(H2_TEXT_CLERIC_RES_GOLD_COST, OBJECT_SELF, FALSE);
        if (GetGold(oPC) >= H2_GOLD_COST_FOR_RESSERECTION)
        {
            nSpellID = SPELL_RESURRECTION;
            TakeGoldFromCreature(H2_GOLD_COST_FOR_RESSERECTION, oPC, TRUE);
        }
        else if (GetGold(oPC) >= H2_GOLD_COST_FOR_RAISE_DEAD)
        {
            nSpellID = SPELL_RAISE_DEAD;
            TakeGoldFromCreature(H2_GOLD_COST_FOR_RAISE_DEAD, oPC, TRUE);
        }
        else
            FloatingTextStringOnCreature(H2_TEXT_CLERIC_NOT_ENOUGH_GOLD, OBJECT_SELF, FALSE);*/
        if (GetGold(oPC) >= 500)
        {
            nSpellID = SPELL_RESURRECTION;
            TakeGoldFromCreature(500, oPC, TRUE);
        }
        else if (GetGold(oPC) >= 500)
        {
            nSpellID = SPELL_RAISE_DEAD;
            TakeGoldFromCreature(500, oPC, TRUE);
        }
        else
            FloatingTextStringOnCreature(H2_TEXT_CLERIC_NOT_ENOUGH_GOLD, OBJECT_SELF, FALSE);
    }
    else
        nSpellID = SPELL_RESURRECTION;

    if (nSpellID != -1)
    {
		PlayVoiceChat(VOICE_CHAT_CANDO);
        h2_RaiseSpellCastOnCorpseToken(nSpellID, oToken);
	}
	else
		PlayVoiceChat(VOICE_CHAT_CANTDO);
}