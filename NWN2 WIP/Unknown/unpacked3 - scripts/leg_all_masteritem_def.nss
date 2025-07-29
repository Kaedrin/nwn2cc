/*

    Script:			The definitions of the items that are plagued by the engine bug that does not allow
					variables on the item blueprints to pass on to ingame items when purchased from a store.
					Items given via other methods do not have this issue that we know of.
	Version:		1.01
	Plugin Version: 1.7
	Last Update:	06/23/2011
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		12/29/2010 - 1.00 MV - Initial Release
					06/23/2011 - 1.01 MV - Added travel rations

*/



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTION DECLARATIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////



// ///////////////////////////////////////////////////////////////////////////
// The function to assign variables to items that will not keep them correctly
// in game.  This is a bug in the game engine and so far, the only items
// that "should" need this are items that have variables on them that are
// purchased from a store.
// string sItemRef				- The ResRef of the item in question.
// object oItem					- The Item itself.
//	Returns: Nothing
void LEG_COMMON_ITEMACQUIRED_Defs(string sItemRef, object oItem);




// /////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////


// //////////////////////////////////////////////////
// LEG_QUEST_ITEMACQUIRED_Defs
// //////////////////////////////////////////////////
void LEG_COMMON_ITEMACQUIRED_Defs(string sItemRef, object oItem)
{
	if (sItemRef != "")
	{
		
		// BEGIN ITEM DEFINITIONS
		// Lets check for Food Items and quest items.
		if (sItemRef == "smalltravelrations")
		{
			SetLocalInt(oItem, "SJS_EatTime", 20);
			SetLocalInt(oItem, "SJS_Regen", 1);
			SetLocalFloat(oItem, "SJS_RegenInterval", 3.0);
			SetLocalFloat(oItem, "SJS_RegenDuration", 30.0);
		}
		else if (sItemRef == "mediumtravelrations")
		{
			SetLocalInt(oItem, "SJS_EatTime", 20);
			SetLocalInt(oItem, "SJS_Regen", 1);
			SetLocalFloat(oItem, "SJS_RegenInterval", 2.0);
			SetLocalFloat(oItem, "SJS_RegenDuration", 40.0);
		}		
	}
}