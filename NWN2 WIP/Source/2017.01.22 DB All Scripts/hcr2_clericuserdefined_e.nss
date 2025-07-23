/*
Filename:           hcr2_clericuserdefined_e
System:             pc corpse (npc user defined event script)
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

*/
#include "hcr2_pccorpse_i"

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == H2_PCCORPSE_ITEM_ACTIVATED_EVENT_NUMBER)
    {        
        h2_AttemptRessurectionViaNPC();
    }
}