//Put this script in an On Enter Script slot of a Trigger. Then place the trigger 
//over your modules start location. 
//This will return characters to their stored locations in the database folder
//Shockwolf - 19/12/2009
//Thanks to Leomist's Auto Server Restart scripts for NWN1

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

AssignCommand(oPC,ActionJumpToLocation(GetCampaignLocation("SavedLocation","Location",oPC)));
DelayCommand(5.0, DeleteCampaignVariable("SavedLocation","Location",oPC));

}