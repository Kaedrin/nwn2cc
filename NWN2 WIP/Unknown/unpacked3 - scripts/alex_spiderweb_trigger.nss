/* - this script was not notated, but notes have been added when the
script was adjusted by Gildren on 11-09-2012

this script creates a spider web effect (web spell) at it's location
when a player character enters the trigger

a delay is set on the creation of the effect so that once it is 
triggered, the effect will not re-trigger until the delay has 
passed

gildren added an addition lines checking to see if the PC that
has entered the script is a worshiper of Lolth, which then ends
the script before it fires off the web effect, activates the
'AmbushSpiderEncounter' or starts the re-set counter

at the time of these notes being added, gildren increased the 
re-set delay timer from 250 seconds to 600 seconds

This script was first used in area "midwood caves level 2"
and has since been added to additional underdark areas
*/


#include "x2_inc_spellhook" 

void main()
{
	object oPC = GetEnteringObject(); 
	object oSpiderEncounter = GetNearestObjectByTag("AmbushSpiderEncounter");
	int resetTimer = GetLocalInt(oSpiderEncounter, "reset");

	//checks to see if it's a PC
	if (!GetIsPC(oPC)) return;
	
	// checks to see if the PC does not worships Lolth
	if (GetStringLowerCase(GetDeity(oPC))=="lolth")	return;
	
	// checks to see if the reset timer is not equal to the local interger 1
	if (resetTimer==1)
		{
   	 		//Create an instance of the AOE Object using the Apply Effect function			
			effect eAOE = EffectAreaOfEffect(AOE_PER_WEB);
    		location lTarget = GetLocation(oPC);
    		int nDuration = 15;
   			ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));

			//trigger the inactive encounter and begin the delay counter for re-set		
			TriggerEncounter(oSpiderEncounter, oPC, 0, -1.0);
			SetLocalInt(oSpiderEncounter, "reset", 1);
			DelayCommand(600.0f, DeleteLocalInt(oSpiderEncounter, "reset"));
		}
	else
	return;
	
}