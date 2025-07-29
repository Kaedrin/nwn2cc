/*
Filename:           hcr2_core_i
System:             core (include script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 core function definitions.
This file holds the commonly used functions
used throughout the core HCR2 system.

-----------------
Revision: v1.01
Altered h2_InitializePC to delay the start of the save location timer.
Changed code to deal with adjustment to save location configuration setting.
Items are no longer stripped on a login death.
Boot message is saved on the PC for retrival in the PC loaded event.
Altered h2_MoveEquippedItems to prevent no-dropped equippped items from 
being copied into the recieving object when moved.
Altered h2_DestoryNonDroppableItemsInInventory to destroy equipped 
non-droppable item as well.
Altered h2_MovePossessorInventory to handle containers properly.

Revision v1.02
Added logging to list all detected module hook-in scripts, 
and when they are executed.
Increased class by position counter for feat tracking from 3 to 4.
Re-enabled Feat Tracking on Duelist's Improved reaction
Fixed bug with FindPCWithGivenUniqueID, change usage of GetName to
GetFirstName + GetLastName.
Made save location timer only start if a prior one does not exist.

Revision v1.03 
Added functions to support better Spell-Tracking.
Fixed errors in existing spell-tracking system to better handle 
spontaneous and meta-magic spells.

Revision: v1.04
The Core data point will no longer be created if one already
exists. (Fixes error when loading module from a saved game)

Revision: v1.05
Added h2_RunModuleChatEventScripts and support for OnChat event.
Removed Spell and health saving on login/logout as 
its not neded anymore with the new 'Disable log in heal'
server option
Fix for tracking rest time, spells, feats, and health 
for companions on rest
MotB, SoZ, spells and feats, and custom feats now tracked properly.
Added support for OnPlayerStruck event.
Altered logging code

*/

#include "hcr2_timers_i"
#include "hcr2_persistence_c"

//begin general functions

//This function runs all of the scripts of the given event type in order of the index they were given
//as was set on the variables in Module Properties.
//When calling this function, sEventType should be one of the H2_EVENT_* constants as defined in h2_constants_i.
void h2_RunModuleEventScripts(string sEventType)
{
    int nIndex = 1;
	string sVarname = sEventType + IntToString(nIndex);
    string sScriptname = h2_GetModLocalString(sVarname);
    while (sScriptname != "")
    {		
		h2_LogMessage(H2_LOG_DEBUG,"Executing " + sVarname + ": " + sScriptname);
		ExecuteScript(sScriptname, OBJECT_SELF);
        nIndex++;
		sVarname = sEventType + IntToString(nIndex);
        sScriptname = h2_GetModLocalString(sVarname);
    }
}

int h2_RunModuleChatEventScripts(object oSpeaker, object oTarget, int nChannel, string sChatMessage)
{	
	int nIndex = 1;
	string sVarname = H2_EVENT_ON_CHAT + IntToString(nIndex);
    string sScriptname = h2_GetModLocalString(sVarname);
    int bRet = TRUE;
	while (sScriptname != "")
    {		
		ClearScriptParams();
		AddScriptParameterObject(oSpeaker);
		AddScriptParameterObject(oTarget);
		AddScriptParameterInt(nChannel);
		AddScriptParameterString(sChatMessage);
		h2_LogMessage(H2_LOG_DEBUG,"Executing " + sVarname + ": " + sScriptname);
		bRet = ExecuteScriptEnhanced(sScriptname, OBJECT_SELF, FALSE);
        h2_LogMessage(H2_LOG_DEBUG,"Execution of " + sScriptname + " returned " + IntToString(bRet));
		if (bRet == FALSE)
			break;
		nIndex++;
		sVarname = H2_EVENT_ON_CHAT + IntToString(nIndex);
        sScriptname = h2_GetModLocalString(sVarname);
    }
	ClearScriptParams();
	return bRet;
}

//This functions runs all of the scripts of the given event type in order of the index 
//they were given as set on the variables in the object's properties.
//When calling this function, sEventType should be one of the H2_{OBJECTTYPE}EVENT_* 
//constants as defined in h2_constants_i, where {OBJECTTYPE} may be AREA, CREATURE, 
//PLACEABLE, or DOOR.
//All script assigned as variables on the object are fired before
//global object scripts, which are defined on the module.
//Global object event scripts are fired for all objects for that type.
void h2_RunObjectEventScripts(string sEventType, object oObj)
{
	int nIndex = 1;
	string sVarname = sEventType + IntToString(nIndex);    	
    string sScriptname = GetLocalString(oObj, sVarname);
    while (sScriptname != "")
    {
		h2_LogMessage(H2_LOG_DEBUG,"Executing " + sVarname + ": " + sScriptname);	
		ExecuteScript(sScriptname, oObj);
        nIndex++;
		sVarname = sEventType + IntToString(nIndex);
        sScriptname = GetLocalString(oObj, sVarname);
    }
	h2_RunModuleEventScripts(sEventType);
}

//Returns the number of seconds elapsed since the server was last started.
int h2_GetSecondsSinceServerStart()
{
    // get start date and time
    int nStartYr = h2_GetModLocalInt(H2_SERVER_START_YEAR);
    int nStartMn = h2_GetModLocalInt(H2_SERVER_START_MONTH);
    int nStartDy = h2_GetModLocalInt(H2_SERVER_START_DAY);
    int nStartHr = h2_GetModLocalInt(H2_SERVER_START_HOUR);

    // get current date and time
    int nCurYr = GetCalendarYear();
    int nCurMn = GetCalendarMonth();
    int nCurDy = GetCalendarDay();
    int nCurHr = GetTimeHour();
    int nCurMi = GetTimeMinute();
    int nCurSc = GetTimeSecond();

    // get the real time to game Time Conversion Factor (TCF)
    int nTCF = FloatToInt(HoursToSeconds(1));

    // calculate difference between now and then
    int nElapsed = nCurYr - nStartYr;                       // years
    nElapsed = (nElapsed * 12) + (nCurMn - nStartMn);       // to months
    nElapsed = (nElapsed * 28) + (nCurDy - nStartDy);       // to days
    nElapsed = (nElapsed * 24) + (nCurHr - nStartHr);       // to hours
    nElapsed = (nElapsed * nTCF) + (nCurMi * 60) + nCurSc;  // to seconds

    // return the total
    return nElapsed;
}

//Returns TRUE or FALSE depending on if location loc is valid.
int h2_GetIsLocationValid(location loc)
{
    object oArea = GetAreaFromLocation(loc);
    vector v = GetPositionFromLocation(loc);
    if (GetIsObjectValid(oArea) == FALSE || v.x < 0.0 || v.y < 0.0)
        return FALSE;
    return TRUE;
}

//Returns the minimum XP required to attain nLevel
int h2_GetMinimumXPRequiredForLevel(int nLevel)
{	
	return (nLevel - 1) * nLevel * 500;
}

//Returns a string consisting of the constant H2_TEXT_CURRENT_GAME_DATE_TIME (defined in h2_core_t)
//followed by a datetime format MM/DD/YYYY HH:MM (if bDayBeforeMonth is FALSE)
//or the format DD/MM/YYYY HH:MM (if bDayBeforeMonth is TRUE) (to support other cultural date formats)
//The default value of bDayBeforeMonth is FALSE.
string h2_GetCurrentGameTime(int bDayBeforeMonth = FALSE)
{
    int rl_minutes = GetTimeMinute();
    int rl_minutes_per_hour = FloatToInt(HoursToSeconds(1) / 60);
    int game_minutes_per_hour = 60 / rl_minutes_per_hour;
    int game_minutes = rl_minutes * game_minutes_per_hour;
    string s_minutes = IntToString(game_minutes);
    if (game_minutes < 10)
        s_minutes = "0" + s_minutes;

    string currentTime = H2_TEXT_CURRENT_GAME_DATE_TIME + IntToString(GetCalendarMonth()) + "/" +
                            IntToString(GetCalendarDay()) + "/" + IntToString(GetCalendarYear()) + " " +
                            IntToString(GetTimeHour()) + ":" + s_minutes;
    if (bDayBeforeMonth)
        currentTime = H2_TEXT_CURRENT_GAME_DATE_TIME + IntToString(GetCalendarDay()) + "/" +
                            IntToString(GetCalendarMonth()) + "/" + IntToString(GetCalendarYear()) + " " +
                            IntToString(GetTimeHour()) + ":" + s_minutes;
    return currentTime;
}

//This function copies an item equipped in slot invSlot (one of the INVENTORY_SLOT_* constants) of oPossessor,
//into the inventory of the object designated by oReceivingObject (if oReceivingObject is valid)
//Local variables on the equipped item are copied. The item equipped on oPossessor is then destroyed.
//If either oPossessor or no item is equipped in the given slot, this function does nothing.
void h2_MoveEquippedItem(object oPossessor, int invSlot, object oReceivingObject =  OBJECT_INVALID)
{
    if (!GetIsObjectValid(oPossessor))
        return;
    object oItem = GetItemInSlot(invSlot, oPossessor);
    if (GetIsObjectValid(oItem))
    {
		if (!GetItemCursedFlag(oItem))
		{
	        if (GetIsObjectValid(oReceivingObject))
	            CopyItem(oItem, oReceivingObject, TRUE);						
	        DestroyObject(oItem);
		}
    }
}


//This function copies all of the items in oPossessor's inventory into the inventory of oReceivingObject
//if oReceivingObject is valid. if bMoveGold is true, the gold is transfered as well.
//Local variables on items are also copied. The items in oPossessor's inventory are then destroyed.
//This function will NOT copy or destroy items that have been marked as cursed (not droppable) on their palette.
//If oPossessor is invalid, this function does nothing.
void h2_MovePossessorInventory(object oPossessor, int bMoveGold = FALSE, object oReceivingObject = OBJECT_INVALID)
{
    if (!GetIsObjectValid(oPossessor))
        return;
    if (GetLocalInt(oPossessor, H2_MOVING_ITEMS))
        return;
    SetLocalInt(oPossessor, H2_MOVING_ITEMS, 1);
    if (bMoveGold)
    {
        int nGold = GetGold(oPossessor);
        if (nGold)
        {
            if (GetIsObjectValid(oReceivingObject))
                AssignCommand(oReceivingObject, TakeGoldFromCreature(nGold, oPossessor));
            else
                AssignCommand(oPossessor, TakeGoldFromCreature(nGold, oPossessor, TRUE));
        }
    }
    object oItem = GetFirstItemInInventory(oPossessor);
    while (GetIsObjectValid(oItem))
    {
		if (!GetItemCursedFlag(oItem))
        {
			if (GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX && GetIsObjectValid(GetFirstItemInInventory(oItem)))
			{
				object oContainerItem = GetFirstItemInInventory(oItem);
				object oContainer = CreateItemOnObject(GetResRef(oItem), oReceivingObject);				
				while (GetIsObjectValid(oContainerItem))
				{
					SetLocalObject(oContainerItem, H2_CONTAINER, oContainer);					        
					oContainerItem = GetNextItemInInventory(oItem);
				}				
			} 			
            else if (GetIsObjectValid(oReceivingObject))
			{		
				object oContainer = GetLocalObject(oItem, H2_CONTAINER);		
				DeleteLocalObject(oItem, H2_CONTAINER);
				if (GetIsObjectValid(oContainer))				
					CopyItem(oItem, oContainer, TRUE);
				else
                	CopyItem(oItem, oReceivingObject, TRUE);				
			}
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPossessor);
    }
    DeleteLocalInt(oPossessor, H2_MOVING_ITEMS);
}

//This function copies all equipped items from oPossessor into the inventory of oReceivingObject
//if oReceivingObject is valid.Local variables on the equipped items are copied.
//The items equipped on oPossessor are then destroyed.
//Item located in any of the creature slots are neither copied or destoyed.
//If oPossessor is invalid, this function does nothing.
void h2_MoveEquippedItems(object oPossessor, object oReceivingObject = OBJECT_INVALID)
{
    if (!GetIsObjectValid(oPossessor))
        return;
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_ARMS, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_ARROWS, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_BELT, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_BOLTS, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_BOOTS, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_BULLETS, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_CHEST, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_CLOAK, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_HEAD, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_LEFTHAND, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_LEFTRING, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_NECK, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_RIGHTHAND, oReceivingObject);
    h2_MoveEquippedItem(oPossessor, INVENTORY_SLOT_RIGHTRING, oReceivingObject);
}

//Destoys all items in oPossessor's inventory that have the Cursed (no drop) flag checked.
void h2_DestroyNonDroppableItemsInInventory(object oPossessor)
{
    object oItem = GetFirstItemInInventory(oPossessor);
    while (GetIsObjectValid(oItem))
    {
        if (GetItemCursedFlag(oItem))
            DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPossessor);
    }
	int i;
	for (i = 0; i < INVENTORY_SLOT_BOLTS; i ++)
	{  
		oItem = GetItemInSlot(i, oPossessor);
		if (GetItemCursedFlag(oItem))
            DestroyObject(oItem);
	}
}

//This function boots the player oPC after the number of seconds indicated by delay has passed.
//If sMessage is not empty, the it will be send to the oPC prior to the boot.
//The PCPlayerName of oPC and sMessage are sent to the DM channel and written to the server logs.
//If oPC is invalid this function does nothing.
void h2_BootPlayer(object oPC, string sMessage = "", float delay = 0.0)
{
    if (!GetIsObjectValid(oPC))
        return;
    if (sMessage != "")
	{
		SetLocalString(oPC, H2_BOOT_MESSAGE, sMessage);
        SendMessageToPC(oPC, sMessage);
	}
    sMessage = GetPCPlayerName(oPC) + H2_TEXT_LOG_BOOTED + sMessage;
    h2_LogMessage(H2_LOG_WARN, sMessage);
    DelayCommand(delay, BootPC(oPC));
}

//This function removes all effects from oCreature. It does nothing if oCreature is invalid.
void h2_RemoveEffects(object oCreature)
{
    if (!GetIsObjectValid(oCreature))
        return;
    effect eff = GetFirstEffect(oCreature);
    while (GetEffectType(eff) != EFFECT_TYPE_INVALIDEFFECT)
    {
		if(GetEffectSpellId(eff)!=1500)
		{
        	RemoveEffect(oCreature, eff);
		}
        eff = GetNextEffect(oCreature);
    }
}

//This function removes all effects of type nEffectType. It does nothing if oCreature is invalid.
void h2_RemoveEffectType(object oCreature, int nEffectType)
{
    if (!GetIsObjectValid(oCreature))
        return;
    effect eff = GetFirstEffect(oCreature);
    while (GetEffectType(eff) != EFFECT_TYPE_INVALIDEFFECT)
    {
        if (GetEffectType(eff) == nEffectType)
            RemoveEffect(oCreature, eff);
        eff = GetNextEffect(oCreature);
    }
}

//This functin removes an effect with the given nSpellID from oCreature.
// It does nothing if oCreature is invalid.
void h2_RemoveEffectsWithSpellId(object oCreature, int nSpellID)
{
	if (!GetIsObjectValid(oCreature))
        return;
    effect eff = GetFirstEffect(oCreature);
    while (GetEffectType(eff) != EFFECT_TYPE_INVALIDEFFECT)
    {
        if (GetEffectSpellId(eff) == nSpellID)
            RemoveEffect(oCreature, eff);
        eff = GetNextEffect(oCreature);
    }
}

//This function lowers the value of oPC's current hitpoint to the value saved as H2_PLAYER_HP on oPC.
//This function does nothing if oPC is invalid or oPC's current hit points are less than or equal to the saved
//value.
void h2_SetPlayerHitPointsToSavedValue(object oPC)
{
    if (!GetIsObjectValid(oPC))
        return;
    int nCurrHP = GetCurrentHitPoints(oPC);
    int nSavedHP = GetLocalInt(oPC, H2_PLAYER_HP);
    int nDamage = nCurrHP - nSavedHP;
    if (nDamage < nCurrHP && nDamage > 0)
    {
        effect eDam = EffectDamage(nDamage);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);
		PlayCustomAnimation(oPC, "idle", FALSE);
    }
}

//This function returns the number of feat uses remaining for nFeat on oCreature.
//The query is limited by nMaxUses. If more than nMaxUses are available
//then a value of -1 will be returned (such as for an unlimited use per day, or automatic use feat)
int h2_GetFeatUsesRemaining(object oCreature, int nFeat, int nMaxUses)
{   
    int i;
    for (i = 0; i <= nMaxUses; i++)
    {
		ResetFeatUses(oCreature, nFeat, FALSE, TRUE);
        int bHasFeat = GetHasFeat(nFeat, oCreature);
        if (bHasFeat)                    		
            DecrementRemainingFeatUses(oCreature, nFeat);			        
        else
            break;
    }
	int nCount = i;
    if (nCount == nMaxUses+1)
        nCount = -1;
    for (i = 0; i < nCount; i++)    
        IncrementRemainingFeatUses(oCreature, nFeat);    
	return nCount;
}

//This function sets the number of feat uses remaining for nFeat of oCreature to nUses
void h2_SetFeatsRemaining(object oCreature, int nFeat, int nUses)
{
    int i;
    for (i = 0; i < 50; i++)
    {
		ResetFeatUses(oCreature, nFeat, FALSE, TRUE);
        int bHasFeat = GetHasFeat(nFeat, oCreature);
        if (bHasFeat)		
            DecrementRemainingFeatUses(oCreature, nFeat);					
        else
            break;
    }
    if (i < 50)
    {
        for (i = 0; i < nUses; i++)
            IncrementRemainingFeatUses(oCreature, nFeat);
    }
}

//This function decrements remaining feats uses to values stored as H2_FEAT_TRACK on oPC.
//this function does nothing if oPC is invalid.
void h2_SetAvailableFeatsToSavedValues(object oPC)
{
    string sFeatTrack = GetLocalString(oPC, H2_FEAT_TRACK);
    if (sFeatTrack == "")
        return;
    sFeatTrack = GetStringRight(sFeatTrack, GetStringLength(sFeatTrack) - 1);
    while (sFeatTrack != "")
    {
        int nDivIndex = FindSubString(sFeatTrack, "|");
        int nValIndex = FindSubString(sFeatTrack, ":");
        int nFeat = StringToInt(GetStringLeft(sFeatTrack, nValIndex));
        int nUses = StringToInt(GetSubString(sFeatTrack,  nValIndex + 1, nDivIndex - nValIndex - 1));
        h2_SetFeatsRemaining(oPC, nFeat, nUses);
        sFeatTrack = GetStringRight(sFeatTrack, GetStringLength(sFeatTrack) - nDivIndex - 1);
    }
}

//Returns true if nSpellID is one of the spells
//that is capable of being cast spontaneously.
int h2_IsSpontaneousSpell(int nSpellID)
{
	if (nSpellID == 19 || nSpellID == 80 ||
	   (nSpellID >= 31 && nSpellID <= 35) ||
	   (nSpellID >= 174 && nSpellID <= 182) ||
	   (nSpellID >= 431 && nSpellID <= 435) ||
	   nSpellID == 891 || nSpellID == 892 ||
	   nSpellID == 894 || nSpellID == 895 ||
	   nSpellID == 897 || nSpellID == 898)
	   	return TRUE;
	return FALSE;
}

//Some spellIDs are 'sub-spells' of a primary spellID.
//Returns true if nSpellID is a sub-spellID.
//Examples are protection_from_evil and protection_from_good,
//which are sub-spellIDs of protection_from_alignment.
int h2_IsSubSpell(int nSpellID)
{
	if (nSpellID == 84 || nSpellID == 187 ||
		nSpellID == 138 || nSpellID == 139 ||
		nSpellID == 974 || nSpellID == 975 ||
		(nSpellID >= 330 && nSpellID <= 334) )
		return TRUE;
	return FALSE; 
}

//This function decrements remaining spell uses to values stored on the oPC.
//This function does nothing if oPC is invalid.
void h2_SetAvailableSpellsToSavedValues(object oPC)
{
    if (!GetIsObjectValid(oPC))
        return;
    
    string sSpellTrack = GetLocalString(oPC, H2_SPELLS_AVAILABLE);	    
    int nSpellID;
	if (sSpellTrack != "")
	{
		sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - 1);
		//This checks to see if the player did a spell swap
		//and will decrement to zero, any spells not known to 
		//have been 'memorized' during the last good rest.
	    for(nSpellID = 0; nSpellID < 1215; nSpellID++) 
		{
	        int nSpellsRemaining = GetHasSpell(nSpellID, oPC);
	        if (nSpellsRemaining > 0 && !h2_IsSpontaneousSpell(nSpellID) && !h2_IsSubSpell(nSpellID))
	        {
	            int nIndex = FindSubString(sSpellTrack, IntToString(nSpellID)+":");
	            if (nIndex == -1)
	            {
					//decrement spells that the player has, but were not known to have been set on
	                //their last log out.
	                while (nSpellsRemaining > 0) 
					{
	                    DecrementRemainingSpellUses(oPC, nSpellID);
	                    nSpellsRemaining--;
	                }
	            }            
	        }
	    }
	}
	//Now decrement regular spells according to the number
	//of castings tracked via spellhook.
	sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK);	
	while (sSpellTrack != "")
	{
		int index = FindSubString(sSpellTrack, ":");
		nSpellID = StringToInt(GetStringLeft(sSpellTrack, index));
		DecrementRemainingSpellUses(oPC, nSpellID);
		sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - (index+1));		
	}
	//Always do possible sponteneously cast spells last.
	//This ensures that regular casts of non-sp. spells have alreadyt been decrmented,
	//so any leftover sp. spell decrements the true spell, or leftover equivalent level 
	//regular spells.
	sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK_SP);	
	while (sSpellTrack != "")
	{
		int index = FindSubString(sSpellTrack, ":");
		nSpellID = StringToInt(GetStringLeft(sSpellTrack, index));
		DecrementRemainingSpellUses(oPC, nSpellID);
		sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - (index+1));		
	}	    
}

//This function decrements remaining spell uses to values stored on the oPC.
//This function does nothing if oPC is invalid.
void h2_SetAvailableSpellsToSavedValuesCampaign(object oPC)
{
    if (!GetIsObjectValid(oPC))
        return;
    
    //string sSpellTrack = GetLocalString(oPC, H2_SPELLS_AVAILABLE);
	string sSpellTrack = GetCampaignString( "Dalelands Beyond", GetPCPlayerName( oPC ) + GetName( oPC ));   
    int nSpellID;
	if (sSpellTrack != "")
	{
		sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - 1);
		//This checks to see if the player did a spell swap
		//and will decrement to zero, any spells not known to 
		//have been 'memorized' during the last good rest.
	    for(nSpellID = 0; nSpellID < 1215; nSpellID++) 
		{
	        int nSpellsRemaining = GetHasSpell(nSpellID, oPC);
	        if (nSpellsRemaining > 0 && !h2_IsSpontaneousSpell(nSpellID) && !h2_IsSubSpell(nSpellID))
	        {
	            int nIndex = FindSubString(sSpellTrack, IntToString(nSpellID)+":");
	            if (nIndex == -1)
	            {
					//decrement spells that the player has, but were not known to have been set on
	                //their last log out.
	                while (nSpellsRemaining > 0) 
					{
	                    DecrementRemainingSpellUses(oPC, nSpellID);
	                    nSpellsRemaining--;
	                }
	            }            
	        }
	    }
	}
	//Now decrement regular spells according to the number
	//of castings tracked via spellhook.
	sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK);	
	while (sSpellTrack != "")
	{
		int index = FindSubString(sSpellTrack, ":");
		nSpellID = StringToInt(GetStringLeft(sSpellTrack, index));
		DecrementRemainingSpellUses(oPC, nSpellID);
		sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - (index+1));		
	}
	//Always do possible sponteneously cast spells last.
	//This ensures that regular casts of non-sp. spells have alreadyt been decrmented,
	//so any leftover sp. spell decrements the true spell, or leftover equivalent level 
	//regular spells.
	sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK_SP);	
	while (sSpellTrack != "")
	{
		int index = FindSubString(sSpellTrack, ":");
		nSpellID = StringToInt(GetStringLeft(sSpellTrack, index));
		DecrementRemainingSpellUses(oPC, nSpellID);
		sSpellTrack = GetStringRight(sSpellTrack, GetStringLength(sSpellTrack) - (index+1));		
	}	    
}


//Saves oPCs hitpoints to a local variable H2_PLAYER_HP on oPC.
void h2_SavePCHitPoints(object oPC)
{
    if (!GetIsObjectValid(oPC))
        return;
    int nHP = GetCurrentHitPoints(oPC);
	SetLocalInt(oPC, H2_PLAYER_HP, nHP);
}

//private function only meant to be called from h2_SavePCAvailableFeats
string h2_AppendToFeatTrack(string sFeatTrack, object oPC, int nFeat, int nMaxUses)
{
    int nFeatUses = h2_GetFeatUsesRemaining(oPC, nFeat, nMaxUses);
    if (nFeatUses > -1)
        return sFeatTrack + IntToString(nFeat) + ":" + IntToString(nFeatUses) + "|";
    return sFeatTrack;
}

void h2_SetUpFeatUsesData()
{
	int nCount = GetNum2DARows("feat");
	int i = 0;
	object oDP = GetObjectByTag(H2_FEATUSES_DATA_POINT);
	for (i = 0; i < nCount; i++)
	{	
		int uses = StringToInt(Get2DAString("feat", "USESPERDAY", i));
		string sRemoved = Get2DAString("feat", "Removed", i);
		int cooldown = StringToInt(Get2DAString("feat", "Cooldown", i));
		//Im only interested in non-removed feats with a positive UsesPerDay value 
		//which do not have a cooldown value. 
		//(decremnting cooldown feats odd behavior issues)
		if (sRemoved == "0" && uses > 0 && cooldown == 0)				
			SetLocalInt(oDP, IntToString(i), uses);
			//This creates a list of feats on oDP to check later
			//for incremnting/decremnting restrictions.				
	}
}

//Saves the values of the remaining uses of oPC's current feats to H2_FEAT_TRACK on oPC.
void h2_SavePCAvailableFeats(object oPC)
{
	object oDP = GetObjectByTag(H2_FEATUSES_DATA_POINT);
	int nCount = GetVariableCount(oDP);
	int i = 0;
	string sFeatTrack = "X";
	for (i = 0; i < nCount; i++)
	{
		int nFeat = StringToInt(GetVariableName(oDP, i));
		if (GetHasFeat(nFeat, oPC, TRUE))
		{
			int nBaseUses = GetVariableValueInt(oDP, i);
			sFeatTrack = h2_AppendToFeatTrack(sFeatTrack, oPC, nFeat, nBaseUses + 12);                
		}
	}
	SetLocalString(oPC, H2_FEAT_TRACK, sFeatTrack);	
}

//Saves the values of which spells are available to a PC at the time of being called.
//This should be called on the Restfinished event of a good rest.
void h2_SavePCSpellsAvailable(object oPC)
{
    int nSpellID;
	string sSpelltrack = "X";
    for (nSpellID = 0; nSpellID < 1215; nSpellID++) 
	{
        int bHasSpell = GetHasSpell(nSpellID, oPC);
        if(bHasSpell && !h2_IsSpontaneousSpell(nSpellID) && !h2_IsSubSpell(nSpellID))		
			sSpelltrack = sSpelltrack + IntToString(nSpellID) + ":";					
    }		
	SetLocalString(oPC, H2_SPELLS_AVAILABLE, sSpelltrack);
}

//Saves the values of which spells are available to a PC at the time of being called.
//This should be called on the Restfinished event of a good rest.
void h2_SavePCSpellsAvailableCampaign(object oPC)
{
    int nSpellID;
	string sSpelltrack = "X";
    for (nSpellID = 0; nSpellID < 1215; nSpellID++) 
	{
        int bHasSpell = GetHasSpell(nSpellID, oPC);
        if(bHasSpell && !h2_IsSpontaneousSpell(nSpellID) && !h2_IsSubSpell(nSpellID))		
			sSpelltrack = sSpelltrack + IntToString(nSpellID) + ":";					
    }		
	SetLocalString(oPC, H2_SPELLS_AVAILABLE, sSpelltrack);
	SetCampaignString("Dalelands Beyond", GetPCPlayerName( oPC ) + GetName( oPC ), sSpelltrack);
}

void h2_AddTrackedSpell()
{
	object oPC = OBJECT_SELF;
	if (!GetIsPC(oPC))
		return;		
	if (GetSpellFeatId() != 0 || GetIsObjectValid(GetSpellCastItem()))
		return;
	int nSpellID = GetSpellId();
		
	if (!h2_IsSpontaneousSpell(nSpellID))
	{
		string sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK);										
		sSpellTrack += IntToString(nSpellID) + ":";				
		SetLocalString(oPC, H2_SPELL_TRACK, sSpellTrack);	
	}
	else
	{
		string sSpellTrack = GetLocalString(oPC, H2_SPELL_TRACK_SP);								
		sSpellTrack += IntToString(nSpellID) + ":";		
		SetLocalString(oPC, H2_SPELL_TRACK_SP, sSpellTrack);		
	}
}

void h2_CheckOnHitCast()
{
	object oItem = GetSpellCastItem();
	if (!GetIsObjectValid(oItem))
		return;
	itemproperty ip = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ip))
	{
		int iptype = GetItemPropertyType(ip);
		if (iptype == ITEM_PROPERTY_ONHITCASTSPELL)
		{
			int st = GetItemPropertySubType(ip);
			object oCaster = OBJECT_SELF;
			if (st == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
			{	//OnHit: UniquePower
				ExecuteScript("x2_s3_onhitcast", oCaster);
				return;       
			}
			else if (st == 120) 
			{	//OnHit: Player Struck Event
				ExecuteScript(H2_PLAYERSTRUCK_SCRIPT, oCaster);
				return;
			}
		}
		ip = GetNextItemProperty(oItem);
	}
}

//Drops all henchman from oPC.
void h2_DropAllHenchmen(object oPC)
{
    object oHenchman = GetHenchman(oPC);
    while (GetIsObjectValid(oHenchman))
    {
        RemoveHenchman(oPC, oHenchman);
        oHenchman = GetHenchman(oPC);
    }
}

//Removes all companions from the PC's party
void h2_DropAllCompanions(object oPC)
{
	if (!GetIsOwnedByPlayer(oPC) || !GetIsPC(oPC))
	{
		h2_LogMessage(H2_LOG_ERROR, "h2_DropAllCompanions may only be called fom the PC's orignal character when the player is controlling it.");
		return;
	}
	string sRosterMember = GetFirstRosterMember();
	while (sRosterMember != "")
	{
		object oCompanion = GetObjectFromRosterName(sRosterMember);
		if (GetFactionEqual(oPC, oCompanion))		
			RemoveRosterMemberFromParty(sRosterMember, oPC, FALSE);					
		sRosterMember = GetNextRosterMember();
	}
}


//Searchs the logged in PCs and returns the PC with the matching sUniquePCID.
//Returns OBJECT_INVALID if not found.
object h2_FindPCWithGivenUniqueID(string sUniquePCID)
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {  
        if (sUniquePCID == GetPCPlayerName(oPC) + "_" + GetFirstName(oPC) + GetLastName(oPC))
            return oPC;
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}

//Rolls a standard skill check for nSkill for oUser.
//The return value is d20 + rank + ability and effect modifiers + additional modifiers
//nRollModifier  if an extra value added to the roll. It can be positive or negative..
//If nBroadCastLevel = 0, only the DM channel gets the results.
//If nBroadCastLevel = 1, the skill user gets the results as well.
//If nBroadCastLevel = 2, in addtion to the above, all nearby PCs also get the result.
int h2_SkillCheck(int nSkill, object oUser, int nRollModifier = 0, int nBroadCastLevel = 1)
{
    int nRank = GetSkillRank(nSkill, oUser);
    int nRoll = d20();
    string sSkill;
    switch (nSkill)
    {
        case SKILL_APPRAISE: sSkill = H2_TEXT_SKILL_APPRAISE; break;
        case SKILL_BLUFF: sSkill = H2_TEXT_SKILL_BLUFF; break;
        case SKILL_CONCENTRATION: sSkill = H2_TEXT_SKILL_CONCENTRATION; break;
		case SKILL_CRAFT_ALCHEMY: sSkill =  H2_TEXT_SKILL_CRAFT_ALCHEMY; break;
        case SKILL_CRAFT_ARMOR: sSkill = H2_TEXT_SKILL_CRAFT_ARMOR; break;
        case SKILL_CRAFT_TRAP: sSkill = H2_TEXT_SKILL_CRAFT_TRAP; break;
        case SKILL_CRAFT_WEAPON: sSkill = H2_TEXT_SKILL_CRAFT_WEAPON; break;
        case SKILL_DIPLOMACY: sSkill = H2_TEXT_SKILL_DIPLOMACY; break;
		case SKILL_DISABLE_TRAP: sSkill = H2_TEXT_SKILL_DISABLE_TRAP; break;
        case SKILL_HEAL: sSkill = H2_TEXT_SKILL_HEAL; break;
        case SKILL_HIDE: sSkill = H2_TEXT_SKILL_HIDE; break;
        case SKILL_INTIMIDATE: sSkill = H2_TEXT_SKILL_INTIMIDATE; break;
        case SKILL_LISTEN: sSkill = H2_TEXT_SKILL_LISTEN; break;
        case SKILL_LORE: sSkill = H2_TEXT_SKILL_LORE; break;
        case SKILL_MOVE_SILENTLY: sSkill = H2_TEXT_SKILL_MOVE_SILENTLY; break;
        case SKILL_OPEN_LOCK: sSkill = H2_TEXT_SKILL_OPEN_LOCK; break;
        case SKILL_PARRY: sSkill = H2_TEXT_SKILL_PARRY; break;
        case SKILL_PERFORM: sSkill = H2_TEXT_SKILL_PERFORM; break;
        case SKILL_SEARCH: sSkill = H2_TEXT_SKILL_SEARCH; break;
        case SKILL_SET_TRAP: sSkill = H2_TEXT_SKILL_SET_TRAP; break;
		case SKILL_SLEIGHT_OF_HAND: sSkill = H2_TEXT_SKILL_SLEIGHT_OF_HAND; break;
        case SKILL_SPELLCRAFT: sSkill = H2_TEXT_SKILL_SPELLCRAFT; break;
        case SKILL_SPOT: sSkill = H2_TEXT_SKILL_SPOT; break;
		case SKILL_SURVIVAL: sSkill = H2_TEXT_SKILL_SURVIVAL; break;
        case SKILL_TAUNT: sSkill = H2_TEXT_SKILL_TAUNT; break;
        case SKILL_TUMBLE: sSkill = H2_TEXT_SKILL_TUMBLE; break;
        case SKILL_USE_MAGIC_DEVICE: sSkill = H2_TEXT_SKILL_USE_MAGIC_DEVICE; break;
    }
    string sMessage = GetName(oUser) + " " + sSkill + H2_TEXT_SKILL_CHECK + IntToString(nRoll) +
                        " + " + IntToString(nRank) + (nRollModifier == 0 ? "" : " + " + IntToString(nRollModifier)) +
					 	" = " + IntToString(nRoll+nRank+nRollModifier);
    SendMessageToAllDMs(sMessage);
    if (nBroadCastLevel == 1)
        SendMessageToPC(oUser, sMessage);
    else if (nBroadCastLevel == 2)
        FloatingTextStringOnCreature(sMessage, oUser);

    return nRank + nRoll + nRollModifier;
}

//Adds a color token  to sText from the given RGB values
string h2_ColorText(string sText, int nRed=255, int nGreen=255, int nBlue=255)
{
	int nRGB = (nRed * 65536) + (nGreen * 256)	+ nBlue;
	string sColorHex = GetSubString(IntToHexString(nRGB),2, 8);
    return "<color=#" + sColorHex + ">" + sText + "</color>";	
}


//end general functions

//Module load functions

//This creates a waypoint at the module starting location with the given tag
//Use this waypoint to hold variables so that you do not have to rely on the 
//over-used module object to store things.
void h2_CreateDataPoint(string sDataPointTag)
{
	object oDataPoint = GetObjectByTag(sDataPointTag);
	if (!GetIsObjectValid(oDataPoint))
	{
    	oDataPoint = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", GetStartingLocation());
		SetTag(oDataPoint, sDataPointTag);
	}
}

//Call this after the game date and time has been restored with h2_RestoreSavedCalendar.
//This saved the current date and time as the server start time. Used in calculating the elapsed time
//passed for timers and various other effects. Only call this after the Calandar has been restored.
void h2_SaveServerStartTime()
{
    h2_SetModLocalInt(H2_SERVER_START_HOUR, GetTimeHour());
    h2_SetModLocalInt(H2_SERVER_START_DAY, GetCalendarDay());
    h2_SetModLocalInt(H2_SERVER_START_MONTH, GetCalendarMonth());
    h2_SetModLocalInt(H2_SERVER_START_YEAR, GetCalendarYear());
}

//This copies all of the module event variables that the mod builder included
//over to the core data waypoint object. This is merely to take them off the
//over-used module object and increase the access time somewhat.
//sEventType in used internally for recursion, to not alter it from the default.
void h2_CopyEventVariablesToCoreDataPoint(string sEventType = "")
{
    if (sEventType != "")
    {
        object oMod = GetModule();
        int index = 1;
        string scriptname = GetLocalString(oMod, sEventType + IntToString(index));
        while (scriptname != "")
        {
			h2_LogMessage(H2_LOG_INFO, sEventType + IntToString(index) + ": " + scriptname);
            h2_SetModLocalString(sEventType + IntToString(index), scriptname);
            DeleteLocalString(oMod, sEventType + IntToString(index));
            index++;
            scriptname = GetLocalString(oMod, sEventType + IntToString(index));			
        }
    }
    else
    {
		h2_LogMessage(H2_LOG_INFO, H2_TEXT_LOG_MODULE_HOOKIN_SCRIPTS_DETECTED);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_ACQUIRE_ITEM);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_ACTIVATE_ITEM);
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_CHAT);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_CLIENT_ENTER);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_CLIENT_LEAVE);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_CUTSCENE_ABORT);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_HEARTBEAT);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_MODULE_LOAD);
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PC_LOADED);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_DEATH);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_DYING);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_EQUIP_ITEM);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_RESPAWN);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_LEVEL_UP);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_REST_STARTED);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_REST_CANCELLED);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_REST_FINISHED);
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_STRUCK);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PLAYER_UNEQUIP_ITEM);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_SPELLHOOK);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_UNACQUIRE_ITEM);
        h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_USER_DEFINED);	
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_PRE_LEVEL_UP);	
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_CANCEL_LEVEL_UP);	
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_POST_LEVEL_UP);	
		h2_CopyEventVariablesToCoreDataPoint(H2_EVENT_ON_HOTBAR_CLICK);	
		h2_CopyEventVariablesToCoreDataPoint(H2_AREAEVENT_ON_CLIENT_ENTER);
        h2_CopyEventVariablesToCoreDataPoint(H2_AREAEVENT_ON_ENTER);
        h2_CopyEventVariablesToCoreDataPoint(H2_AREAEVENT_ON_EXIT);
        h2_CopyEventVariablesToCoreDataPoint(H2_AREAEVENT_ON_HEARTBEAT);
        h2_CopyEventVariablesToCoreDataPoint(H2_AREAEVENT_ON_USER_DEFINED);
    }
}

//This creates a menu item in the conversation that is opened when the 'Player Info and Action Item'
//is activated by the PC. sMenuText is the text you want to appear to the user for that menu choice.
//sConvResRef is the resref of a conversation file that will be opened as a result
//of the PC choosing that menu. Note that all of the conversations are opened as if the PC
//is conversing with themselves, private conversation is true, and play hello is false.
//If sMenuText is an empty string nothing will be added.
//Only a maximum of 20 menu items can be added, if you exceed this amount the menu item
//is not added, instead a log file is generated stating that the maximim number of items was exceeded.
//This function should only be called from a module load hook-in script.
void h2_AddPlayerMenuItem(string sMenuText, string sConvResRef)
{
     if (sMenuText == "")
        return;
    int index = h2_GetModLocalInt(H2_PLAYER_DATA_MENU_INDEX) + 1;
    if (index <=20)
    {
        h2_SetModLocalInt(H2_PLAYER_DATA_MENU_INDEX, index);
        h2_SetModLocalString(H2_PLAYER_DATA_MENU_ITEM_TEXT + IntToString(index), sMenuText);
        h2_SetModLocalString(H2_CONVERSATION_RESREF + IntToString(index), sConvResRef);
    }
    else
        h2_LogMessage(H2_LOG_ERROR, H2_TEXT_LOG_PLAYER_MENU + sMenuText + H2_TEXT_LOG_PLAYER_MENU_EXCEEDED);
}

//Create and starts the export character timer.
void h2_StartCharExportTimer()
{
	if (H2_EXPORT_CHARACTERS_INTERVAL > 0.0)
	{
		int nTimerID = h2_CreateTimer(GetModule(), H2_EXPORT_CHAR_TIMER_SCRIPT, H2_EXPORT_CHARACTERS_INTERVAL);
		h2_StartTimer(nTimerID);		
	}
}
//end module load functions

//pc loaded functions

//Sends oPC to their last saved location.if that  location is valid and its their first login 
//since the last reset.
//Does nothing if oPC is invalid.
void h2_SendPCToSavedLocation(object oPC)
{
    if (!GetIsObjectValid(oPC))
        return;
    string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
    int bHasLoggedInThisReset = h2_GetModLocalInt(sUniquePCID + H2_INITIAL_LOGIN);
    if (!bHasLoggedInThisReset && H2_SAVE_PC_LOCATION_TIMER_INTERVAL > 0.0)
    {
        location locSavedLocation = h2_GetSavedPCLocation(oPC);
        if (h2_GetIsLocationValid(locSavedLocation))
        {
           // SendMessageToPC(oPC, H2_TEXT_SEND_TO_SAVED_LOC);
            //AssignCommand(oPC, ActionJumpToLocation(locSavedLocation));
        }
    }
}

//Strips oPC of all items on their first login.
//This function is only ran if H2_STRIP_ON_FIRST_LOGIN = TRUE.
void h2_StripOnFirstLogin(object oPC)
{
	h2_MovePossessorInventory(oPC, TRUE);
	h2_MoveEquippedItems(oPC);
}

//Registers the PCs. by incrementing the players registered character count
//and sending appropraite feedback.
void h2_RegisterPC(object oPC)
{
	int nRegisteredCharCount = h2_GetRegisteredCharCount(oPC);
    h2_SetRegisteredCharCount(oPC, 	nRegisteredCharCount + 1);
    SendMessageToPC(oPC, H2_TEXT_CHAR_REGISTERED);
    SendMessageToPC(oPC, H2_TEXT_TOTAL_REGISTERED_CHARS + IntToString(nRegisteredCharCount + 1));
    if (H2_REGISTERED_CHARACTERS_ALLOWED > 0)
		SendMessageToPC(oPC, H2_TEXT_MAX_REGISTERED_CHARS + IntToString(H2_REGISTERED_CHARACTERS_ALLOWED));	
}

//Performs important set up activity on oPC's first login
//including getting and setting the unique player ID and other player persistant
//information.
void h2_InitializePC(object oPC)
{
	//Turn off cheating flags
    SetPlotFlag(oPC, FALSE);
    SetImmortal(oPC, FALSE);

	//Check if they logged in dead or dying
    if (h2_GetPlayerState(oPC) != H2_PLAYER_STATE_ALIVE)
    {
        SetLocalInt(oPC, H2_LOGIN_DEATH, TRUE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPC);
        return;
    }
	
	//Register PC and Strip Inventory
	if (GetXP(oPC) == 0 && GetHitDice(oPC) == 1)
	{	    	        
		h2_RegisterPC(oPC);
		if (H2_STRIP_ON_FIRST_LOGIN)
        	h2_StripOnFirstLogin(oPC);	
		GiveXPToCreature(oPC, 1);					
	}
	
	//Send the PC to their saved location and set the intial login flag
   // h2_SendPCToSavedLocation(oPC);
	
	string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);;    
    h2_SetModLocalInt(sUniquePCID + H2_INITIAL_LOGIN, TRUE);	

	//Start the save location timer.
	int nTimerID = GetLocalInt(oPC, H2_SAVELOC_TIMER);
	string sTimerScript = h2_GetModLocalString(H2_TIMER_SCRIPT + IntToString(nTimerID));
    if (H2_SAVE_PC_LOCATION_TIMER_INTERVAL > 0.0 && sTimerScript == "")
    {
        nTimerID = h2_CreateTimer(oPC, H2_SAVE_LOCATION, H2_SAVE_PC_LOCATION_TIMER_INTERVAL);
        DelayCommand(H2_SAVE_PC_LOCATION_TIMER_INTERVAL, h2_StartTimer(nTimerID));
		SetLocalInt(oPC, H2_SAVELOC_TIMER, nTimerID); 		
    }	
}

//Returns TRUE if the number of non-DM PCs currently online equal the value set to H2_MAXIMUM_PLAYERS
//This function is used in determining if enough slots remain open for the DM Reserve amount.
int h2_MaximumPlayersReached()
{
    return (H2_MAXIMUM_PLAYERS > 0 && h2_GetModLocalInt(H2_PLAYER_COUNT) >= H2_MAXIMUM_PLAYERS);
}
//end pc loaded functions

//player rest functions

//Returns a TRUE or FALSE value that says whether or not rest should be allowed (TRUE)
//or not allowed (FALSE) for oPC.
int h2_GetAllowRest(object oPC)
{
    return GetLocalInt(oPC, H2_ALLOW_REST);
}

//bAllowRest should be TRUE or FALSE.
//This sets a variable than when read by h2_GetAllowRest, returns the value of bAllowRest.
//This should be set to FALSE if oPC should not be allowed to rest on their next rest action.
void h2_SetAllowRest(object oPC, int bAllowRest)
{
    SetLocalInt(oPC, H2_ALLOW_REST, bAllowRest);
}

//Returns a TRUE or FALSE value indicating whether or not Spells are allowed to be
//properly recovered after the oPC's next rest if finished.
int h2_GetAllowSpellRecovery(object oPC)
{
    return GetLocalInt(oPC, H2_ALLOW_SPELL_RECOVERY);
}

//Returns a TRUE or FALSE value indicating whether or not Feats are allowed to be
//properly recovered after the oPC's next rest if finished.
int h2_GetAllowFeatRecovery(object oPC)
{
	return GetLocalInt(oPC, H2_ALLOW_FEAT_RECOVERY);
}

//bAllowRecovery should be TRUE or FALSE
//This set a variable than when read by h2_GetAllowSpellRecovery, returns the value of bAllowRecovery.
//This should be set to FALSE if oPC should not be allowed to recover spells after their
//next rest action is finished.
void h2_SetAllowSpellRecovery(object oPC, int bAllowRecovery)
{
    SetLocalInt(oPC, H2_ALLOW_SPELL_RECOVERY, bAllowRecovery);
}

//bAllowRecovery should be TRUE or FALSE
//This set a variable than when read by h2_GetAllowFeatRecovery, returns the value of bAllowRecovery.
//This should be set to FALSE if oPC should not be allowed to recoverfeats after their
//next rest action is finished.
void h2_SetAllowFeatRecovery(object oPC, int bAllowRecovery)
{
    SetLocalInt(oPC, H2_ALLOW_FEAT_RECOVERY, bAllowRecovery);
}

//Returns an integer that indiated that amount of HitPoints oPC should be allowed to regain
//after their next rest action is finished.
int h2_GetPostRestHealAmount(object oPC)
{
    return GetLocalInt(oPC, H2_POST_REST_HEAL_AMT);
}

//This sets the amount of HitPoints oPC will be allowed to regain
//after their next rest action is finished.
void h2_SetPostRestHealAmount(object oPC, int amount)
{
    SetLocalInt(oPC, H2_POST_REST_HEAL_AMT, amount);
}

//This function displayss the rest message box to the PC
void h2_DisplayRestMessageBox(object oPC)
{
    SetLocalInt(oPC, H2_SKIP_CANCEL_REST, TRUE);
    AssignCommand(oPC, ClearAllActions());
	SetLocalInt(oPC, H2_OK_TO_REST, TRUE);
	DisplayMessageBox(oPC, 0, H2_TEXT_REST_MESSAGE, 	
					H2_REST_MESSAGE_CALLBACK_SCRIPT, 
					H2_REST_MESSAGE_CANCEL_SCRIPT, 
					TRUE,  "",0, H2_TEXT_RESTBUTTON);    						
}

//This makes oPC actually rest. It will not show the rest messagebox
//when the rest occurs. Run this from a rest gui button callback script.
void h2_MakePCRest(object oPC)
{
    SetLocalInt(oPC, H2_SKIP_REST_MESSAGEBOX, TRUE);	
	object oPM = GetFirstFactionMember(oPC, FALSE);
	while (GetIsObjectValid(oPM))
	{
		if (!GetIsPC(oPM) || oPM == oPC)
		{
			h2_RemoveEffectType(oPM, EFFECT_TYPE_BONUS_HITPOINTS);
			h2_RemoveEffectType(oPM, EFFECT_TYPE_TEMPORARY_HITPOINTS);
			h2_RemoveEffectType(oPM, EFFECT_TYPE_ABILITY_INCREASE);   	
			h2_SavePCAvailableFeats(oPM);
			h2_SavePCSpellsAvailable(oPM);
			h2_SavePCHitPoints(oPM);	
		}
		oPM = GetNextFactionMember(oPM, FALSE);
	}
    AssignCommand(oPC, ActionRest(TRUE));
	DeleteLocalInt(oPC, H2_OK_TO_REST);	
}

//This function uses the value from h2_GetPostRestHealAmount to restrict
//the amount of HitPoints gained after oPC's rest is finished.
//It should be called from rest event finished script hook-ins.
void h2_LimitPostRestHeal(object oPC, int postRestHealAmt)
{
	int savedHP = GetLocalInt(oPC, H2_PLAYER_HP);
    int currHP = GetCurrentHitPoints(oPC);
    if (savedHP + postRestHealAmt < currHP)
    {
		int nDam = currHP - (savedHP + postRestHealAmt);
        effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
		PlayCustomAnimation(oPC, "idle", FALSE);
    }
}
//end player rest functions

//begin player euip/unequip functions
void h2_AddOnHitProperty(object oItem)
{
	int nType = GetBaseItemType(oItem);
	if (nType == BASE_ITEM_ARMOR || nType == BASE_ITEM_CREATUREITEM)		
	{		
		if (!GetLocalInt(oItem, H2_ADDED_ONHITPROPERTY))
		{
			itemproperty ip = ItemPropertyOnHitCastSpell(120, 1);
			AddItemProperty(DURATION_TYPE_PERMANENT, ip, oItem);
			SetLocalInt(oItem, H2_ADDED_ONHITPROPERTY, TRUE);		
		}				
	}
}

void h2_RemoveAddedOnHitProperty(object oItem)
{
	if (GetLocalInt(oItem, H2_ADDED_ONHITPROPERTY))
	{
		itemproperty ip = GetFirstItemProperty(oItem);
		while (GetIsItemPropertyValid(ip))
		{
			int iptype = GetItemPropertyType(ip);
			int ipsubtype = GetItemPropertySubType(ip);
			if (iptype == ITEM_PROPERTY_ONHITCASTSPELL && ipsubtype == 120)
				break;
			ip = GetNextItemProperty(oItem);
		}		
		RemoveItemProperty(oItem, ip);
		DeleteLocalInt(oItem, H2_ADDED_ONHITPROPERTY);		
	}
}

//Adds a creature skin to oPC is one does not already exist,
//Added the OnHit: PlayerStruck itemproperty to the skin.
void h2_AddPlayerSkin(object oPC)
{
	object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
	if (!GetIsObjectValid(oSkin))
	{
		oSkin = CreateItemOnObject("x2_it_emptyskin", oPC, 1, "HCR2_SKIN", FALSE);
		AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));		
	}
	h2_AddOnHitProperty(oSkin);
}


//end player equip/unequip functions