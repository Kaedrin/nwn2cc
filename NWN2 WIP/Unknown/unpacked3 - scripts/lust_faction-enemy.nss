// lust_faction-enemy
/*
    This script makes the speaking character be viewed differently by 
	the faction of this NPC.*/

void main()
{
	AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
}