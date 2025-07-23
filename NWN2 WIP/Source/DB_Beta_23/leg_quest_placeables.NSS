/*

    Script:			On Left Click script for interactive placeables for quests.  This handles looting quest 
					items, examining, destroying and all that stuff.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
					12/23/2011 - 1.01 MV - Bug fix to resolve duplicate retries on mob drops
	
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_include"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN INCLUDE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Find out who just touched me.
	object oPC = GetPlaceableLastClickedBy();
	string sName = GetName(OBJECT_SELF);

	// If the Quest plugin isn't active, just exit.
	if (!GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		return;
				
	// If we are a PC
	if (GetIsPC(oPC))
	{
		// Looks a PC just touched me.  Better check for range and quests.
		if (GetDistanceToObject(oPC) > 3.0)
		{
			LEG_COMMON_DisplayInfoBox(oPC, "You are too far away.", 0);
			AssignCommand(oPC, ClearAllActions());
			return;
		}

		// Get the persistant Table Loot for placeables
		string sTableID = LEG_COMMON_GetPCTable(oPC, "placeables");
		string sQuestTableID = LEG_COMMON_GetPCTable(oPC, "quests");
		
		// Check to see if the PC has already attempted on me since the server last reset.
		string sPCCDKey = LEG_COMMON_GetPCTable(oPC, "cdkey");
		
		/*if(GetLocalInt(OBJECT_SELF, sPCCDKey))
		{
			// Well this is dumb.  It would seem that if you close the inventory of a placeable that
			// has an on used event script, the on-used event fires again.  So we have to put this little
			// piece of code in so we don't get dumb messages appearing when the inventory is closed.
			if (GetHasInventory(OBJECT_SELF) && GetLocalInt(OBJECT_SELF, "LEG_ClickedOn" + sPCCDKey))
			{
				SetLocalInt(OBJECT_SELF, "LEG_ClickedOn" + sPCCDKey, FALSE);
				return;
			}
			else
			{
				LEG_COMMON_DisplayInfoBox(oPC, "You have already used this.", 0);
				SetLocalInt(OBJECT_SELF, "LEG_ClickedOn" + sPCCDKey, TRUE);
				return;
			}
		}

		// Let the placeable know the PC has clicked on it.
		SetLocalInt(OBJECT_SELF, "LEG_ClickedOn" + sPCCDKey, TRUE);
		SetLocalInt(OBJECT_SELF, sPCCDKey, TRUE);
		*/
		
		// In the event this is an instance or the server reset, let's check and see if 
		// this is a persistent placeable.
		location lLocation = GetLocation(OBJECT_SELF);
    	object oArea = GetAreaFromLocation(lLocation);
    	vector vPosition = GetPositionFromLocation(lLocation);
    	float fOrientation = GetFacingFromLocation(lLocation);
        string sValueID = GetTag(oArea) + "#" + FloatToString(vPosition.x) + "#" + FloatToString(vPosition.y) + "#" + FloatToString(vPosition.z) + "#" + FloatToString(fOrientation);
		sValueID = GetStringLeft(sValueID, 63);

		// Let's get the time it takes to loot this thing.
		int iTime = GetLocalInt(OBJECT_SELF, "LEG_QUEST_UseTime");
		if (iTime == 0)
			iTime = 10;

		// Setup some variables.		
		int iTotalQuests = GetLocalInt(OBJECT_SELF, "LEG_QUEST_TotalQuests");
		int iCount, iMin, iMax, iChance, iSpawnQty, iAdvanceNPC, iProgBarOn;
		int iMultiplyer = 0;
		string sQuestCounter, sAction, sItemForPC, sDiscovery, sQuestID;
		
		// Cycle through this placeables quests
		for (iCount = 1; iCount <= iTotalQuests; iCount++)
		{
			//SpeakString("Total Quests: " + IntToString(iTotalQuests) + ", Quest #: " + IntToString(iCount), TALKVOLUME_SHOUT);
			// For each quest, let's get the objective this thing is for and the NPC that it belongs to.
			sQuestCounter = IntToString(iCount);
			sQuestID = GetLocalString(OBJECT_SELF, "LEG_QUEST_QuestID_" + sQuestCounter);
			int iObjective = GetLocalInt(OBJECT_SELF, "LEG_QUEST_IsObjective_" + sQuestCounter);
			int iNPCObjective = GetLocalInt(OBJECT_SELF, "LEG_QUEST_ObjectiveFor_" + sQuestCounter);

			// Is this a mob drop placeable?
			if (!GetLocalInt(OBJECT_SELF, "MOBDeath"))
			{		
				// See if the PC already searched this via persistence
				if (GetPersistentInt(oPC, sQuestID + "_" + sValueID, sTableID))
				{
					LEG_COMMON_DisplayInfoBox(oPC, "You have already used this.");
					return;
				}
			}
			else
			{
				// Can we check it?
				if (GetLocalInt(OBJECT_SELF, GetPCPublicCDKey(oPC)))
				{
					LEG_COMMON_DisplayInfoBox(oPC, "You have already used this.");
					return;
				}
			}
			
			
			// If this is a Kill type quest vs. a loot type quest objective on a mob death, then we need to skip
			// the next section. 
			if (GetLocalString(OBJECT_SELF, "LEG_QUEST_Action_" + sQuestCounter) != "")
			{
		
				// Is the player on the quest and are they on this step?
				int iPlayerNPC = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");				
				int iPlayerOBJCount = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective));
				if (iPlayerNPC == iNPCObjective)
				{
					// Is my Objective Owner reluctant and has the PC gotten passed that little issue?
					int iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iNPCObjective) + "_ReluctantPassed");
					
					if (iReluctantPassed == 0)
					{
						return;
					}
				
					// If this quest requires the PC has a special tool to extract something, then skip it because this was
					// called via the onused event.
					if (!GetLocalInt(OBJECT_SELF, "LEG_QUEST_ItemToolTarget_" + sQuestCounter))
					{
						// Ok, time to figure out what we're actually supposed to do for this quest.
						sAction = GetLocalString(OBJECT_SELF, "LEG_QUEST_Action_" + sQuestCounter);
	
						if ( sAction == "Searching")
						{
							// If we are configured for "Searching", then that means we may have an item to give the player.
							// Remember, this code is for both standalone placeables and the placeable object used by
							// mob drops.
							int iNeeds = GetLocalInt(OBJECT_SELF, "LEG_QUEST_PCNeeds_" + sQuestCounter);
							int iPCHas = iPlayerOBJCount;
							if (iNeeds > iPCHas)
							{
								//SpeakString("Quest #: " + IntToString(iCount) + " PC Has: " + IntToString(iPCHas) + ", PC Needs: " + IntToString(iNeeds), TALKVOLUME_SHOUT);
	
								// Looks like the PC needs me.
								iPCHas++;
						
								// Looks like the PC needs me, lets start the timer.
								string sItemForPC = GetLocalString(OBJECT_SELF, "LEG_QUEST_Item_" + sQuestCounter);
								string sFool = GetLocalString(OBJECT_SELF, "LEG_QUEST_FakePlaceable_" + sQuestCounter);
								if (sFool != "")
								{
									// Looks like the PC got hoodwinked.
									if (!iProgBarOn)
									{
										// Display our progress bar.
										iProgBarOn = TRUE;
										LEG_COMMON_ProgBar(oPC, iTime, sAction + " " + sName, VFX_DUR_IOUN_STONE_INT, ANIMATION_LOOPING_KNEELIDLE);
									}
									
									// Show the PC a message about what sort of item they found.. which in this case is a big 
									// fat nothing because.. yes.. this is a fake placeable!  HAR HAR HAR.
									DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_COMMON_DisplayInfoBox(oPC, "Found " + sFool));
								}
								else
								{
									// Now that we've had our fun with the fake placeable, let's get on to the real goods.  Is there
									// an item in here for the PC to find?
									iMin = GetLocalInt(OBJECT_SELF, "LEG_QUEST_MinQty_" + sQuestCounter);
									iMax = GetLocalInt(OBJECT_SELF, "LEG_QUEST_MaxQty_" + sQuestCounter);
									iChance = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Chance_" + sQuestCounter);
									iAdvanceNPC = GetLocalInt(OBJECT_SELF, "LEG_QUEST_NPCAdvance_" + sQuestCounter);
									
									// Set some defaults in case we didn't bother entering any.
									if (iMin == 0)
										iMin = 1;
									if (iMax == 0)
										iMax = 1;
									if (iChance == 0)
										iChance = 100;
									
									// Now roll and lets see if we are successful.
									if (Random(100) + 1 <= iChance)
									{
										// Yes, we did it!  Let's do some item gathering.
										iSpawnQty = Random(iMax - iMin + 1) + iMin;
										if (!iProgBarOn)
										{
											// Display out progress bar.  We don't like to waste a PC's time if there is no item
											// on it to be had.  Let them move on.
											iProgBarOn = TRUE;
											LEG_COMMON_ProgBar(oPC, iTime, sAction + " " + sName, VFX_DUR_IOUN_STONE_INT, ANIMATION_LOOPING_KNEELIDLE);
										}
										iMultiplyer++;
										
										// Now create the actual item and give credit!
										DelayCommand(IntToFloat(iTime + ((iMultiplyer - 1) * 6)), LEG_QUEST_QuestCreditItem(sItemForPC, oPC, sQuestID, iObjective, 1, iSpawnQty, 1, iPCHas, iNeeds, sValueID, iAdvanceNPC));
										
										// We need to check and see if this is a Lorebook Quest and if this Looted Item
										// will advance it and pop-up the GUI
										int iQuestType = GetLocalInt(oPC, "QuestID_" + sQuestID + "_Type");
										if (iQuestType == 1 && iPCHas >= iNeeds)
										{
											// This is a lore book and we have completed a Kill objective
											// Pop up the continue GUI if there is another NPC to be had.
											// Otherwise pop up the finish GUI
											int iQuestFinisher = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Finisher_" + sQuestCounter);
											iCount = iTotalQuests;
											if (iQuestFinisher)
												DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iPlayerNPC, sQuestID));
											else
											{
												DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iAdvanceNPC, sQuestID, iAdvanceNPC));
												SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1, 0, sQuestTableID);
												SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1);
											}
										}
									}
									else
									{
										// If we failed our chance to have an item spawn, then let's notify the PC
										// they are SOL.
										if (iCount == iTotalQuests && iProgBarOn == FALSE)
										{
											LEG_COMMON_DisplayInfoBox(oPC, "Nothing Interesting", 0);
											
											// Don't let them check again on Mob Drops!
											if (GetLocalInt(OBJECT_SELF, "MOBDeath"))
												SetLocalInt(OBJECT_SELF, GetPCPublicCDKey(oPC), TRUE);
											
											return;
											
										}
									}
								}
							}
							else
							{
								// If the PC has all they need of this item but hasn't turned the quest in yet
								// or still need things from other objectives, we'll do a generic nothing interesting.
								if (iCount == iTotalQuests && iProgBarOn == FALSE)
								{
									LEG_COMMON_DisplayInfoBox(oPC, "Nothing Interesting", 0);
									return;
								}
							}
						}
						else if (sAction == "Placing")
						{
							// Moving right along, let's deal with this placeable if it happens to have an action of 
							// Placing.  This is where instead of getting an item, we lose an item.
							int iNeeds = GetLocalInt(OBJECT_SELF, "LEG_QUEST_PCNeeds_" + sQuestCounter);
							int iEffectID = GetLocalInt(OBJECT_SELF, "LEG_QUEST_PlaceEffect_" + sQuestCounter);
							int iPCHas = iPlayerOBJCount;
							if (iNeeds > iPCHas)
							{
								// Looks like the PC needs me.
								iPCHas++;
						
								// Get the next NPC (useful for Lore Books)
								iAdvanceNPC = GetLocalInt(OBJECT_SELF, "LEG_QUEST_NPCAdvance_" + sQuestCounter);
								
								// Looks like the PC needs me, lets start the timer.
								string sItemForPC = GetLocalString(OBJECT_SELF, "LEG_QUEST_Item_" + sQuestCounter);
								sName = LEG_COMMON_GetItemName(oPC, sItemForPC);
								if (sName == "" || sName == "Invalid Item")
								{
									// Ruh-roh.. the PC seems to have lost the item they need.
									LEG_COMMON_DisplayInfoBox(oPC, "Missing Required Item.");
									return;
								}
								
								// All is well and let's animate the progress bar.
								if (!iProgBarOn)
								{
									iProgBarOn = TRUE;
									LEG_COMMON_ProgBar(oPC, iTime, sAction + " " + sName, VFX_DUR_IOUN_STONE_INT, ANIMATION_LOOPING_KNEELIDLE);
								}
								
								// Deploy the item and give credit!
								DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_QuestCreditPlaceItem(sItemForPC, oPC, sQuestID, iObjective, 1, iSpawnQty, 1, iPCHas, iNeeds, iEffectID, sValueID));
								
								// We need to check and see if this is a Lorebook Quest and if this Looted Item 
								// will advance it and pop-up the GUI
								int iQuestType = GetLocalInt(oPC, "QuestID_" + sQuestID + "_Type");
								if (iQuestType == 1 && iPCHas >= iNeeds)
								{
									// This is a lore book and we have completed a Kill objective
									// Pop up the continue GUI if there is another NPC to be had.
									// Otherwise pop up the finish GUI
									int iQuestFinisher = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Finisher_" + sQuestCounter);
									iCount = iTotalQuests;
									if (iQuestFinisher)
										DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iPlayerNPC, sQuestID));
									else
									{
										DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iAdvanceNPC, sQuestID, iAdvanceNPC));
										SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1, 0, sQuestTableID);
										SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1);
									}
								}
							}
							else
							{
								// If the PC has placed all the items they needed to but hasn't turned the quest in yet
								// or still need things from other objectives, we'll do a generic nothing interesting.
								if (iCount == iTotalQuests && iProgBarOn == FALSE)
								{
									LEG_COMMON_DisplayInfoBox(oPC, "Nothing Interesting", 0);
									return;
								}
							}
						}
						else if (sAction == "Destroying")
						{
							// Continuing our placeable object fun, it looks like this time we get to destroy the
							// darn thing.  This usually incorporates part of the SPAWN plugin.  We also can accomodate
							// if the PC requires an item to destroy the placeable.
							int iNeeds = GetLocalInt(OBJECT_SELF, "LEG_QUEST_PCNeeds_" + sQuestCounter);
							string sItemForPC = GetLocalString(OBJECT_SELF, "LEG_QUEST_Item_" + sQuestCounter);
		
							// Check and see if the PC needs to do this still.
							int iPCHas = iPlayerOBJCount;
							if (iNeeds > iPCHas)
							{
							
								// Get the next NPC (useful for Lore Books)
								iAdvanceNPC = GetLocalInt(OBJECT_SELF, "LEG_QUEST_NPCAdvance_" + sQuestCounter);
							
								// Make sure PC has the item required to destroy if one is required.
								if (sItemForPC != "")
								{
									string sItemName = LEG_COMMON_GetItemName(oPC, sItemForPC);	
									if (sItemName == "" || sItemName == "Invalid Item")
									{
										// Ruh-roh.. the PC seems to have lost the item they need.
										LEG_COMMON_DisplayInfoBox(oPC, "Missing Required Item.");
										return;
									}
								}
								
								// Make sure than only one person can destroy at a time.
								if (GetLocalInt(OBJECT_SELF, "DestroyActive"))
								{
									LEG_COMMON_DisplayInfoBox(oPC, "Someone else is Destroying this.", 0);
									return;
								}
								else
									SetLocalInt(OBJECT_SELF, "DestroyActive", TRUE);
									
								// Looks like the PC needs me.
								iPCHas++;
						
								// Looks like the PC needs me, lets start the timer.
								sName = GetName(OBJECT_SELF);
								if (!iProgBarOn)
								{
									iProgBarOn = TRUE;
									LEG_COMMON_ProgBar(oPC, iTime, sAction + " " + sName, VFX_DUR_IOUN_STONE_INT, ANIMATION_LOOPING_KNEELIDLE);
								}
								
								// And we've destroyed it, so let's give some credit.
								DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_QuestCreditDestroyPlaceable(sItemForPC, oPC, sQuestID, iObjective, 1, iSpawnQty, 1, iPCHas, iNeeds, sValueID));
								
								// We need to check and see if this is a Lorebook Quest and if this Looted Item 
								// will advance it and pop-up the GUI
								int iQuestType = GetLocalInt(oPC, "QuestID_" + sQuestID + "_Type");
								if (iQuestType == 1 && iPCHas >= iNeeds)
								{
									// This is a lore book and we have completed a Kill objective
									// Pop up the continue GUI if there is another NPC to be had.
									// Otherwise pop up the finish GUI
									int iQuestFinisher = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Finisher_" + sQuestCounter);
									iCount = iTotalQuests;
									if (iQuestFinisher)
										DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iPlayerNPC, sQuestID));
									else
									{
										DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iAdvanceNPC, sQuestID, iAdvanceNPC));
										SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1, 0, sQuestTableID);
										SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1);
									}
								}
							}
							else
							{
								// If the PC has destroyed all they needed but hasn't turned the quest in yet
								// or still need things from other objectives, we'll do a generic nothing interesting.
								if (iCount == iTotalQuests && iProgBarOn == FALSE)
								{
									LEG_COMMON_DisplayInfoBox(oPC, "Nothing Interesting", 0);
									return;
								}	
							}
						}					
						else if (sAction == "Examining")
						{
							// NEXT!  The next action we can perform on a placeable object is to simple Examine it.  Handy for when
							// you need to go look for corpses LOL.
							int iNeeds = GetLocalInt(OBJECT_SELF, "LEG_QUEST_PCNeeds_" + sQuestCounter);
							int iPCHas = iPlayerOBJCount;
							if (iNeeds > iPCHas)
							{
								// Looks like the PC needs me.
								iPCHas++;
						
								// Looks like the PC needs me, lets start the timer.
								string sFool = GetLocalString(OBJECT_SELF, "LEG_QUEST_FakePlaceable_" + sQuestCounter);
								if (sFool != "")
								{
									// Looks like the PC got hoodwinked.
									if (!iProgBarOn)
									{
										// Display our progress bar.
										iProgBarOn = TRUE;
										LEG_COMMON_ProgBar(oPC, iTime, sAction + " " + sName, VFX_DUR_IOUN_STONE_INT, ANIMATION_LOOPING_KNEELIDLE);
									}
									
									// Show the PC a message about what sort of item they found.. which in this case is a big 
									// fat nothing because.. yes.. this is a fake placeable!  HAR HAR HAR.
									DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_COMMON_DisplayInfoBox(oPC, "Found " + sFool));
								}
								else
								{
									// Because we are not placing an item or destorying something we want to have a brief description
									// of what we discovererd when we examined the placeable.  Let's get that text.
									sDiscovery = GetLocalString(OBJECT_SELF, "LEG_QUEST_ExaminedMsg_" + sQuestCounter);
									
									// Get the next NPC (useful for Lore Books)
									iAdvanceNPC = GetLocalInt(OBJECT_SELF, "LEG_QUEST_NPCAdvance_" + sQuestCounter);
									
									// Start the counter and display the progress bar
									if (!iProgBarOn)
									{
										iProgBarOn = TRUE;
										LEG_COMMON_ProgBar(oPC, iTime, sAction + " " + sName, VFX_DUR_IOUN_STONE_INT, ANIMATION_LOOPING_KNEELIDLE);
									}
									
									// Give credit for examining.
									DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_QuestCreditExaminePlaceable(sDiscovery, oPC, sQuestID, iObjective, iPCHas, iNeeds, sValueID));
									
									// We need to check and see if this is a Lorebook Quest and if this Looted Item 
									// will advance it and pop-up the GUI
									int iQuestType = GetLocalInt(oPC, "QuestID_" + sQuestID + "_Type");
									if (iQuestType == 1 && iPCHas >= iNeeds)
									{
										// This is a lore book and we have completed a Kill objective
										// Pop up the continue GUI if there is another NPC to be had.
										// Otherwise pop up the finish GUI
										int iQuestFinisher = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Finisher_" + sQuestCounter);
										iCount = iTotalQuests;
										if (iQuestFinisher)
											DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iPlayerNPC, sQuestID));
										else
										{
											DelayCommand(IntToFloat(iTime + ((iCount - 1) * 6)), LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iAdvanceNPC, sQuestID, iAdvanceNPC));
											SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1, 0, sQuestTableID);
											SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1);
										}
									}
								}
							}
							else
							{
								// If the PC has all examined everything but hasn't turned the quest in yet
								// or still need things from other objectives, we'll do a generic nothing interesting.
								if (iCount == iTotalQuests && iProgBarOn == FALSE)
								{
									LEG_COMMON_DisplayInfoBox(oPC, "Nothing Interesting", 0);
									return;
								}	
							}
						}
						// We could put an ELSE IF right here if we have more actions in the future.
					}
				}
			}
		}

		// If we never had a progress bar and we've gone through all the quests then display
		// a message.		
		if (iCount >= iTotalQuests && iProgBarOn == FALSE)
		{
			// We will allow the PC to re-use this placeable if they haven't
			// had a quest objective for this.
			LEG_COMMON_DisplayInfoBox(oPC, "Nothing Interesting", 0);
			if (GetLocalInt(OBJECT_SELF, "MOBDeath"))
				SetLocalInt(OBJECT_SELF, GetPCPublicCDKey(oPC), TRUE);

			// Is this a mob drop placeable?  If so, we don't care about the DB persistence.
			else 
				SetPersistentInt(oPC, sValueID, FALSE, 0, sTableID);
			return;
		}
	}
}