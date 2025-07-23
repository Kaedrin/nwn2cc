/*

    Script:			This is the MASTER item acquired script for going in the module properties event when
					a PC acquires an item.  Mostly useful for setting variables on items when purchased from
					stores as the engine seems to have a bug in it where items won't keep their variables.
					Like all master scripts, it calls plugins that need it.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		12/29/2010 - 1.00 MV - Initial Release
					06/23/2011 - 1.01 MV - Updated to remove item Defs from Quest Plugin to Master

*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_all_masteritem_def"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{

	// Let's get the Item, the person that acquired it and the ResRef/Tag of it.
	object oItem = GetModuleItemAcquired();
	object oPC = GetModuleItemAcquiredBy();	
	string sItemRef = GetResRef(oItem);	
	string sItemTag = GetTag(oItem);

	// Often times items that come from stores etc, will not have any variables saved on them.  This is an engine bug
	// that REALLY REALLY sucks.  As a result, the only workaround is to identify the item the PC got and apply
	// any known variables to them here.  Yes I know, stop yelling at me, it's not my fault.  Included in this plugin are
	// the item definitions from some quests from the Legends Persistent World.  This will give you an idea of what goes in here.
	// Some of these items come from other quests, some come from a store the PC may have had to purchase the item from.
	// All the item variables are kept in a definitions script called "leg_quest_itemacquired_def".
	//LEG_COMMON_ITEMACQUIRED_Defs(sItemRef, oItem);

	// As long as we're a playah.
	if (GetIsPC(oPC))
	{
		// Check for NON Quest Items
		LEG_COMMON_ITEMACQUIRED_Defs(sItemRef, oItem);
		
		// Check for the Quest Plugin and fire its script if it is.
		if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		{
			AddScriptParameterObject(oPC);
			AddScriptParameterObject(oItem);
			ExecuteScriptEnhanced("leg_quest_itemacquired", oPC);		
		}
	}
}