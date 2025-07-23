/*
Author: 		DM_Nocturne
Created: 		November 11, 2013
Last Modified:	November 11, 2013
Description:

Script to attach to a conversation to take nXP from a player. Used since the built in script ga_give_xp does not
remove XP if passed a negative parameter.
*/

void main(int xpToTake)
{
	object oSpeaker = GetPCSpeaker();
	if(!GetIsPC(oSpeaker)) //Exits the script if the speaker is not a PC
	{
		return;
	}
	
	int currentXP = GetXP (oSpeaker);
	int newXP = currentXP - xpToTake;
	SetXP(oSpeaker, newXP);
}