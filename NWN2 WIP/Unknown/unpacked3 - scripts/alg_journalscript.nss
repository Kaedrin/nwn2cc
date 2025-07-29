#include "ginc_var_ops"
#include "ginc_param_const"
#include "nwnx_sql"

//put on convo action
//:: sQuest = tag name of quest
//:: sEntry = quest entry number completed
//:: 
//int StartingConditional(string sQuest, string sEntry)
void main(string sQuest, string sEntry)
{
	object oPC = GetPCSpeaker();
	object oTarget;	
	object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
	int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");

	//ENSURE DB COMPATIBILITY
	if(GetLocalInt(oPassport, "DBName") == 0)
	{
		string sName = GetName(oPC);
		int nHour = GetTimeHour();
		int nMin = GetTimeMinute();
		int nSec = GetTimeSecond();
		int nTotal = ((nHour * 10000) + (nMin * 100) + (nSec));
		string sTime = IntToString(nTotal);
		SetLocalString(oPassport, "DBName", sName + sTime);
		SetLocalInt(oPassport, "DBName", 1);
	}

	//goblins
  	{   
    	object oPassport = GetItemPossessedBy(oPC,"pc_tracker");   
        if (sEntry == "10")
       	{
          	AddJournalQuestEntry("Goblins",10, oPC, FALSE, FALSE, TRUE);
          	SetPersistentInt(oPC, "Goblins", 10);
            SetLocalInt(oPassport,"Goblins", 10);
            SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");               
            return;   
       	}
      	if (sEntry == "20")
        {
          	AddJournalQuestEntry("Goblins",20, oPC, FALSE, FALSE, TRUE);
            SetPersistentInt(oPC, "Goblins", 20);
            SetLocalInt(oPassport,"Goblins", 20);
               
            return;
      	}
        if (sEntry == "30")
       	{
			object oItem = GetFirstItemInInventory(oPC);
            AddJournalQuestEntry("Goblins",30, oPC, FALSE, FALSE, TRUE);
            SetPersistentInt(oPC, "Goblins", 30);
            SetLocalInt(oPassport,"Goblins", 30);
            GiveXPToCreature(oPC, 1000);
			GiveGoldToCreature(oPC, 1000);
			while (GetIsObjectValid(oItem) == TRUE)
			{
				string sTarget = GetTag(oItem);	
				if (sTarget == "shar_dagger")
				{
					DestroyObject(oItem, 0.0);
				}
               	ExportSingleCharacter(oPC);
               	SetPersistentInt(oPC, "RANK", (nCurrentRank + 2), 0, "RP_Rank");
               	return;         
            }  
		}
		if (sEntry == "35")
       	{
			object oItem = GetFirstItemInInventory(oPC);
            AddJournalQuestEntry("Goblins", 35, oPC, FALSE, FALSE, TRUE);
            SetPersistentInt(oPC, "Goblins", 35);
            SetLocalInt(oPassport,"Goblins", 35);
            GiveXPToCreature(oPC, 1000);
			while (GetIsObjectValid(oItem) == TRUE)
			{
				string sTarget = GetTag(oItem);	
				if (sTarget == "shar_dagger")
				{
					DestroyObject(oItem, 0.0);
				}
               	ExportSingleCharacter(oPC);
               	SetPersistentInt(oPC, "RANK", (nCurrentRank + 2), 0, "RP_Rank");
               	return;         
            }  
		}
		if (sEntry == "40")
       	{
			object oItem = GetFirstItemInInventory(oPC);
            AddJournalQuestEntry("Goblins",40, oPC, FALSE, FALSE, TRUE);
            SetPersistentInt(oPC, "Goblins", 40);
			GiveXPToCreature(oPC, 1000);
            SetLocalInt(oPassport,"Goblins", 40);
            ExportSingleCharacter(oPC);
           	SetPersistentInt(oPC, "RANK", (nCurrentRank + 2), 0, "RP_Rank");
            return;                               							
		}
	}

  //old skull in chef
    if (sEntry == "50")
	{
    	AddJournalQuestEntry("alg_chef",50, oPC, FALSE, FALSE, TRUE);
        SetPersistentInt(oPC, "alg_chef", 50);
        SetLocalInt(oPassport,"alg_chef", 50);
        SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");               
        return;   
	}
	if (sEntry == "60")
	{
    	AddJournalQuestEntry("alg_chef",60, oPC, FALSE, FALSE, TRUE);
       	SetPersistentInt(oPC, "alg_chef", 60);
        SetLocalInt(oPassport,"alg_chef", 60);
        SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");               
        return;   
   	}
    if (sEntry == "70")
	{
     	AddJournalQuestEntry("alg_chef",70, oPC, FALSE, FALSE, TRUE);
       	SetPersistentInt(oPC, "alg_chef", 70);
		GiveXPToCreature(oPC, 500);
		GiveGoldToCreature(oPC, 100);
		SetLocalInt(oPassport,"alg_chef", 70);
        SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");               
        return;   
	}
		//ghost	
	if(sEntry == "80")
	{
		AddJournalQuestEntry("alex_ghost", 80, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "alex_ghost", 80);
		SetLocalInt(oPassport,"alex_ghost", 80);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "90")
	{
		AddJournalQuestEntry("alex_ghost", 90, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "alex_ghost", 90);
		SetLocalInt(oPassport,"alex_ghost", 90);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "100")
	{
		AddJournalQuestEntry("alex_ghost", 100, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "alex_ghost", 100);
		SetLocalInt(oPassport,"alex_ghost", 100);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "110")
	{
		AddJournalQuestEntry("alex_ghost", 110, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "alex_ghost", 110);
		SetLocalInt(oPassport,"alex_ghost", 110);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		GiveXPToCreature(oPC, 1000);
	}
	
	
	//hperv chicken
		if(sEntry == "1")
	{ 
		AddJournalQuestEntry("ellas_uber_chicken",1, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "ellas_uber_chicken", 1);
		SetLocalInt(oPassport,"ellas_uber_chicken", 1);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
		if(sEntry == "3")
	{
		AddJournalQuestEntry("ellas_uber_chicken",3, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "ellas_uber_chicken", 3);
		SetLocalInt(oPassport,"ellas_uber_chicken", 3);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
		if(sEntry == "4")
	{
		AddJournalQuestEntry("ellas_uber_chicken",4, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "ellas_uber_chicken", 4);
		SetLocalInt(oPassport,"ellas_uber_chicken", 4);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		//object oItem = GetObjectByTag("hv_ella_gem",0);
		//object oPC = GetItemPossessor(oItem);
	}
		if(sEntry == "5")
	{
		AddJournalQuestEntry("ellas_uber_chicken",5, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "ellas_uber_chicken", 5);
		SetLocalInt(oPassport,"ellas_uber_chicken", 5);
		GiveXPToCreature(oPC, 500);
		GiveGoldToCreature(oPC, 500);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	//hyperv dryad
	
	if(sEntry == "6")
	{ 
		AddJournalQuestEntry("hv_captured_dryad",6, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_captured_dryad", 6);
		SetLocalInt(oPassport,"hv_captured_dryad", 6);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "7")
	{
		AddJournalQuestEntry("hv_captured_dryad",7, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_captured_dryad", 7);
		SetLocalInt(oPassport,"hv_captured_dryad", 7);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "8")
	{
		AddJournalQuestEntry("hv_captured_dryad",8, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_captured_dryad", 8);
		SetLocalInt(oPassport,"hv_captured_dryad", 8);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		//object oItem = GetObjectByTag("hv_ella_gem",0);
		//object oPC = GetItemPossessor(oItem);
	}
	if(sEntry == "9")
	{
		AddJournalQuestEntry("hv_captured_dryad",9, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_captured_dryad", 9);
		SetLocalInt(oPassport,"hv_captured_dryad", 9);
		GiveXPToCreature(oPC, 750);
		GiveGoldToCreature(oPC, 250);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
	if(sEntry == "210" || sEntry == "220" || sEntry == "225")
	{
		object oFM = GetFirstFactionMember(oPC, FALSE);
		object oFMPassport = GetItemPossessedBy(oFM,"pc_tracker");
		int nFMCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		int leaderJournal = GetPersistentInt(oPC, "Richard");
		int memberJournal = GetPersistentInt(oFM, "Richard");
		//int memberId = StringToInt(memberJournal);
		while(oFM != OBJECT_INVALID)//Otherwise, we iterate through the party until we find someone who has it (or have
		{							//iterated through the entire party).
			if((memberJournal == leaderJournal)
				&&
				(GetDistanceBetween(oPC, oFM) <= 30.0)
				&& 
				(GetArea(oPC) == GetArea(oFM))
				)
			{
				if(sEntry == "210")
			 	{ 
			  		AddJournalQuestEntry("Richard", 210, oFM, FALSE, FALSE, TRUE);
			  		SetPersistentInt(oFM, "Richard", 210);
			  		SetLocalInt(oFMPassport,"Richard", 210);
			  		SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
			 	}
				if(sEntry == "220")
				{
					  AddJournalQuestEntry("Richard", 220, oFM, FALSE, FALSE, TRUE);
					  SetPersistentInt(oFM, "Richard", 220);
					  SetLocalInt(oFMPassport,"Richard", 220);
					  SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
				}
			 	if(sEntry == "225")
			 	{
			  		AddJournalQuestEntry("Richard", 225, oFM, FALSE, FALSE, TRUE);
			  		SetPersistentInt(oFM, "Richard", 225);
			  		SetLocalInt(oFMPassport,"Richard", 225);
			  		SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
			 	}	
			}
			oFM = GetNextFactionMember(oPC, FALSE);
		}
	}
	if(sEntry == "230")
	{
		AddJournalQuestEntry("Richard", 230, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "Richard", 230);
		SetLocalInt(oPassport,"Richard", 230);
		GiveXPToCreature(oPC, 750);
		GiveGoldToCreature(oPC, 250);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		object oNPC = GetNearestObjectByTag("hv_talonakid");
		if (oNPC!=OBJECT_INVALID && (GetArea(oNPC)==GetArea(oPC))) 
		{
			DelayCommand(3.0f,AssignCommand(oNPC, SpeakString("I'm going home! Thank you!")));
			DestroyObject(oNPC,3.0);
		}
	}
	
	if(sEntry == "301")
 	{
  		AddJournalQuestEntry("hv_historian", 301, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_historian", 301);
  		SetLocalInt(oPassport,"hv_historian", 301);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "302")
 	{
  		AddJournalQuestEntry("hv_historian", 302, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_historian", 302);
  		SetLocalInt(oPassport,"hv_historian", 302);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "303")
 	{
  		AddJournalQuestEntry("hv_historian", 303, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_historian", 303);
  		SetLocalInt(oPassport,"hv_historian", 303);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "304")
 	{
  		AddJournalQuestEntry("hv_historian", 304, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_historian", 304);
  		SetLocalInt(oPassport,"hv_historian", 304);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "305")
 	{
		//object oBook1 = GetNearestObjectByTag("hv_book1");
		//object oBook2 = GetNearestObjectByTag("hv_book2");	
		//object oBook3 = GetNearestObjectByTag("hv_book3");		
		//if (oBook1 != OBJECT_INVALID)
		//	DestroyObject(oBook1, 0.0);
		//if (oBook2 != OBJECT_INVALID)
		//	DestroyObject(oBook2, 0.0);
		//if (oBook3 != OBJECT_INVALID)
		//	DestroyObject(oBook3, 0.0);
  		AddJournalQuestEntry("hv_historian", 305, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_historian", 305);
  		SetLocalInt(oPassport,"hv_historian", 305);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	
	
	if(sEntry == "400")
 	{
  		AddJournalQuestEntry("hv_beastmen", 400, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_beastmen", 400);
  		SetLocalInt(oPassport,"hv_beastmen", 400);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "410")
 	{
  		AddJournalQuestEntry("hv_beastmen", 410, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_beastmen", 410);
  		SetLocalInt(oPassport,"hv_beastmen", 410);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "420")
 	{
  		AddJournalQuestEntry("hv_beastmen", 420, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_beastmen", 420);
  		SetLocalInt(oPassport,"hv_beastmen", 420);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	
	
	// Puzzle quest
	if(sEntry == "460")
 	{
  		AddJournalQuestEntry("hv_p_h", 460, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_p_h", 460);
  		SetLocalInt(oPassport,"hv_p_h", 460);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "470")
 	{
  		AddJournalQuestEntry("hv_p_h", 470, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_p_h", 470);
  		SetLocalInt(oPassport,"hv_p_h", 470);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "480")
 	{
  		AddJournalQuestEntry("hv_p_h", 480, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_p_h", 480);
  		SetLocalInt(oPassport,"hv_p_h", 480);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	
	// Cave quest
	if(sEntry == "560")
 	{
  		AddJournalQuestEntry("hv_cq", 560, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_cq", 560);
  		SetLocalInt(oPassport,"hv_cq", 560);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "570")
 	{
  		AddJournalQuestEntry("hv_cq", 570, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_cq", 570);
  		SetLocalInt(oPassport,"hv_cq", 570);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "580")
 	{
  		AddJournalQuestEntry("hv_cq", 580, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_cq", 580);
  		SetLocalInt(oPassport,"hv_cq", 580);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	
	
	// Overgrowth temple quest
	if(sEntry == "500")
	{
		AddJournalQuestEntry("hv_temple_quest", 500, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_temple_quest", 500);
		SetLocalInt(oPassport,"hv_temple_quest", 500);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "510")
	{
		AddJournalQuestEntry("hv_temple_quest", 510, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_temple_quest", 510);
		SetLocalInt(oPassport,"hv_temple_quest", 510);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "520")
	{
		AddJournalQuestEntry("hv_temple_quest", 520, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_temple_quest", 520);
		SetLocalInt(oPassport,"hv_temple_quest", 520);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "530")
	{
		AddJournalQuestEntry("hv_temple_quest", 530, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_temple_quest", 530);
		SetLocalInt(oPassport,"hv_temple_quest", 530);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
	// arena 5 rounds
	if(sEntry == "600")
	{
		AddJournalQuestEntry("hv_arena_survival_5", 600, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_5", 600);
		SetLocalInt(oPassport,"hv_arena_survival_5", 600);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "601")
	{
		AddJournalQuestEntry("hv_arena_survival_5", 601, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_5", 601);
		SetLocalInt(oPassport,"hv_arena_survival_5", 601);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "602")
	{
		AddJournalQuestEntry("hv_arena_survival_5", 602, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_5", 602);
		SetLocalInt(oPassport,"hv_arena_survival_5", 602);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
	// arena 10 rounds
	if(sEntry == "603")
	{
		AddJournalQuestEntry("hv_arena_survival_10", 603, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_10", 603);
		SetLocalInt(oPassport,"hv_arena_survival_10", 603);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "604")
	{
		AddJournalQuestEntry("hv_arena_survival_10", 604, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_10", 604);
		SetLocalInt(oPassport,"hv_arena_survival_10", 604);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "605")
	{
		AddJournalQuestEntry("hv_arena_survival_10", 605, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_10", 605);
		SetLocalInt(oPassport,"hv_arena_survival_10", 605);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
	// arena 15 rounds
	if(sEntry == "606")
	{
		AddJournalQuestEntry("hv_arena_survival_15", 606, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_15", 606);
		SetLocalInt(oPassport,"hv_arena_survival_15", 606);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "607")
	{
		AddJournalQuestEntry("hv_arena_survival_15", 607, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_15", 607);
		SetLocalInt(oPassport,"hv_arena_survival_15", 607);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "608")
	{
		AddJournalQuestEntry("hv_arena_survival_15", 608, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_15", 608);
		SetLocalInt(oPassport,"hv_arena_survival_15", 608);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
	// arena 20 rounds
	if(sEntry == "609")
	{
		AddJournalQuestEntry("hv_arena_survival_20", 609, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_20", 609);
		SetLocalInt(oPassport,"hv_arena_survival_20", 609);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "610")
	{
		AddJournalQuestEntry("hv_arena_survival_20", 610, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_20", 610);
		SetLocalInt(oPassport,"hv_arena_survival_20", 610);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "611")
	{
		AddJournalQuestEntry("hv_arena_survival_20", 611, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_arena_survival_20", 611);
		SetLocalInt(oPassport,"hv_arena_survival_20", 611);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		// xenq_arena30[11/08/14]
	if(sEntry == "861220")
	{
		AddJournalQuestEntry("xenq_arena30", 861220, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_arena30", 861220);
		SetLocalInt(oPassport,"xenq_arena30", 861220);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861221")
	{
		AddJournalQuestEntry("xenq_arena30", 861221, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_arena30", 861221);
		SetLocalInt(oPassport,"xenq_arena30", 861221);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861222")
	{
		AddJournalQuestEntry("xenq_arena30", 861222, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_arena30", 861222);
		SetLocalInt(oPassport,"xenq_arena30", 861222);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}

	
	// Vault Quest		
	if(sEntry == "700")
 	{
  		AddJournalQuestEntry("redvibe_avault", 700, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "redvibe_avault", 700);
  		SetLocalInt(oPassport,"redvibe_avault", 700);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "710")
 	{
  		AddJournalQuestEntry("redvibe_avault", 710, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "redvibe_avault", 710);
  		SetLocalInt(oPassport,"redvibe_avault", 710);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "720")
 	{
  		AddJournalQuestEntry("redvibe_avault", 720, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "redvibe_avault", 720);
  		SetLocalInt(oPassport,"redvibe_avault", 720);
		GiveXPToCreature(oPC, 1000);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "721")
 	{
  		AddJournalQuestEntry("redvibe_avault", 721, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "redvibe_avault", 721);
  		SetLocalInt(oPassport,"redvibe_avault", 721);
		GiveXPToCreature(oPC, 1250);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	if(sEntry == "722")
 	{
  		AddJournalQuestEntry("redvibe_avault", 722, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "redvibe_avault", 722);
  		SetLocalInt(oPassport,"redvibe_avault", 722);
		GiveXPToCreature(oPC, 1250);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
 	}
	
	if(sEntry == "800" || sEntry == "810" || sEntry == "820" || sEntry == "830"||sEntry == "840")
	{
		object oFM = GetFirstFactionMember(oPC, FALSE);
		object oFMPassport = GetItemPossessedBy(oFM,"pc_tracker");
		int nFMCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		int leaderJournal = GetPersistentInt(oPC, "alg_babe");
		int memberJournal = GetPersistentInt(oFM, "alg_babe");
		//int memberId = StringToInt(memberJournal);
		while(oFM != OBJECT_INVALID)//Otherwise, we iterate through the party until we find someone who has it (or have
		{							//iterated through the entire party).
			if((memberJournal == leaderJournal)
				&&
				(GetDistanceBetween(oPC, oFM) <= 30.0)
				&& 
				(GetArea(oPC) == GetArea(oFM))
				)
			{
				if(sEntry == "800")
			 	{ 
			  		AddJournalQuestEntry("alg_babe", 800, oFM, FALSE, FALSE, TRUE);
			  		SetPersistentInt(oFM, "alg_babe", 800);
			  		SetLocalInt(oFMPassport,"alg_babe", 800);
			  		SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
			 	}
				if(sEntry == "810")
				{
					  AddJournalQuestEntry("alg_babe", 810, oFM, FALSE, FALSE, TRUE);
					  SetPersistentInt(oFM, "alg_babe", 810);
					  SetLocalInt(oFMPassport,"alg_babe", 810);
					  SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
				}
			 	if(sEntry == "820")
			 	{
			  		AddJournalQuestEntry("alg_babe", 820, oFM, FALSE, FALSE, TRUE);
			  		SetPersistentInt(oFM, "alg_babe", 820);
					GiveXPToCreature(oFM, 750);
			  		SetLocalInt(oFMPassport,"alg_babe", 820);
			  		SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
			 	}
			 	if(sEntry == "830")
			 	{
			  		AddJournalQuestEntry("alg_babe", 830, oFM, FALSE, FALSE, TRUE);
			  		SetPersistentInt(oFM, "alg_babe", 830);
			  		SetLocalInt(oFMPassport,"alg_babe", 830);
			  		SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
			 	}
					if(sEntry == "840")
			 	{
			  		AddJournalQuestEntry("alg_babe", 840, oFM, FALSE, FALSE, TRUE);
			  		SetPersistentInt(oFM, "alg_babe", 840);
					GiveXPToCreature(oFM, 750);
			  		SetLocalInt(oFMPassport,"alg_babe", 840);
					
			  		SetPersistentInt(oFM, "RANK", (nFMCurrentRank + 1), 0, "RP_Rank");
			 	}	
			}
			oFM = GetNextFactionMember(oPC, FALSE);
		}
		}
		
	// Bandits quest
	if(sEntry == "900")
	{
		AddJournalQuestEntry("hv_bandits_quest", 900, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_bandits_quest", 900);
		SetLocalInt(oPassport,"hv_bandits_quest", 900);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "905")
	{
		AddJournalQuestEntry("hv_bandits_quest", 905, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_bandits_quest", 905);
		SetLocalInt(oPassport,"hv_bandits_quest", 905);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "910")
	{
		AddJournalQuestEntry("hv_bandits_quest", 910, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_bandits_quest", 910);
		SetLocalInt(oPassport,"hv_bandits_quest", 910);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		// xenq_deb[07/14]
	if(sEntry == "861201")
	{
		AddJournalQuestEntry("xenq_deb", 861201, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_deb", 861201);
		SetLocalInt(oPassport,"xenq_deb", 861201);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861202")
	{
		AddJournalQuestEntry("xenq_deb", 861202, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_deb", 861202);
		SetLocalInt(oPassport,"xenq_deb", 861202);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
		if(sEntry == "861203")
	{
		AddJournalQuestEntry("xenq_deb", 861203, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_deb", 861203);
		SetLocalInt(oPassport,"xenq_deb", 861203);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
     	//xenq_trollblood[09/14]
	if(sEntry == "861211")
	{
		AddJournalQuestEntry("xenq_trollblood", 861211, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_trollblood", 861211);
		SetLocalInt(oPassport,"xenq_trollblood", 861211);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861212")
	{
		AddJournalQuestEntry("xenq_trollblood", 861212, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_trollblood", 861212);
		SetLocalInt(oPassport,"xenq_trollblood", 861212);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861213")
	{
		AddJournalQuestEntry("xenq_trollblood", 861213, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_trollblood", 861213);
		SetLocalInt(oPassport,"xenq_trollblood", 861213);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861214")
	{
		AddJournalQuestEntry("xenq_trollblood", 861214, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_trollblood", 861214);
		SetLocalInt(oPassport,"xenq_trollblood", 861214);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861215")
	{
		AddJournalQuestEntry("xenq_trollblood", 861215, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_trollblood", 861215);
		SetLocalInt(oPassport,"xenq_trollblood", 861215);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}

/////////////////////////////////////////////////////////////////////////////
	// Begin Drow / Underdark Quests //
////////////////////////////////////////////////////////////////////////////

			// xenq_ud_evvnark
	if(sEntry == "861230")
	{
		AddJournalQuestEntry("xenq_ud_evvnark", 861230, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_evvnark", 861230);
		SetLocalInt(oPassport,"xenq_ud_evvnark", 861230);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861231")
	{
		AddJournalQuestEntry("xenq_ud_evvnark", 861231, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_evvnark", 861231);
		SetLocalInt(oPassport,"xenq_ud_evvnark", 861231);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861232")
	{
		AddJournalQuestEntry("xenq_ud_evvnark", 861232, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_evvnark", 861232);
		SetLocalInt(oPassport,"xenq_ud_evvnark", 861232);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
			// xenq_ud_beetlemeatbounty
	if(sEntry == "861240")
	{
		AddJournalQuestEntry("xenq_ud_beetlemeatbounty", 861240, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_beetlemeatbounty", 861240);
		SetLocalInt(oPassport,"xenq_ud_beetlemeatbounty", 861240);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861241")
	{
		AddJournalQuestEntry("xenq_ud_beetlemeatbounty", 861241, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_beetlemeatbounty", 861241);
		SetLocalInt(oPassport,"xenq_ud_beetlemeatbounty", 861241);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861242")
	{
		AddJournalQuestEntry("xenq_ud_beetlemeatbounty", 861242, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_beetlemeatbounty", 861242);
		SetLocalInt(oPassport,"xenq_ud_beetlemeatbounty", 861242);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
				// xenq_ud_yathrinquest
	if(sEntry == "861250")
	{
		AddJournalQuestEntry("xenq_ud_yathrinquest", 861250, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", 861250);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", 861250);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861253")
	{
		AddJournalQuestEntry("xenq_ud_yathrinquest", 861253, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", 861253);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", 861253);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861254")
	{
		AddJournalQuestEntry("xenq_ud_yathrinquest", 861254, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", 861254);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", 861254);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861255")
	{
		AddJournalQuestEntry("xenq_ud_yathrinquest", 861255, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", 861255);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", 861255);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861256")
	{
		AddJournalQuestEntry("xenq_ud_yathrinquest", 861256, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", 861256);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", 861256);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}

				// xenq_ud_uuthli
	if(sEntry == "861260")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861260, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861260);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861260);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861261")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861261, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861261);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861261);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861263")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861263, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861263);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861263);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861264")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861264, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861264);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861264);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861265")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861265, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861265);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861265);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861266")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861266, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861266);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861266);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	if(sEntry == "861267")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861267, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861267);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861267);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}

	if(sEntry == "861268")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861268, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861268);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861268);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}	
	
	if(sEntry == "861269")
	{
		AddJournalQuestEntry("xenq_ud_uuthli", 861269, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", 861269);
		SetLocalInt(oPassport,"xenq_ud_uuthli", 861269);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
		
	
					// xenq_ud_khaliizi
	if(sEntry == "861270")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861270, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861270);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861270);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "861271")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861271, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861271);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861271);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
		
		if(sEntry == "861273")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861273, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861273);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861273);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "861274")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861274, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861274);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861274);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "861275")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861275, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861275);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861275);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "861276")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861276, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861276);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861276);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "861277")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861277, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861277);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861277);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "861278")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861278, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861278);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861278);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "861279")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 861279, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 861279);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 861279);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "8612701")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 8612701, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 8612701);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 8612701);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
		if(sEntry == "8612702")
	{
		AddJournalQuestEntry("xenq_ud_khaliizi", 8612702, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_khaliizi", 8612702);
		SetLocalInt(oPassport,"xenq_ud_khaliizi", 8612702);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	

	
						// xenq_ud_magmyconid
	if(sEntry == "861280")
	{
		AddJournalQuestEntry("xenq_ud_magmyconid", 861280, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magmyconid", 861280);
		SetLocalInt(oPassport,"xenq_ud_magmyconid", 861280);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "861282")
	{
		AddJournalQuestEntry("xenq_ud_magmyconid", 861282, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magmyconid", 861282);
		SetLocalInt(oPassport,"xenq_ud_magmyconid", 861282);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
	
							// xenq_ud_magderro
	if(sEntry == "86128010")
	{
		AddJournalQuestEntry("xenq_ud_magderro", 86128010, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magderro", 86128010);
		SetLocalInt(oPassport,"xenq_ud_magderro", 86128010);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "86128012")
	{
		AddJournalQuestEntry("xenq_ud_magderro", 86128012, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magderro", 86128012);
		SetLocalInt(oPassport,"xenq_ud_magderro", 86128012);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
								// xenq_ud_magazer
	if(sEntry == "86128020")
	{
		AddJournalQuestEntry("xenq_ud_magazer", 86128020, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magazer", 86128020);
		SetLocalInt(oPassport,"xenq_ud_magazer", 86128020);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "86128022")
	{
		AddJournalQuestEntry("xenq_ud_magazer", 86128022, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magazer", 86128022);
		SetLocalInt(oPassport,"xenq_ud_magazer", 86128022);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
									// xenq_ud_magroper
	if(sEntry == "86128030")
	{
		AddJournalQuestEntry("xenq_ud_magroper", 86128030, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magroper", 86128030);
		SetLocalInt(oPassport,"xenq_ud_magroper", 86128030);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "86128032")
	{
		AddJournalQuestEntry("xenq_ud_magroper", 86128032, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magroper", 86128032);
		SetLocalInt(oPassport,"xenq_ud_magroper", 86128032);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
	
										// xenq_ud_magkuotoa
	if(sEntry == "86128040")
	{
		AddJournalQuestEntry("xenq_ud_magkuotoa", 86128040, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magkuotoa", 86128040);
		SetLocalInt(oPassport,"xenq_ud_magkuotoa", 86128040);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "86128042")
	{
		AddJournalQuestEntry("xenq_ud_magkuotoa", 86128042, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magkuotoa", 86128042);
		SetLocalInt(oPassport,"xenq_ud_magkuotoa", 86128042);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
	
										// xenq_ud_magbeholder
	if(sEntry == "86128050")
	{
		AddJournalQuestEntry("xenq_ud_magbeholder", 86128050, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magbeholder", 86128050);
		SetLocalInt(oPassport,"xenq_ud_magbeholder", 86128050);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "86128052")
	{
		AddJournalQuestEntry("xenq_ud_magbeholder", 86128052, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magbeholder", 86128052);
		SetLocalInt(oPassport,"xenq_ud_magbeholder", 86128052);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		

		
	
										// xenq_ud_magminotaur
	if(sEntry == "86128060")
	{
		AddJournalQuestEntry("xenq_ud_magminotaur", 86128060, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magminotaur", 86128060);
		SetLocalInt(oPassport,"xenq_ud_magminotaur", 86128060);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
	
		if(sEntry == "86128062")
	{
		AddJournalQuestEntry("xenq_ud_magminotaur", 86128062, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "xenq_ud_magminotaur", 86128062);
		SetLocalInt(oPassport,"xenq_ud_magminotaur", 86128062);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}		
		
	
	
	
			
	
	
	
	
	
	
/*
		if(sEntry == "00000")
	{
		AddJournalQuestEntry("ud_QUEST_NAME", 99999, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "ud_QUEST_NAME", 99999);
		SetLocalInt(oPassport,"ud_QUEST_NAME", 99999);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
*/
}