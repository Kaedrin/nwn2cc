/*

    Script:			This script is called on Quest Triggers usually associated with the Explore a Place
					type objective.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
	
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_include"


void BringGnollsToMe(location oLocation, string sCreature)
{
	int i=0;
	while(GetObjectByTag(sCreature, i) != OBJECT_INVALID)
	{
		AssignCommand(GetObjectByTag(sCreature, i), ActionMoveToLocation(oLocation, TRUE));
		i = i + 1;
	}
}

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Get the PC that's entering me.. Oh that sounds dirty hehe.
	object oPC = GetEnteringObject();
	string sTriggerName = GetName(OBJECT_SELF);

	// If the Quest plugin isn't active, just exit.
	//if (!GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
	//	return;
				
	if (GetIsPC(oPC))
	{
		object oGnolls = GetObjectByTag("alex_legquest_gnollthug");

		if(oGnolls==OBJECT_INVALID || GetItemPossessedBy(oPC, "rangershorbow") == OBJECT_INVALID)
		{
			return;
		}
		location oLocation = GetLocation(oGnolls);
		

	
		
		if(GetEncounterActive(oGnolls) == FALSE && GetLocalInt(oGnolls, "Trigger") == 0)
		{
			DelayCommand(1.0f, SetLocalInt(oGnolls, "Trigger", 1));
			DelayCommand(2.0f, SetEncounterActive(TRUE, oGnolls));
			DelayCommand(5.0f, TriggerEncounter(oGnolls, oPC, 0, -1.0));
			DelayCommand(10.0f, BringGnollsToMe(oLocation, "kh_gnolls"));
			DelayCommand(300.0f, SetLocalInt(oGnolls, "Trigger", 0));
			//DelayCommand(10.0f, TriggerEncounter(TRUE, oGnolls));	
			//DelayCommand(10.0f, SetEncounterActive(TRUE, oGnolls));	
		}
		//DelayCommand(10.0f, SetEncounterActive(TRUE, oGnolls));
		//DelayCommand(10.0f, TriggerEncounter(oGnolls, oPC, 0, 0.0f));
		//DelayCommand(60.0f, SetEncounterActive(FALSE, oGnolls));
	}
}