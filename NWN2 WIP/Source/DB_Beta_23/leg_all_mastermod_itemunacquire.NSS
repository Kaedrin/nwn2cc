/*

    Script:			This is the MASTER item un-acquired script for going in the module properties event when
					a PC loses an item.  Mostly useful for quests when a PC drops an item belonging to a quest,
					we want to the PC to lose credit for it.  Most quest items are non-droppable, but items
					like crafting items etc can be used in quests but can be dropped also.  These types of
					items will have variables ON the item itself which is what we'll need for this to work.
	Version:		1.00
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		07/22/2011 - 1.00 MV - Initial Release

*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
//#include "leg_all_masteritem_def"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{

	// Let's get the Item, the person that acquired it and the ResRef/Tag of it.
	object oItem = GetModuleItemLost();
	object oPC = GetModuleItemLostBy();	
	string sItemRef = GetResRef(oItem);	
	string sItemTag = GetTag(oItem);

	// As long as we're a playah.
	if (GetIsPC(oPC))
	{
		// Check for the Quest Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			AddScriptParameterObject(oItem);
			ExecuteScriptEnhanced("leg_quest_itemunacquired", oPC);		
		}
	}
}