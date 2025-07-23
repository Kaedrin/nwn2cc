/*
Author: 		DM_Nocturne
Created: 		November 11, 2013
Last Modified:	August 13, 2016
Description:

Script to attach to a conversation to take nXP from a player. Used since the built in script ga_give_xp does not
remove XP if passed a negative parameter.

Update (8/13/2016): Added check to prevent script from working for Dragon Disciples
*/

void main(int xpToTake)
{
	object oSpeaker = GetPCSpeaker();
	if(!GetIsPC(oSpeaker)) //Exits the script if the speaker is not a PC
	{
		return;
	}
	
	//Does not let Dragon Disciples delevel, in order to prevent re-leveling exploit
	if(GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oSpeaker) > 0)
	{
		SendMessageToPC(oSpeaker, "Unable to remove experience. Please contact a DM for assistance.");
		return;
	}
	
	int currentXP = GetXP (oSpeaker);
	int newXP = currentXP - xpToTake;
	SetXP(oSpeaker, newXP);
}