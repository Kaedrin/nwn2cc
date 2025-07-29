////cleric raise script

/*System:             pc corpse (npc user defined event script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:
User defined event script example that is attached to an NPC cleric.
This Allows the NPC to resurrect a player character when the corpse
token item is used on them. Alter this example and save as a different script
to customize how you want to handle a particular NPC's mechanisms or reasons
for resurrecting a character.

Note, for this particular example, it is assumed that the NPC the script is placed on
is set up to already have the ability to cast raise dead and resurrection.
Therefore no class, level or available spell checking is done. Alter your version
of the script to do any checking you think is necessary.

-----------------
Revision: v1.01
Moved NPC Ress code into single function call.
revised by Becephalus for gold check

*/
#include "hcr2_pccorpse_i"

void main()
{
    object oPC = GetItemActivator();
	int nEvent = GetUserDefinedEventNumber();
    if (nEvent == H2_PCCORPSE_ITEM_ACTIVATED_EVENT_NUMBER)
	 
    if (GetGold(oPC) <= 499)
   {
   ActionSpeakString("You do not have the required five hundred gold donation.");
	
   }
else
   {
   ActionSpeakString("You have the required donation I shall try to return this ones soul to their body.");
   AssignCommand(oPC, TakeGoldFromCreature(500, oPC, TRUE));
   h2_AttemptRessurectionViaNPC();
   } 
	
}



