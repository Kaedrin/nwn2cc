////////////////////////////////////////
// XE-Ryder KoJ's NPC Barmaid OnSpawn //
////////////////////////////////////////
/*  This script has evolved over time and been greatly revised.
    Proper credit goes to David Gaider for the idea and original,
    then we have to credit Adam Miller for working it a bit better.
    This is where I got it and customized it quite a bit further. If
    someone else had a hand in this I am unawares, I pass it to you,
    the reader to enjoy.

    You do not have to use this code for the OnSpawn handler so long
    as the script you DO use in this event has the Hearbeat and OnDialogue
    events uncommented. WalkWayPoints() is optional and if you place numbered
    waypoints it may cause the barmaid to behave a bit odd. Enjoy! XE :-) */

#include "alg_text_barmaid"	
#include "NW_I0_GENERIC"
void main()
{
SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
SetListeningPatterns();
//WalkWayPoints();

 //SetListenPattern(OBJECT_SELF, BARMAID1, 2001);
// SetListenPattern(OBJECT_SELF, BARMAID2, 2002);
 SetListenPattern(OBJECT_SELF, "****", 0);
}