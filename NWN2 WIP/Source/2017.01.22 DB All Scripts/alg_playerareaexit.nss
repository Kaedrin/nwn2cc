//:: bar_onareaexit 

//:: On Area Exit script: 

//:: - Cleans up loot bags, encounter creatures, dead creatures 

//:: and hostile creatures when last char leaves the area. 

//:: - Does not kill friendly merchants and NPCs, suitable for 

//:: all areas in most mods. 

//:: - New version introduces delay, players can reenter to 

//:: prevent clean up with in two minutes. 

//:: Requires one placable in area to latch on to. 

//:: Trash object additions: 

//:: From code by: Scott Thorne 

//:: <a target="_blank" href="http://nwvault.ign.com/View.php?view=Scripts.Detail&id=1971">Link</a> 

//:: Modified by: Paul Baines (Bainsy) -2003/04/27 

//:: Modified by: Chris Morris - 2003/04/28 

//:: Modified by: Bar Fubaz - 2008/05/16 

//:: Modified by: Bar Fubaz - 2008/05/20 - Rewrote for DelayedAction 

/************************************************* 

* Modified from simple loot bag elimination to 

* critter clean up, converted to NWN2 and bugfixes. 

* Added GetIsPC check to TrashObject just in case. 

* Added locking to prevent more than one cleanup 

* happening at once. 

* Added GetIsPC Check to avoid firing on critter 

* death. 

* Added delayed action, attached to placable in area 

* with two minute delay. 

* - Bar 

**************************************************/ 

void TrashObject(object oItem) 

{ 

	if ( ! GetIsPC(oItem) ) { 

		if(GetHasInventory(oItem) == FALSE){ 

			DestroyObject(oItem); 

		}
		else{ 

			object oItem2 = GetFirstItemInInventory(oItem); 

			if(GetTag(oItem2)=="hcr2_corpsetoken")
			{
				//do nothing
			}
			else
			{
				while(GetIsObjectValid(oItem2)){ 
	
					TrashObject(oItem2); // Note: Recursion. 
	
					oItem2 = GetNextItemInInventory(oItem); 
				
				}//end while 
	
				DestroyObject(oItem); 
			}

		}//end if/else 

	} 

}//end TrashObject(object oItem) 



void ActionCleanCheck() 

{ 

// Log character transition. 

PrintString( "bar_onareaexit: ActionCleanCheck" ); 



//:: Trash object additions: 

int iLock = GetGlobalInt("CleanUpLock"); 

if ( iLock == 0 ) { 

SetGlobalInt("CleanUpLock", 1); // Only allows one clean up at a time. 

PrintString( "bar_onareaexit: ActionCleanCheck: Inside lock" ); 



//declarations 

object oArea = GetArea(OBJECT_SELF); 

int nPCinArea = FALSE; 

object oPCIterator = GetFirstPC(); 



while (GetIsObjectValid(oPCIterator) == TRUE){ 

if (GetArea(oPCIterator) == oArea){ 

nPCinArea = TRUE; 

break; // We don't actually care how many, just if there is one. 

} 

oPCIterator = GetNextPC(); 

}//end while checking for PCinArea 



if (nPCinArea == FALSE){ 

object oItem = GetFirstObjectInArea(); 

PrintString( "bar_onareaexit: ActionCleanCheck: Cleaning" ); 

while(GetIsObjectValid(oItem)){ 

int iType= GetObjectType(oItem); 

// Debug: Explore info on objects and types. 

// PrintString( "bar_onareaexit: " + GetName(oItem) + "((" + GetTag(oItem) + ")): " + IntToString(iType) ); 

if( //(iType == OBJECT_TYPE_PLACEABLE && GetTag(oItem) == "BodyBag") 
(GetStringLowerCase(GetName(oItem)) == "remains")
|| (iType == OBJECT_TYPE_CREATURE && GetIsEncounterCreature(oItem)) 

//|| (iType == OBJECT_TYPE_CREATURE && GetIsDead(oItem)) 

|| (iType == OBJECT_TYPE_CREATURE && GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oItem) == 0) ){ 

// Debug: Log trashing 

PrintString( "bar_onareaexit: Trashing Object " + GetName(oItem) + "((" + GetTag(oItem) + ")): " + IntToString(iType) ); 

TrashObject(oItem); 

}//end inner if 

oItem = GetNextObjectInArea(); 

}//end while 

}//end if PCinArea check 



SetGlobalInt("CleanUpLock", 0); 

} 

} 



void ActionDelayedCleanCheck(){ 

PrintString( "bar_onareaexit: ActionDelayedCleanCheck: Assigning delayed command." ); 

DelayCommand(120.0, ActionCleanCheck() ); 

} 





void main() 

{ 

object oPC = GetExitingObject(); 

if(GetIsDM(oPC))
	return;
	
object oArea = GetArea(oPC); 



if ( GetIsPC(oPC) ) { // Make sure is a PC. 

// Log character transition. 

PrintString( GetName(oPC) + "((" + GetPCPlayerName(oPC) + ")) exiting area " + GetName(OBJECT_SELF) ); 



// Hackery: Grab an object to hang the action on... 

// - Area would have been best but seems not to work. 

// - PC may not be around if he's quitting the mod. 

object oItem = GetFirstObjectInArea(); 

while(GetIsObjectValid(oItem)){ 

int iType= GetObjectType(oItem); 

if ( iType == OBJECT_TYPE_PLACEABLE && GetTag(oItem) != "BodyBag" ) 

break; 

oItem = GetNextObjectInArea(); 

}//end while 

if ( GetIsObjectValid(oItem) ) { 

AssignCommand(oItem, ClearAllActions()); // clear any queued clean up actions. 

AssignCommand(oItem, ActionDelayedCleanCheck()); 

} else { 

PrintString( "bar_onareaexit: WARNING: No placable objects to assign a command to." ); 

} 

} 

} 