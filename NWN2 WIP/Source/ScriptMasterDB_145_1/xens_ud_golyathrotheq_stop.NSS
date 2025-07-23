//Author: Xeneize
//Will check if PC has quest active.

//Goes on creature's OnHeartbeat. Fires when not fighting or talking.
void main()
{

object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

if (IsInConversation(OBJECT_SELF) || GetIsInCombat()) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYxenq_ud_uuthli");

if (nInt < 861261)
   return;

ActionForceFollowObject(oPC);

}
