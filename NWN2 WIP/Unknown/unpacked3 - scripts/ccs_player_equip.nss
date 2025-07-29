//::///////////////////////////////////////////////
//:: ccs_player_equip
//:: Purpose: On Player Equip Item Script
//:: Created By: Kaedrin
//:: Created On: January 07 , 2008
//:://////////////////////////////////////////////

void main()
{

	//OBJECT_SELF is assumed to be the player
	//The developer should use these two calls to manipulate the event
	//object oItem = GetPCItemLastEquipped();

	//ExecuteScript("community_user_script_here", OBJECT_SELF);
	//ExecuteScript("cmi_player_equip", OBJECT_SELF);
	object oPC = GetPCItemLastEquippedBy();
	ExecuteScript("cmi_player_equip", oPC);
	//ExecuteScript("alex_rws_horse_equip", oPC);
}