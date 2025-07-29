//Author: Xeneize
//Copyrights Dalelands Beyond Scripting Team
//Description: Script for a stripper NPC dancer.


//Goes on creature's OnHeartbeat. Works as long as people do not talk to NPC

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

void main()
{

object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

if (IsInConversation(OBJECT_SELF) || GetIsInCombat()) return;

ActionPlayAnimation(27);

}