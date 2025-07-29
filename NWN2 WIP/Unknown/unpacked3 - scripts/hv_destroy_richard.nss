/*
Filename:           hcr2_areaonenter_e
System:             core (Area OnEnter event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 Area OnEnter Event.
This script should be attachted to an Area's OnEnter event under
the scripts section of Area properties.

Variables available to all area event scripts:
GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) returns the number of players in the area.

-----------------
Revision: v1.05
Adjusted event call function

*/

#include "hcr2_core_i"

void DestroyRichard(object oPC)
{
	object oNPC = GetNearestObjectByTag("hv_talonakid");
	if(oNPC!=OBJECT_INVALID && (GetArea(oPC) == GetArea(oNPC)))
	{
		DelayCommand(3.0f,AssignCommand(oNPC, SpeakString("I'm going home! Thank you!")));
    	//DelayCommand(3.0f,AssignCommand(oNPC, ActionDoCommand(DestroyObject(oNPC))));
		//DestroyObject(oNPC,3.0f,FALSE);
		DestroyObject(oNPC,3.0);
	}
}

void main()
{
    h2_RunObjectEventScripts(H2_AREAEVENT_ON_ENTER, OBJECT_SELF);
	object oArea = OBJECT_SELF;
	 
	object oPC = GetEnteringObject();

	//int nQuestEntry = GetJournalEntry("Richard", oPC);
	
	//if (nQuestEntry == 220) {
	//	AddJournalQuestEntry("Richard", 225, oPC, FALSE);
	//}
	//DelayCommand(10.0f, DestroyRichard(oPC));
	
	
	object oFM = GetFirstFactionMember(oPC, FALSE);
	object oFMPassport = GetItemPossessedBy(oFM,"pc_tracker");
	int leaderJournal = GetPersistentInt(oPC, "Richard");
	int memberJournal = GetPersistentInt(oFM, "Richard");
	while(oFM != OBJECT_INVALID)//Otherwise, we iterate through the party until we find someone who has it (or have
	{							//iterated through the entire party).
		if((memberJournal == leaderJournal)
			&&
			(GetDistanceBetween(oPC, oFM) <= 30.0)
			&& 
			(GetArea(oPC) == GetArea(oFM))
			&&
			leaderJournal==220
			)
		{
			  AddJournalQuestEntry("Richard", 225, oFM, FALSE, FALSE, TRUE);
			  SetPersistentInt(oFM, "Richard", 225);
			  SetLocalInt(oFMPassport,"Richard", 225);
		}
		oFM = GetNextFactionMember(oPC, FALSE);
	}
	
	DelayCommand(10.0f, DestroyRichard(oPC));
	
}