/*

    Script:			Popup the Quest Box.  Called from the generic quest conversation.
	Version:		1.00
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
	
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_include"
#include "nwnx_sql"


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Fist let's see who is talking to me.  Enhance this so we can call this script from anything and not just
	// a conversation.
	object oNPC = OBJECT_SELF;
	object oPC = GetLastSpeaker();

	// The usual, am I a PC?  If not.. punt.
	if (!GetIsPC(oPC))
	{
		oPC = GetLocalObject(OBJECT_SELF, "LASTPC");
		if (!GetIsPC(oPC))
			return;
	}

	// Am I currently wandering along my path as a result of an escort quest?  If so, don't 
	// try interupting me with idle chatter!  I have places to be!
	if (GetLocalInt(OBJECT_SELF, "OnEscort") == 1)
		return;

	// Ok, now we're getting somewhere.  Let's do a nice hello.
	PlayVoiceChat(VOICE_CHAT_HELLO, oNPC);
	
	// Store this NPC object on the player in the event we need it for some reason (duh, we will).
	SetLocalObject(oPC, "QNPC", oNPC);
	
	// Create a name for the table structure for this player.  In this case, we're looking at
	// the "quests" table for this PC.
	string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");

	// Set up some vars.
	int iPlayerStep, iTotalQuests, iCount, iNPCPosition, iNextNPC, iFireOneliner, iQuestStarter, iQuestFinisher, iFirePostLiner, iFireFailure;
	string sQuestID, sRequirement, sQuestStarted, sCount;
	
	//DM MustangSVT added vars
	string sJournal;
	int iJournal;
	
	// Figure out if this NPC has any quests.
	iTotalQuests = GetLocalInt(oNPC, "LEG_QUEST_TotalQuests");
	
	// Loop through each quest and see if the PC is on one.  The PC can only be on
	// one of them at any given time so most NPC's with two quests are chain
	// quests.
	for (iCount=1; iCount<=iTotalQuests; iCount++)
	{
		// Get the string value of the counter so we can use it in *_ variables.
		sCount = IntToString(iCount);
		
		// Grab the Quest ID for this quest.
		sQuestID = GetLocalString(oNPC, "LEG_QUEST_QuestID_" + sCount);
				
		// Mustang addition for persistence with Dalelands
		sJournal = "LegendsQuest" + sQuestID;
		iJournal = StringToInt(sQuestID);
		
		if(GetPersistentInt(oPC, sJournal) == iJournal)
		{
			string sOneLiner = LEG_QUEST_GetPostOneLiner(GetResRef(oNPC));
			AssignCommand(oNPC, ActionSpeakString(sOneLiner));
			return;
		}
		// End persistence with Dalelands
				
		// See where the Player stands in this quest.
		iPlayerStep = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");
		
		// Find out which position along the quest line this NPC is.
		iNPCPosition = GetLocalInt(oNPC, "LEG_QUEST_NPCID_" + sCount);
		
		// Find out who the Next NPC is going to be (if there is one)
		iNextNPC = GetLocalInt(oNPC, "LEG_QUEST_NextNPC_" + sCount);
		
		// Find out if there is a previous requirement before an offer can take place.
		sRequirement = GetLocalString(oNPC, "LEG_QUEST_Requirement_" + sCount);
		sQuestStarted = GetLocalString(oNPC, "LEG_QUEST_QuestStarted_" + sCount);

		// Am I the quest starter?
		int iQuestStarter = GetLocalInt(oNPC, "LEG_QUEST_Starter_" + sCount);
		
		// Am I the quest finisher?
		int iQuestFinisher = GetLocalInt(oNPC, "LEG_QUEST_Finisher_" + sCount);
		
		// Am I reluctant?
		int iReluctance = GetLocalInt(oNPC, "LEG_QUEST_Reluctant_" + sCount);
		int iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iPlayerStep) + "_ReluctantPassed");
		
		// Before I move along on a quest, I must see if talking to me is actually an
		// objective for the player.
		int iTalktoNPC = GetLocalInt(oNPC, "LEG_QUEST_IsObjective_" + sCount);
		int iNPCObjective = GetLocalInt(oNPC, "LEG_QUEST_ObjectiveFor_" + sCount);

		// Check to see if the PC has completed this quest previously and if they are allowed to repeat.
		int iTimeSystem = GetLocalInt(GetModule(), "LEG_TIME_ACTIVE");
		if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC") == 998)
		{
			int iPCStamp = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NextRepeat");
			if (iPCStamp == 0 && iTimeSystem == TRUE)
				iPCStamp = GetPersistentInt(oPC, "QuestID_" + sQuestID + "_NextRepeat", sTableID);
			
			// If the timer has not passed, then fire the oneliner.
			if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NextRepeat") > LEG_COMMON_TimeStamp())
			{
				iFireOneliner = TRUE;
			}
			else
			{
				iPlayerStep = 0;
				SetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC", 0);
				SetPersistentInt(oPC, "QuestID_" + sQuestID + "_NPC", 0, 0, sTableID);
			}
		}
				
		if (iTalktoNPC && iPlayerStep == iNPCObjective)
		{
			// Looks like I AM an objective.  Does the player need this objective?
			// The iTalktoNPC is actually an objective Number from 1-10
			// We pull that objective from the row for the NPC that asked us to talk to this guy
			// and if it matches this NPC's ID, then we advance the Player's Step.
			// If the player's step is advanced, the original guy will always spew his
			// oneliner, otherwise, the original guy will fire a continue until we talk to this
			// NPC.
			SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iPlayerStep));
			SQLFetch();
			int iObjective = StringToInt(SQLGetData(13 + iTalktoNPC));

			if (iObjective == iNPCPosition)
			{
				// Check and see if this NPC requires all OTHER NPC -1 objectives are complete first.
				// This is useful if NPC #1 says, kill me a mob, THEN talk to NPC #2.  It will cause
				// NPC #2 NOT to talk to the player until the first and any OTHER objectives are
				// complete.
				// iTalktoNPC is the objective ID (1-10) this NPC is, so we don't mind if this
				// one is not complete.  We do this by calling a special CheckObjectives function
				// passing the one objective (the NPC) that we don't need to come back as TRUE.  As
				// long as the rest are True, we are good to proceed, otherwise we simply skip this section.
				if ((GetLocalInt(oNPC, "LEG_QUEST_OtherObjectivesDone_" + sCount) && LEG_QUEST_CheckOtherObjectives(oPC, sQuestID, iPlayerStep, iTalktoNPC)) || !GetLocalInt(oNPC, "LEG_QUEST_OtherObjectivesDone_" + sCount))
				{
					iPlayerStep = iNPCPosition;
					SetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC", iPlayerStep);
					SetPersistentInt(oPC, "QuestID_" + sQuestID + "_NPC", iPlayerStep, 0, sTableID);
				
					// We've changed NPC's.  Let's clean up my objectives.  Moving from one NPC
					// to another can only EVER be one objective.  You can't have multiple objectives
					// when one NPC sends you to talk to another.
					// If you are a return customer from talking to another NPC and this NPC previously
					// had objectives, then we need to run an auto-complete.
					if (GetLocalInt(oNPC, "LEG_QUEST_CompleteOldObjectives_" + sCount))
						LEG_QUEST_CompleteObjectives(oPC, sQuestID, iPlayerStep);
					else
						LEG_QUEST_ClearObjectives(oPC, sQuestID, sTableID);
				}
			}
		}

		// Check to see if the PC has messed things up by failing a skill check and now has to wait.
		if (iReluctance)
		{
			int iPCStamp = GetLocalInt(oPC, "QuestID_" + sQuestID + "_FailTime");
			if (iPCStamp == 0 && iTimeSystem == TRUE)
				iPCStamp = GetPersistentInt(oPC, "QuestID_" + sQuestID + "_FailTime", sTableID);
			
			// If the timer has not passed, then fire the failure.
			if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_FailTime") > LEG_COMMON_TimeStamp())
			{
				iFireFailure = TRUE;
			}
			else
			{
				SetLocalInt(oPC, "QuestID_" + sQuestID + "_FailTime", 0);
				SetPersistentInt(oPC, "QuestID_" + sQuestID + "_FailTime", 0, 0, sTableID);
			}
		}
		
		if (iFireFailure)
		{
			// We've had a failure in skill so let's wait and inform.
			string sFailSkillMessage;
			SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_skills` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iPlayerStep) + "';");
			while(SQLFetch())
			{
				sFailSkillMessage = SQLGetData(5);
			}
			AssignCommand(oNPC, ActionSpeakString(sFailSkillMessage));
			return;
		}		
		
		if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC") != 999)
		{
			// I have not completed a quest this guys has.
			iFirePostLiner = FALSE;
			
			if (iFireOneliner == FALSE)
			{
				// Let's see where the PC is with respect to this quest.
				if ((GetLocalInt(oPC, "QuestID_" + sRequirement + "_NPC") == 999 || sRequirement == "") && (GetLocalInt(oPC, "QuestID_" + sQuestStarted + "_NPC") != 0 || sQuestStarted == ""))
				{
					// If the player is on step 0, they do not have the quest, however this NPC
					// may not be the quest starting person, just a member of the quest, so how
					// do we tell if this NPC is the starter?
					if (iPlayerStep == 0 && iQuestStarter)
					{
						iFireOneliner = FALSE;
						iCount = iTotalQuests;
						LEG_QUEST_FireQuestGUI("leg_quest_offer", "leg_quest_offer.xml", oPC, iNPCPosition, sQuestID);
						SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iNPCPosition) + "_ReluctantPassed", 1, 0, sTableID);
						SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iNPCPosition) + "_ReluctantPassed", 1);
					}
					else if (iPlayerStep == iNPCPosition)
					{
						iFireOneliner = FALSE;
						// Looks like you're already on this quest and you need to talk to this NPC
						// But do you have the objectives complete?
						// There can be 10 objectives stored in the database.  if the PC has all 10, then
						// we can show the Finish Box.  If not, we show the continue Box.
						
						// Note, NPC # 999 is always the last one in the quest.  Anyone other NPC in the quest chain
						// will always pop up a continue Box even if objectives are complete.  The key is that
						// if the player completed the objectives, then the quest step advances to the next NPC.
						
						// Now the big IF
						if (!LEG_QUEST_CheckObjectives(oPC, sQuestID, iPlayerStep))
						{
							// The player has not completed ALL the objectives - show the Continue Box without
							// advancement.
							iCount = iTotalQuests;
							int iReluctantPassed;
							
							// Find out if PC has already resolved any reluctance issues.
							if (iReluctance)
							{
								if (!iReluctantPassed)
								{
									// Check database just in case.
									iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iPlayerStep) + "_ReluctantPassed");
								}
							}
							
							if (!iReluctance || iReluctantPassed)
							{
								LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iNPCPosition, sQuestID);
								if (!iReluctance)
								{
									SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iPlayerStep) + "_ReluctantPassed", 1, 0, sTableID);
									SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iPlayerStep) + "_ReluctantPassed", 1);
								}
							}
							else
							{
								SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_skills` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iPlayerStep) + "';");
								SQLFetch();
								int iBribe = StringToInt(SQLGetData(6));
								int iSkill1 = StringToInt(SQLGetData(9));
								int iSkill2 = StringToInt(SQLGetData(10));
								string sGUI, sGUIFile;
								if (iBribe)
								{
									sGUI = "leg_quest_continue_bribe"; 
									sGUIFile = "leg_quest_continue_bribe.xml"; 
								}
								if (iBribe && iSkill1 != -1)
								{
									sGUI = "leg_quest_continue_bribe_skill"; 
									sGUIFile = "leg_quest_continue_bribe_skill.xml"; 
								}
								if (iBribe && iSkill1 != -1 && iSkill2 != -1)
								{
									sGUI = "leg_quest_continue_all"; 
									sGUIFile = "leg_quest_continue_all.xml"; 
								}
								if (!iBribe && iSkill1 != -1 && iSkill2 == -1)
								{
									sGUI = "leg_quest_continue_skill1"; 
									sGUIFile = "leg_quest_continue_skill1.xml"; 
								}	
								if (!iBribe && iSkill1 != -1 && iSkill2 != -1)
								{
									sGUI = "leg_quest_continue_skills"; 
									sGUIFile = "leg_quest_continue_skills.xml"; 
								}
								if (!iBribe && iSkill1 == -1 && iSkill2 == -1)
								{
									sGUI = "leg_quest_continue"; 
									sGUIFile = "leg_quest_continue.xml"; 
								}
								LEG_QUEST_FireQuestGUI(sGUI, sGUIFile, oPC, iNPCPosition, sQuestID);									
							}
							

						}
						else
						{
							// The player has completed all objectives, see if this NPC is the last.  If he/she
							// is, then popup the finish box, otherwise, advance to the next NPC.
							if (iQuestFinisher)
							{
								SetLocalInt(oPC, "LEG_QuestPos", iCount);
								SetPersistentInt(oPC, sJournal, iJournal );
								//SetPersistentInt(oPC, "AlexGnolls", 1005);
								//AddJournalQuestEntry("AlexGnolls", 1005, oPC, FALSE, FALSE, TRUE);
								AddJournalQuestEntry(sJournal, iJournal, oPC, FALSE, FALSE, TRUE);
								iCount = iTotalQuests;
								LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iNPCPosition, sQuestID);
							}	
							else
							{
								iCount = iTotalQuests;
								LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iNPCPosition, sQuestID);
							}
						}
					}
					else
					{
						// I don't equal 0 and am not talking to the quest starter. (I'll match if an objective is to talk to this one
						// from someone elses request.
						// I don't Match this guy's NPC ID
						iFireOneliner = TRUE;
					}
				}
				else
					iFireOneliner = TRUE;	
			}	
		}
		else
			iFirePostLiner = TRUE;
	}
	
	// Fire my oneliner - Player has more questing!
	if (iFireOneliner)
	{
		// Go get my Oneliner from the table because the PC doesn't have what it takes to make
		// my quest box pop!
		string sOneLiner = LEG_QUEST_GetOneLiner(GetResRef(oNPC));
		AssignCommand(oNPC, ActionSpeakString(sOneLiner));
	}
	
	if (iFirePostLiner)
	{
		// Go get my Post Oneliner from the table because the PC has completed all my quests.
		string sOneLiner = LEG_QUEST_GetPostOneLiner(GetResRef(oNPC));
		AssignCommand(oNPC, ActionSpeakString(sOneLiner));
	}
	
}