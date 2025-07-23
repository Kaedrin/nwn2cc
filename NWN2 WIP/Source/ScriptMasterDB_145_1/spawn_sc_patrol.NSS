//
//   NESS
//   Patrol Scripts v8.1.3 
// 
//
#include "spawn_functions"
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
void main()
{
    // Retrieve Script Number
    int nPatrolScript = GetLocalInt(OBJECT_SELF, "PatrolScript");

    // Retrieve Stop Information
    int nStopNumber = GetLocalInt(OBJECT_SELF, "PR_NEXTSTOP");
    object oStop = GetLocalObject(OBJECT_SELF, "PR_SN" + PadIntToString(nStopNumber, 2));

    // Invalid Script
    if (nPatrolScript == -1)
    {
        return;
    }

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Script 00
    if (nPatrolScript == 0)
    {
        ActionDoCommand(SpeakString("Example!"));
    }
    //

    // Turn Off Lights
		//this should make the npc bend over at the waist
			 if (nPatrolScript == 2)
			 {
			 ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 6.0f);
				}
				
				//this should make the NPC get something low
			if (nPatrolScript == 3)
			{
			ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 6.0f);
		    }	
				//this should make the salute
			if (nPatrolScript == 4)
			{
			ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE);
		    }	
    if (nPatrolScript == 7)
    {
        object oLight = GetNearestObjectByTag("Light", oStop);
        if ((GetIsDay() == TRUE && GetPlaceableIllumination(oLight) == TRUE)
         || (GetIsNight() == TRUE && GetPlaceableIllumination(oLight) == FALSE))
        {
            ActionDoCommand(DoPlaceableObjectAction(oLight, PLACEABLE_ACTION_USE));
        }
	//for children playing tag
		 if (nPatrolScript == 8)
    {
        ActionDoCommand(SpeakString("Can't catch me!"));
    }
	 if (nPatrolScript == 9)
    {
        ActionDoCommand(SpeakString("Hey!"));
    }
	 if (nPatrolScript == 10)
    {
        ActionDoCommand(SpeakString("No fair wait up!"));
    }
		 if (nPatrolScript == 11)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_LOOKLEFT, 1.0f,6.0f);
    }
		 if (nPatrolScript == 12)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0f,6.0f);
    }
		 if (nPatrolScript == 13)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0f,6.0f);
    }
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

}