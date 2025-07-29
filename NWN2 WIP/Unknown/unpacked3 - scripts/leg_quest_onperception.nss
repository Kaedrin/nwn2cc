/*

    Script:			This script is for NPC's when the Quest ICON config is active to refresh/update and icon the NPC may have.
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


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(object oPC)
{
	// First see if the ICON config is active.
	if (LEG_QUEST_ICONS)
	{
		// Next see if I have an Icon.		
		if (!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "MyIcon")))
		{
			// And do I have quests?
			if (GetLocalInt(OBJECT_SELF, "LEG_QUEST_TotalQuests") > 0)
			{
				// Who did I just see?
				if (GetIsPC(oPC))
				{
					// Are we hostile?  We don't wanna be.
					if (!GetIsReactionTypeHostile(oPC, OBJECT_SELF))
					{
						// Am I in the middle of an escort quest?  Hope not.
						if (GetLocalInt(OBJECT_SELF, "OnEscort") != 1)
						{
							// Let's create my icon!  WOOT!
							vector vSpawnVector = GetPosition(OBJECT_SELF);
							vector vRadius = Vector(0.0, 0.0, 2.5);
							location lLoc = Location(GetArea(OBJECT_SELF), vSpawnVector + vRadius, 0.0);
							object oQuestIcon = CreateObject(OBJECT_TYPE_PLACEABLE, "leg_quest_icon", lLoc, FALSE, GetTag(OBJECT_SELF) + "_qicon");
							SetLocalObject(OBJECT_SELF, "MyIcon", oQuestIcon);
						}
					}
				}
			}	
		}
	
		// Now that I have a valid Icon...
		if (GetIsObjectValid(GetLocalObject(OBJECT_SELF, "MyIcon")))
		{
			// I've already got an icon.  Let's see if I am viewable to this person or not.
			object oTrap;
			object oMyIcon = GetLocalObject(OBJECT_SELF, "MyIcon");
	
			// And the PC is valid.
			if (GetIsPC(oPC))
				LEG_QUEST_RefreshQuestIcon(OBJECT_SELF, oMyIcon, oPC);
		}	
	}	
}