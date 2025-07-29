// i_temp_ac
/*
   Template for an Activate item script.
   This script will run each time an item's "custom activation" is used.
   
   How to use this script:
   Item needs an item property that will cause a custom activation such as Cast Spell:Unique Power
   Replace the word "temp" (in line 1) with the tag of the item.  Rename the script with this name.  
    
   Additional Info:
   In general, all the item "tag-based" scripts will be named as follows:
   - a prefix ("i_" by defualt)
   - the tag of the item
   - a postfix indicating the item event.
   
   This script will be called automatically (by defualt) whether it exists or not.  If if does not exist, nothing happens.
   
   Note: this script runs on the module object, an important consideration for assigning actions.
      -ChazM
*/
// Name_Date
#include "ginc_debug"
const int STR_REF_MONSTER_INTERRUPT			= 207061; // "A nearby enemy has interrupted your rest."
const float MONSTER_SEARCH_DIST = 40.0f;

int GetNearbyEnemies(object oObjectToCheck)
{
	object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, MONSTER_SEARCH_DIST, GetLocation(oObjectToCheck));
	{
		if(GetIsEnemy(oCreature, oObjectToCheck))
			return TRUE;
			
		oCreature = GetNextObjectInShape(SHAPE_SPHERE, MONSTER_SEARCH_DIST, GetLocation(oObjectToCheck));
	}
	return FALSE;
}

void AdvanceTime(object oPC, int nHours)
{
	int nCurrentHour = GetTimeHour();
	int nNewHour;

	nNewHour = nCurrentHour + nHours;
	
	if ( nNewHour > 23 )
		nNewHour -= 24;
	
	SetTime(nNewHour, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());
	
}

void DoForceRest(int bAllPartyMembers)
{
	//object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?GetItemActivator():GetPCSpeaker());
	
    if ( bAllPartyMembers == 0 )
		ForceRest(oPC);
    else
    {
        object oTarget = GetFirstFactionMember(oPC, FALSE);
        while(GetIsObjectValid(oTarget))
        {
            ForceRest(oTarget);
			
            oTarget = GetNextFactionMember(oPC, FALSE);
        }
    }
	
	int nHours = 8;
	
	if(GetHasFeat(FEAT_TW_GROUP_TRANCE, oPC, TRUE))	//Group Trance halves the amount of time required for the party to rest.
		nHours /= 2;
		
	AdvanceTime(oPC, nHours);
}

int GetIsFactionInCombat(object oPC)
{
	object oFM = GetFirstFactionMember(oPC, FALSE);
	while (GetIsObjectValid(oFM))
	{
		if(GetIsInCombat(oFM))
			return TRUE;
			
		oFM = GetNextFactionMember(oPC, FALSE);
	}
	
	return FALSE;
}
void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();

	if(GetIsOverlandMap(GetArea(oPC)) == FALSE)
	{
		if(GetIsFactionInCombat(oPC) == FALSE)
		{
			if(GetNearbyEnemies(oPC) == FALSE)
			{
				AssignCommand(oPC, ClearAllActions());
				
							
				object oArea = GetArea(oPC);
				string sSound = "al_cv_guitarstrum_0";
				int nSound = Random(8) + 1;
				sSound += IntToString(nSound);
			
				float fDelay = IntToFloat(GetSoundFileDuration(sSound)) / 1000.0f; //Converting milliseconds to seconds.
				PrettyDebug(FloatToString(fDelay));
				
				PrettyDebug(sSound);
				
				AssignCommand(oPC, PlaySound(sSound, TRUE ));
				AssignCommand(oArea, DelayCommand(fDelay + 1.0f, MusicBackgroundPlay(oArea)));
				
				MusicBackgroundStop(GetArea(oPC));
				FadeToBlack(oPC, FADE_SPEED_FAST, 0.0f );
				DelayCommand(fDelay, FadeFromBlack(oPC));
				DelayCommand(fDelay, DoForceRest(TRUE));
				DestroyObject(oItem, fDelay);
				
				return;
			}
		}
	}
	
	SendMessageToPCByStrRef(oPC, STR_REF_MONSTER_INTERRUPT);
}