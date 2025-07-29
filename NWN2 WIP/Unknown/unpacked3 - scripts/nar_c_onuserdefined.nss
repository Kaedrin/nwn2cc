// nar_c_onuseddefined

// Handles battle cries.

// Narks - 24 Dec 2010

#include "NW_I0_GENERIC"

void main()
{
	int nUser = GetUserDefinedEventNumber(); 
	
	// NW_FLAG_PERCIEVE_EVENT
	if (nUser == 1002) 
	{
		object oLastPerceived = GetLastPerceived();
		if (GetIsObjectValid(oLastPerceived))
		{
			if (GetLastPerceptionSeen() && GetIsEnemy(oLastPerceived))
			{
				// Pick a random battle cry.
				int nBattleCryCount = GetLocalInt(OBJECT_SELF, "BattleCryCount");
				string sBattleCryIndex = IntToString(1 
					+ Random(nBattleCryCount));
				string sBattleCry = GetLocalString(OBJECT_SELF,
					"BattleCry" + sBattleCryIndex);
			
				if (sBattleCry != "")
				{
					// Sighting an enemy causes ClearAllActions to be called.
					// DelayCommand is a way around this.
					DelayCommand(0.0f, ActionSpeakString(sBattleCry));
				}
				
				// We no longer need the percieve user event, as we
				// only shout battle cry once.
				SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT, FALSE);
			}
		}
	}
}