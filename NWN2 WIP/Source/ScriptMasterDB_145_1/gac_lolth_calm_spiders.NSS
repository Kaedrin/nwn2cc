/* created by gildren for dalelands beyond

this script is triggered by a lolth worshiping player character
who enters a trigger

the script deals with hostile spiders so that they will not attack
lolth worshipers, forcing those worshipers to kill the spiders
kinda a major rp issue for lolth worshipers, not to mention that
spiders should not attack devoute followers of lolth

the script changes the faction of spawned spiders to commoner
until such time as they are auto de-spawned or killed

This goes into the OnEnter of a trigger

*/


void main()
{

int nNth = 0;

object oPC = GetEnteringObject(); // get the object who enters the trigger

if (!GetIsPC(oPC)) return; // stops the script if the object is not a PC

if (GetStringLowerCase(GetDeity(oPC))!="lolth")
   return; // stops the script if the PC does not worship lolth

// TARGETS THE FIRST SPIDER(S) BY TAG --------------------------------
// total of eight spawns

object oTarget;
oTarget = GetObjectByTag("pinto_crawler_cr15", nNth);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+1);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+2);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+3);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+4);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+5);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+6);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_cr15", nNth+7);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));


// NEXT SPIDER TYPE ---------------------------------------------
//total of one spawn

oTarget = GetObjectByTag("pinto_crawler_queen_cr19", nNth);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));


// NEXT SPIDER TYPE ----------------------------------------------
// total of 17 spawns

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+1);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+2);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+3);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+4);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+5);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+6);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+7);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+9);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+10);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+11);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+12);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+13);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+14);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+15);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

oTarget = GetObjectByTag("pinto_crawler_hatchling_cr13", nNth+16);

// Stops the spider's actions/attacks  
// and changes the spider's faction to NEUTRAL
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeToStandardFaction(oTarget, ALIGNMENT_NEUTRAL);
	AssignCommand(oTarget, ClearAllActions(TRUE));

}