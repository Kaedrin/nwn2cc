/*

    Script:			Script that is called when the PC clicks on one of the rewards from the Finish 
					Quest GUI and is looking for a description.
	Version:		1.00
	Plugin Version: 1.7
	Last Update:	06/23/2011
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
void main(int iQuestID, int iRewardChoice)
{
	// Go through our Item Rewards table and get the RESREF of the reward the PC has selected.
	int iRewardCounter;
	string sItemRef, sDesc, sName;
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_questrewards` WHERE `QuestID`='" + IntToString(iQuestID) + "' AND `Action`='GIVEITEM'");
	while (SQLFetch())
	{
		iRewardCounter++;
		sItemRef = SQLGetData(3);
		
		// Once we have identified the reward, lets display some details about it.
		if (iRewardCounter == iRewardChoice)
		{
			// Temporarily create the item at the Item Viewer waypoint in the current area.  All areas that have
			// quest FINISHERS that hand out items will need to have an Item Viewer waypoint in them.  The
			// waypoint should be obscured so PC's will not see randomly appearing and disappearing items.
			object oLocationPoint = GetNearestObjectByTag("leg_quest_itemviewer");
			
			location lLoc;
			if (GetIsObjectValid(oLocationPoint))
			{
				// We want to create it several feet in the air to avoid view.
				vector vSpawnVector = GetPosition(oLocationPoint);
				vector vRadius = Vector(0.0, 0.0, 10.0);
				lLoc = Location(GetArea(OBJECT_SELF), vSpawnVector + vRadius, 0.0);
				if(GetIsLocationValid(lLoc))
				{
					object oItem = CreateObject(OBJECT_TYPE_ITEM, sItemRef, lLoc);
					if (GetIsObjectValid(oItem))
					{
						// Display the information box of the item.
						DelayCommand(2.0, ActionExamine(oItem));
						
						// Get rid of it.
						DestroyObject(oItem, 3.0);		
					}
				}
			}
		}
	}			
}