//::///////////////////////////////////////////////
//:: ccs_player_unequip
//:: Purpose: On Player Unequip Item Script
//:: Created By: Kaedrin
//:: Created On: January 07 , 2008
//:://////////////////////////////////////////////

void main()
{

	//OBJECT_SELF is assumed to be the module
	//The developer should use these two calls to manipulate the event
    //object oItem = GetPCItemLastUnequipped();
	//object oPC = GetPCItemLastUnequippedBy();
    //string sTag = GetTag(oItem);

	//ExecuteScript("community_user_script_here", OBJECT_SELF);
	ExecuteScript("cmi_player_unequip", OBJECT_SELF);
}